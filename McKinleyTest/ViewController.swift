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
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginBtnClicked(_ sender : UIButton) {
        
        if let email = emailTF.text, let password = passwordTF.text {
            viewModel.login(email, password, completion: { success, errorMsg in
                if success {
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "showWebview", sender: nil)
                    }
                } else {
                    
                }
            })
        }
    }


}

