//
//  WebviewController.swift
//  McKinleyTest
//
//  Created by Swati Wadhera on 07/09/19.
//  Copyright © 2019 Swati Wadhera. All rights reserved.
//

import UIKit
import WebKit

class WebviewController: UIViewController, WKUIDelegate, WKNavigationDelegate {

    @IBOutlet weak var webview : WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let myURL = URL(string: "https://google.com")
        let myRequest = URLRequest(url: myURL!)
        webview.uiDelegate = self
        webview.navigationDelegate = self
        webview.load(myRequest)
        // Do any additional setup after loading the view.
    }
    
    // MARK: - WKWebview Delegate Methods -
    
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        AppLoader.showErrorIn(view: self.view, withMessage: "Web page could not be loaded")
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        let loader = AppLoader(frame: self.view.bounds)
        self.view.addSubview(loader)
        loader.showLoaderWithMessage("Loading Page...")
        
    }
    
    func webView(_ webView: WKWebView,
                 didFail navigation: WKNavigation!,
                 withError error: Error)
    {
        AppLoader.showErrorIn(view: self.view, withMessage: "Web page could not be loaded")
    }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        AppLoader.hideLoaderIn(self.view)
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
