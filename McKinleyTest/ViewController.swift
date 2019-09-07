//
//  ViewController.swift
//  McKinleyTest
//
//  Created by Swati Wadhera on 07/09/19.
//  Copyright © 2019 Swati Wadhera. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var emailTF : UITextField!
    @IBOutlet weak var passwordTF : UITextField!
    
    let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginBtnClicked(_ sender : UIButton) {
        sender.showLoadingIndicator()
        if let email = emailTF.text, let password = passwordTF.text {
            viewModel.login(email, password, completion: { success, errorMsg in
                DispatchQueue.main.async {
                    sender.hideLoadingIndicator()
                }
                
                if success {
                    DispatchQueue.main.async {
                        sender.hideLoadingIndicator()
                        self.performSegue(withIdentifier: "showWebview", sender: nil)
                    }
                } else {
                    if let error = errorMsg {
                        self.showAlert(withMessage: error, title: "Error")
                    }
                }
            })
        }
    }
    
    // MARK: - Keyboard Notifications -
    @objc func keyboardWillShow(_ notification : NSNotification) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
//            contactDetailTVBottomConstraint.constant = -(keyboardHeight)
//            contactDetailTV.updateConstraintsIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ notification : NSNotification) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//        contactDetailTVBottomConstraint.constant = 0
//        contactDetailTV.updateConstraintsIfNeeded()
    }
}

private typealias TextField = ViewController
extension TextField : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTF {
            passwordTF.becomeFirstResponder()
            return false
        }
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string == "\n" {
            textField.resignFirstResponder()
            return false
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}


