//
//  ViewController.swift
//  Networking.Demo
//
//  Created by Art Arriaga on 2/13/20.
//  Copyright © 2020 ArturoArriaga.IO. All rights reserved.
//


import SwiftUI
import SDWebImage

class RootCollectionViewController: UICollectionViewController {
//MARK: Properties
    var movieResults = [Result]()
    var harryPotterResults = [Result]()
    var lordOfTheRingsResults = [Result]()
    
    let cellId = "cellid"
    override func viewDidLoad() {
        super.viewDidLoad()
        setupApperance()
        fetchDataAsynchronously()
        collectionView.register(MovieViewCell.self, forCellWithReuseIdentifier: MovieViewCell.reuseIdentifier)
        collectionView.register(HeaderLabelCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderLabelCell.reuseIdentifier)
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
    fileprivate func fetchDataAsynchronously() {
        let dispathGroup = DispatchGroup()
        
        dispathGroup.enter()
        Service.shared.fetchDataFromiTunesApi { (resp) in
            self.movieResults = resp ?? []
            dispathGroup.leave()
        }
        
        dispathGroup.enter()
        Service.shared.fetchHarryPotterData { (resp) in
            self.harryPotterResults = resp ?? []
            dispathGroup.leave()
        }
        
        dispathGroup.enter()
        Service.shared.fetchLordofRingsData { (resp) in
            self.lordOfTheRingsResults = resp ?? []
            dispathGroup.leave()
        }
        
        dispathGroup.notify(queue: .main) {
            self.collectionView.reloadData()
        }
    }
}


//MARK: Delegate and DataSource
extension RootCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderLabelCell.reuseIdentifier, for: indexPath) as! HeaderLabelCell
        if indexPath.section == 0 {
            headerCell.label.text = "Star Wars"
        } else if indexPath.section == 1 {
            headerCell.label.text = "Harry Potter"
        } else {
            headerCell.label.text = "Lord of the Rings"
        }
        return headerCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieViewCell.reuseIdentifier, for: indexPath) as! MovieViewCell
        switch indexPath.section {
        case 0:
            let movie = self.movieResults[indexPath.item]
            cell.movieResult = movie
        case 1:
            let movie = self.harryPotterResults[indexPath.item]
            cell.movieResult = movie
        default:
            let movie = self.lordOfTheRingsResults[indexPath.item]
            cell.movieResult = movie
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return movieResults.count
        } else if section == 1 {
            return harryPotterResults.count
        } else {
            return lordOfTheRingsResults.count
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
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
