//
//  JSONDownloader.swift
//  iOS API Awakens App
//
//  Created by Woodchuck on 10/17/18.
//  Copyright © 2018 Treehouse Island. All rights reserved.
//

import Foundation
import UIKit

class JSONDownloader {

    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }

    typealias JSON = [String: AnyObject]
    typealias JSONTaskCompletionHandler = (JSON?, SWAPError?) -> Void
    
    func jsonTask(with request: URLRequest, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
        
        let task = session.dataTask(with: request) { data, response, error in
            
            if let urlError = error as? URLError {
                switch urlError.code {
                case .notConnectedToInternet:
                    self.displayAlertError(with: "Error", message: "No Internet Connection Available")
                
                case .networkConnectionLost:
                    self.displayAlertError(with: "Error", message: "Network Connection Lost")
                    
                default: break
                }
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed)
                return
            }
            
            if httpResponse.statusCode == 200 {
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject]
                        completion(json, nil)
                    } catch {
                        completion(nil, .jsonConversionFailure)
                    }
                } else {
                    completion(nil, .invalidData)
                }
            } else {
                completion(nil, .responseUnsuccessful)
            }
            
        }
        
        return task
    
    }

    func displayAlertError(with title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        alert.present(alert, animated: true, completion: nil)
    }


    func dataTask(with request: URLRequest, completionHandler completion: @escaping (Data?, SWAPError?) -> Void) -> URLSessionDataTask {
        
        let task = session.dataTask(with: request) { data, response, error in
            
            if let urlError = error as? URLError {
                switch urlError.code {
                case .notConnectedToInternet:
                    self.displayAlertError(with: "Error", message: "No Internet Connection Available")
                    
                case .networkConnectionLost:
                    self.displayAlertError(with: "Error", message: "Network Connection Lost")
                    
                default: break
                }
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed)
                return
            }
            
            if httpResponse.statusCode == 200 {
                if let data = data {
                    completion(data, nil)
                } else {
                    completion(nil, .invalidData)
                }
            } else {
                completion(nil, .responseUnsuccessful)
            }
            
        }
        
        return task
        
    }




    











}









