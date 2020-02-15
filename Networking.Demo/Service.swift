//
//  Service.swift
//  Networking.Demo
//
//  Created by Art Arriaga on 2/14/20.
//  Copyright © 2020 ArturoArriaga.IO. All rights reserved.
//

import Foundation

class Service {
    static let shared = Service()

        func fetchDataFromiTunesApi() {
            let urlString = "https://itunes.apple.com/search?term=starwars&entity=movie"
            guard let url = URL(string: urlString) else { return }
            
            //Actual data fetch with URLSession
            URLSession.shared.dataTask(with: url) { (data, resp, err) in
                    
                            if let err = err {
                                print("Failed to fetch apps:", err)
                                return
                            }

                            guard let data = data else { return }

                            do {
                                let decoder = JSONDecoder()
                                let searchResult = try decoder.decode(iTunesSearchResult.self, from: data)
                                print(searchResult.results)

                            } catch let jsonErr {
                                print("Failed to decode json:", jsonErr)
                            }
            }.resume()
        }
}
