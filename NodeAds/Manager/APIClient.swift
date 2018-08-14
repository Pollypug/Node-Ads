//
//  APIClient.swift
//  NodeAds
//
//  Created by Polina on 8/11/18.
//  Copyright © 2018 Polina. All rights reserved.
//

import Foundation

class APIClient {
    
    private func composeRequest(parameter: String,
                                completion: @escaping ((_ message: String?) -> Void)) -> URLRequest{
        
        let baseUrl = URL(string: "https://public-api.nazk.gov.ua/v1/declaration/")
        var request = URLRequest(url: baseUrl!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var body = ["q": parameter, "batchSize": 30000000] as! [String: Any]
        
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
                print("request composed")
            } catch let error {
                print(error.localizedDescription)
                completion(error.localizedDescription)
            }
        
        return request
    }
    
     func search(by parameter: String, completion: @escaping((_ message: String, _ personData: PersonInfo? ) -> ())) {
        
        var endpoint = composeRequest(parameter: parameter) { (message) in
            if let message = message, message != ""  {
                completion(message, nil)
            }
        }
        endpoint.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: endpoint) { (data: Data?, response: URLResponse?, error: Error?) in
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let personData = try decoder.decode(PersonInfo.self, from: data)

               completion("success", personData)
                
            } catch {
                completion("Could not perform request. Try later.", nil)
                print(error)
            }
            
        }
        task.resume()
    }
    
}
