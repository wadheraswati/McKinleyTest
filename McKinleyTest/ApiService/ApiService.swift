//
//  ApiService.swift
//  McKinleyTest
//
//  Created by Swati Wadhera on 07/09/19.
//  Copyright © 2019 Swati Wadhera. All rights reserved.
//

import UIKit

public enum RequestType : String {
    case POST
}

public enum ResponseStatusCode : Int {
    case Success = 200
}

public enum AppError: Error {
    case badURL
    case apiFailure
}

class ApiService : NSObject {
    
    public typealias completionHandler = ( Result <Any, AppError>, String? ) -> Void
    
    class func post(url : String, parameters: [String : Any], completion : @escaping completionHandler)
    {
        guard let urlString = URL(string : url) else {
            completion(.failure(.badURL), nil)
            return
        }
        
        print("POST API Called - \(url)")
        
        var request = URLRequest(url: urlString)
        request.httpMethod = RequestType.POST.rawValue
        request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            
            do {
                if error == nil {
                    if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == ResponseStatusCode.Success.rawValue {
                        let json = try JSONSerialization.jsonObject(with: data!)
                        print("POST API - \(url) Response - \(json)")
                        completion(.success(json), nil)
                    } else {
                        if let json = try JSONSerialization.jsonObject(with: data!) as? NSDictionary, let errorText = json.value(forKey: "error") as? String {
                        print("POST API - \(url) Response - \(json)")
                            completion(.failure(.apiFailure), errorText )
                        } else {
                            completion(.failure(.apiFailure), nil)
                        }
                    }
                } else {
                    print("POST API - \(url) Error - \(error?.localizedDescription ?? "")")
                    completion(.failure(.apiFailure), error?.localizedDescription)
                }
            } catch {
                print("error")
                completion(.failure(.apiFailure), error.localizedDescription)
            }
        })
        
        task.resume()
    }
}




