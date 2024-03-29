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
    @IBOutlet weak var fieldView : UIView!
    @IBOutlet weak var topConstraint : NSLayoutConstraint!
    let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginBtnClicked(_ sender : UIButton) {
        self.view.endEditing(true)
        
        if let email = emailTF.text, let password = passwordTF.text, validate() {
            sender.showLoadingIndicator()

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
    
    func validate() -> Bool {
        if let text = emailTF.text, !text.isEmpty {
            do {
                if try !Validate.Email(text) {
                    showAlert(withMessage: "Please enter a valid email", title: "Error")
                    return false
                }
            } catch {
                showAlert(withMessage: "Please enter a valid email", title: "Error")
                return false
            }
        } else {
            showAlert(withMessage: "Email field cannot be empty", title: "Error")
            return false
        }
        if let text = passwordTF.text, text.isEmpty {
            showAlert(withMessage: "Password field cannot be empty", title: "Error")
            return false
        }
        
        return true
    }
    
    // MARK: - Keyboard Notifications -
    @objc func keyboardWillShow(_ notification : NSNotification) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            UIView.animate(withDuration: 0.5, animations: {
                self.topConstraint.constant = -keyboardHeight
            })
        }
    }
    
    @objc func keyboardWillHide(_ notification : NSNotification) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        UIView.animate(withDuration: 0.5, animations: {
            self.topConstraint.constant = 0
        })
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
}


