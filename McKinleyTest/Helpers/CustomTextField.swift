//
//  UIButtonHelper.swift
//  McKinleyTest
//
//  Created by Swati Wadhera on 07/09/19.
//  Copyright © 2019 Swati Wadhera. All rights reserved.
//


import UIKit

import UIKit

@IBDesignable

class DesignableUITextField: UITextField {
    
    func leftViewFrame() -> CGRect {
        return CGRect(x: 0, y: 0, width: leftPadding, height: 0)
    }

    @IBInspectable var leftPadding: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    
    func updateView() {

        if leftPadding > 0 {
            leftViewMode = .always
            leftView = UIView(frame: leftViewFrame())
        } else {
            leftViewMode = UITextField.ViewMode.never
            leftView = nil
        }
    }
}
