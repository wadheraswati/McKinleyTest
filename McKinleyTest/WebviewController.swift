//
//  WebviewController.swift
//  McKinleyTest
//
//  Created by Swati Wadhera on 07/09/19.
//  Copyright © 2019 Swati Wadhera. All rights reserved.
//

import UIKit
import WebKit

class WebviewController: UIViewController {

    @IBOutlet weak var webview : WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let myURL = URL(string: "https://google.com")
        let myRequest = URLRequest(url: myURL!)
        webview.load(myRequest)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
