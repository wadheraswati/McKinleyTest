//
//  UIButtonHelper.swift
//  McKinleyTest
//
//  Created by Swati Wadhera on 07/09/19.
//  Copyright © 2019 Swati Wadhera. All rights reserved.
//

import UIKit

extension UIButton {
    
    func showLoadingAnimation() {
        UIView.animate(withDuration: 0.33, animations: {
            self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }, completion: {(success) in
            UIView.animate(withDuration: 0.15, animations: {
                self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }, completion: {(success) in
                UIView.animate(withDuration: 0.25, animations: {
                    self.transform = CGAffineTransform(scaleX: 1, y: 1)
                }, completion: nil)
            })
        })
    }
    
    func showLoadingIndicator() {
        if self.viewWithTag(12345) == nil {
            self.titleLabel?.removeFromSuperview()
            self.imageView?.removeFromSuperview()
            let loader = UIActivityIndicatorView(style: .white)
            loader.frame = self.bounds
            loader.tag = 12345
            loader.startAnimating()
            self.addSubview(loader)
        }
    }
    
    func hideLoadingIndicator() {
        if let loader = self.viewWithTag(12345) as? UIActivityIndicatorView {
            loader.removeFromSuperview()
        }
        
        if let label = self.titleLabel {
            self.addSubview(label)
        }
        if let imageView = self.imageView {
            self.addSubview(imageView)
        }
    }
}
