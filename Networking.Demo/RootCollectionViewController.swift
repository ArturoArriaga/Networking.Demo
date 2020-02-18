//
//  ViewController.swift
//  Networking.Demo
//
//  Created by Art Arriaga on 2/13/20.
//  Copyright © 2020 ArturoArriaga.IO. All rights reserved.
//


import SwiftUI

class RootCollectionViewController: UICollectionViewController {
//MARK: Properties
    var movieResults = [Result]()
    let cellId = "cellid"
    override func viewDidLoad() {
        super.viewDidLoad()
        setupApperance()
        fetchData()
        configureDiffableDataSource()

        collectionView.register(MovieViewCell.self, forCellWithReuseIdentifier: cellId)
//        collectionView.register(HeaderLabelCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderLabelCell.reuseIdentifier)
    }
    
    enum MovieSection {
        case starWars
        case harryPotter
        case lordOfTheRings
    }
    
    lazy var diffableDataSource: UICollectionViewDiffableDataSource<MovieSection, Result> = .init(collectionView: self.collectionView) { (collectionView, indexPath, Result) -> UICollectionViewCell? in
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellId, for: indexPath) as! MovieViewCell
        cell.movieResult = Result
        
        return cell
    }
    
    init() {
        
        //New compositional layout introduced in iOS 13. The layout is configured using a section, group, item design pattern.
        let layout = UICollectionViewCompositionalLayout { (sectionNumber, _) -> NSCollectionLayoutSection? in
            return RootCollectionViewController.configureLayout()
        }
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureDiffableDataSource() {
        collectionView.dataSource = diffableDataSource
        
        var snapshot = diffableDataSource.snapshot()
        snapshot.appendSections([.starWars])
        snapshot.appendItems([
            Result(artistName: "help", shortDescription: "love", trackName: "", trackRentalPrice: 2.1, artistId: 123)
        ], toSection: .starWars)
        diffableDataSource.apply(snapshot)
        
    }

}
//MARK: Compositional Layout
/* Introduced in iOS 13, the compositional layout allows developers to design a layout without having to use nested view controllers. Since layout is formed by this viewcontroller, all sections can be accessed by the same navigation controller.*/
extension RootCollectionViewController {
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
        
        // The section has the following property that can be configured to provide a header.
        let headerKind = UICollectionView.elementKindSectionHeader
        section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40)), elementKind: headerKind, alignment: .topLeading)]
        return section
    }
}

//MARK: Networking
//TODO: Move into singleton class. 
extension RootCollectionViewController {
    fileprivate func fetchData() {
//        Service.shared.fetchDataFromiTunesApi()
        Service.shared.fetchDataFromiTunesApi { (resp) in
            self.movieResults = resp
            //UI must be update on the main thread. This puts us back on the main thread.
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
        }
    }
}

//MARK: Diffable Data Source
extension RootCollectionViewController {

}


//MARK: Delegate and DataSource
//TODO: Implement Diffable Data Source.
extension RootCollectionViewController {
//    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        let headerCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderLabelCell.reuseIdentifier, for: indexPath) as! HeaderLabelCell
//        return headerCell
//    }
    
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieViewCell.reuseIdentifier, for: indexPath) as! MovieViewCell
//        let movie = self.movieResults[indexPath.item]
//        cell.movieResult = movie
//        return cell
//    }
    
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        movieResults.count
//    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        0
    }
    
}

//MARK: Apperance
extension RootCollectionViewController {
    fileprivate func setupApperance() {
        self.navigationItem.title = "Amazing Movies"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.collectionView.backgroundColor = .systemBackground
        self.collectionView.isScrollEnabled = true
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
        let controller = RootCollectionViewController()
        return UINavigationController(rootViewController: controller)
        
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<CompositionalControllerView>) {
        
    }
}
