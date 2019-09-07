//
//  LoginViewModel.swift
//  McKinleyTest
//
//  Created by Swati Wadhera on 07/09/19.
//  Copyright © 2019 Swati Wadhera. All rights reserved.
//

import UIKit

class LoginViewModel: NSObject {
    
    func login(completion : @escaping (Bool) -> ()) {
        
        let apiUrl = ApiList.login
        
        ApiService.get(url: apiUrl, completion: { result in
            switch result {
                
            case .success(let response):
                if let list = response as? NSDictionary {
                    
                } else {
                    completion(false)
                }
            case .failure(let error):
                completion(false)
                print(error.localizedDescription)
            }
        })
    }
    
}
