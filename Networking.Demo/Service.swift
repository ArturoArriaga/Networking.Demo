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
//TODO: Refactor. CODE IS NOT VERY DRY.
    
//MARK: Section 1 Fetch.
    //marked @escaping to prevent a retain cycle.
    func fetchDataFromiTunesApi(completion: @escaping ([Result]?)->()) {
        print("Getting data from the network.")
        let urlString = "https://itunes.apple.com/search?term=starwars&entity=movie"
        guard let url = URL(string: urlString) else { return }
        
        //Actual data fetch with URLSession
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            
            //Case: Failure. If failure occurs, catch the error and print to console.
            if let err = err {
                print("Failed to fetch apps:", err)
                //running the completion block with an empty array if an error occurs.
                completion(nil)
                return
            }
            
            //Case: Success. If successful, check the data and decode into the iTunesSearchResult object.
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let searchResult = try decoder.decode(iTunesSearchResult.self, from: data)
                completion(searchResult.results)
                
                //Decoding could potentially throw an error, so it must be caught if it occurs.
            } catch let jsonErr {
                print("Failed to decode json:", jsonErr)
                //running completing with an empty array if error occurs.
                completion(nil)
            }
        }.resume()
    }
    
//MARK: Section 2 Fetch.
    func fetchHarryPotterData(completion: @escaping ([Result]?)->()) {
        print("Getting data from the network.")
        let urlString = "https://itunes.apple.com/search?term=harrypotter&entity=movie"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                print("Failed to fetch apps:", err)
                completion(nil)
                return
            }
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let searchResult = try decoder.decode(iTunesSearchResult.self, from: data)
                completion(searchResult.results)
            } catch let jsonErr {
                print("Failed to decode json:", jsonErr)
                completion(nil)
            }
        }.resume()
    }
    
//MARK: Section 3 Fetch.
    func fetchLordofRingsData(completion: @escaping ([Result]?)->()) {
        print("Getting data from the network.")
        let urlString = "https://itunes.apple.com/search?term=lordoftherings&entity=movie"
        guard let url = URL(string: urlString) else { return }
        
        //Actual data fetch with URLSession
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                print("Failed to fetch apps:", err)
                completion(nil)
                return
            }
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let searchResult = try decoder.decode(iTunesSearchResult.self, from: data)
                completion(searchResult.results)
            } catch let jsonErr {
                print("Failed to decode json:", jsonErr)
                completion(nil)
            }
        }.resume()
    }
    
}
