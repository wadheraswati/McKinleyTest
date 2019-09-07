//
//  LoginViewModel.swift
//  McKinleyTest
//
//  Created by Swati Wadhera on 07/09/19.
//  Copyright © 2019 Swati Wadhera. All rights reserved.
//

import UIKit

class LoginViewModel: NSObject {
    
    func login(_ email : String, _ password : String, completion : @escaping (Bool, String?) -> ()) {
        
        let apiUrl = ApiList.login
        let params :  [String : AnyObject] = [ApiParams.login.email : email as AnyObject, ApiParams.login.password : password as AnyObject]
        
        ApiService.post(url: apiUrl, parameters: params, completion: { result, errorMsg in
            switch result {
                
            case .success(let response):
                if let result = response as? NSDictionary {
                    let token = result.value(forKey: "token")
                    UserDefaults.standard.setValue(token, forKey: "token")
                    UserDefaults.standard.synchronize()
                    completion(true, nil)
                } else {
                    completion(false, nil)
                }
            case .failure(let error):
                if let errorText = errorMsg {
                    completion(false, errorText)
                } else {
                    completion(false, error.localizedDescription)
                }
                print(error.localizedDescription)
            }
        })
    }
    
}
