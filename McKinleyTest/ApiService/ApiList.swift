//
//  ApiList.swift
//  McKinleyTest
//
//  Created by Swati Wadhera on 07/09/19.
//  Copyright © 2019 Swati Wadhera. All rights reserved.
//

import UIKit

class ApiList: NSObject {

    static let baseUrl = "https://reqres.in/api/"
    
    static let login = ApiList.baseUrl + "login"
}

class ApiParams {
    
    struct login {
        static let email = "email"
        static let password = "password"
    }
}

