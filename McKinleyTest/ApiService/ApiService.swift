//
//  ApiService.swift
//  McKinleyTest
//
//  Created by Swati Wadhera on 07/09/19.
//  Copyright © 2019 Swati Wadhera. All rights reserved.
//

import UIKit

public enum RequestType : String {
    case GET
}

public enum ResponseStatusCode : Int {
    case Success = 200
}

public enum AppError: Error {
    case badURL
}

class ApiService : NSObject {
    
    public typealias completionHandler = ( Result <Any, AppError> ) -> Void
    
    class func get(url : String, completion : @escaping completionHandler)
    {
        guard let urlString = URL(string : url) else {
            completion(.failure(.badURL))
            return
        }
        
        print("GET API Called - \(url)")
        
        var request = URLRequest(url: urlString)
        request.httpMethod = RequestType.GET.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            
            do {
                if error == nil {
                    let json = try JSONSerialization.jsonObject(with: data!)
                    print("GET API - \(url) Response - \(json)")
                    completion(.success(json))
                } else {
                    print("GET API - \(url) Error - \(error?.localizedDescription ?? "")")
                    completion(.failure(.badURL))
                }
            } catch {
                print("error")
                completion(.failure(.badURL))
            }
        })
        
        task.resume()
    }
}




