//
//  ViewController.swift
//  Networking.Demo
//
//  Created by Art Arriaga on 2/13/20.
//  Copyright © 2020 ArturoArriaga.IO. All rights reserved.
//


import SwiftUI

class CompositionalController: UICollectionViewController {
    
    var movieResults = [Result]()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        self.collectionView.backgroundColor = .white
        
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
//                    self.tableView.reloadData()
                } catch let jsonErr {
                    print("Failed to decode json:", jsonErr)
                }
            }
        }.resume()
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
