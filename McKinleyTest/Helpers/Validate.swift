//
//  Validate.swift
//  McKinleyTest
//
//  Created by Swati Wadhera on 07/09/19.
//  Copyright © 2019 Swati Wadhera. All rights reserved.
//

import UIKit

class Validate: NSObject {
    
    static func Email(_ text : String) throws -> Bool {
        if text.count == 0 { return false }
        
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        _ = try NSRegularExpression(pattern: regex, options: [.caseInsensitive])
        let test = NSPredicate(format:"SELF MATCHES %@", regex)
        return test.evaluate(with: text)
    }
}
