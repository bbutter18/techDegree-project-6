//
//  SwapAPIClient.swift
//  iOS API Awakens App
//
//  Created by Woodchuck on 10/17/18.
//  Copyright © 2018 Treehouse Island. All rights reserved.
//

import Foundation


class SwapAPIClient {

    lazy var baseURL: URL = {
    
        return URL(string: "https://swapi.co/api/")!
    }()
    
    let downloader = JSONDownloader()
    
    typealias JSON = [[String: Any]]
    typealias JSONTaskCompletionHandler = (JSON?, SWAPError?) -> Void
    
    func retrieveSWJson(with endpoint: endpointDetails, completionHandler completion: @escaping JSONTaskCompletionHandler) {
    
        guard let url = URL(string: endpoint.description, relativeTo: baseURL) else {
            completion(nil, .invalidURL)
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = downloader.jsonTask(with: request) { json, error in
            
            DispatchQueue.main.async {

            guard let json = json else {
                completion(nil, error)
                return
            }
            
            guard let results = json["results"] as? [[String: Any]] else {
                    completion(nil, .jsonParsingFailure(message: "JSON data does not contain results"))
                    return
                }
                
            completion(results, nil)
            }
        }
        task.resume()
        
    }
    
    func retrieveHomeworldInfo(with url: String, completionHanlder completion: @escaping ([String: Any]) -> Void) {
        
        let request = URLRequest(url: URL(string: url)!)
        
        let task = downloader.jsonTask(with: request) { json, error in

            guard let json = json else {
                return
            }
            completion(json)
        }
        task.resume()
    }
    
}







