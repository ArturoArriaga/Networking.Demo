//
//  ViewController.swift
//  Networking.Demo
//
//  Created by Art Arriaga on 2/13/20.
//  Copyright © 2020 ArturoArriaga.IO. All rights reserved.
//


import SwiftUI

class CompositionalController: UICollectionViewController {
//MARK: Properties
    var movieResults = [Result]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupApperance()
        fetchData()
        collectionView.register(MovieViewCell.self, forCellWithReuseIdentifier: MovieViewCell.reuseIdentifier)
    }
    
    init() {
        let layout = UICollectionViewCompositionalLayout { (sectionNumber, _) -> NSCollectionLayoutSection? in
            return CompositionalController.configureLayout()
        }
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
//MARK: Layout
extension CompositionalController {

    static func configureLayout() -> NSCollectionLayoutSection {
        // The item becomes the cell.
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
         item.contentInsets = .init(top: 10, leading: 0, bottom: 10, trailing: 10)
        // The group becomes all the cells of the section.
        let group = NSCollectionLayoutGroup.horizontal(layoutSize:
            .init(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(200)), subitems: [item])
        //The section becomes an individual group of items. A collection view can have multiple sections for a more complex layout. A compositional layout removes the need for the popular Nested CollecitonViewController architecture.
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets.leading = 20
        return section
    }
}

//MARK: Networking
extension CompositionalController {
    fileprivate func fetchData() {
        let urlString = "https://itunes.apple.com/search?term=starwars&entity=movie"
        guard let url = URL(string: urlString) else { return }
        
        //Actual data fetch with URLSession
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            //Updates the main thread with data.
            DispatchQueue.main.async {
                if let err = err {
                    print("Failed to fetch apps:", err)
                    return
                }
                
                guard let data = data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    let searchResult = try decoder.decode(iTunesSearchResult.self, from: data)
                    self.movieResults = searchResult.results
                    
                    //MARK: See console for data.
                    print(searchResult.results)
                } catch let jsonErr {
                    print("Failed to decode json:", jsonErr)
                }
            }
        }.resume()
    }
}

//MARK: Delegate and DataSource
//TODO: Implement Diffable Data Source.
extension CompositionalController {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieViewCell.reuseIdentifier, for: indexPath) as! MovieViewCell
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
}

//MARK: Apperance
extension CompositionalController {
    fileprivate func setupApperance() {
        self.navigationItem.title = "Amazing Movies"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.collectionView.backgroundColor = .systemBackground
    }
}



//MARK: Setup Canvas
struct CompositionalController_Previews: PreviewProvider {
    static var previews: some View {
        CompositionalControllerView()
            .edgesIgnoringSafeArea(.all)
            .colorScheme(.dark)
        
    }
}

struct CompositionalControllerView: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<CompositionalControllerView>) -> UIViewController {
        let controller = CompositionalController()
        return UINavigationController(rootViewController: controller)
        
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<CompositionalControllerView>) {
        
    }
}
