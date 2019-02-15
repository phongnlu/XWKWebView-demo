//
//  SafariExtensionViewController.swift
//  XWkWebViewDemo.safariExtension
//
//  Created by plu on 2/15/19.
//  Copyright © 2019 plu. All rights reserved.
//

import SafariServices
import WebKit
import XWKWebView

class SafariExtensionViewController: SFSafariExtensionViewController, WKNavigationDelegate {
    
    static let shared: SafariExtensionViewController = {
        let shared = SafariExtensionViewController()
        shared.preferredContentSize = NSSize(width:320, height:240)
        return shared
    }()

    var webView : WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.preferredContentSize = NSMakeSize(800, 600)
        webView = WKWebView(frame: self.view.frame)
        self.view.addSubview(webView)
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false;
        
        let height = NSLayoutConstraint(item: webView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: webView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1, constant: 0)
        self.view.addConstraints([height,width])                
        
        // Uncomment this to test loading html from local
        /*if let url = Bundle.main.url(forResource: "index", withExtension: "html") {
         webView.loadFileURL(url, allowingReadAccessTo: Bundle.main.resourceURL!)
         }*/
        
        // Uncomment this to test loading html from remote
        webView.load(URLRequest(url: URL(string: "http://127.0.0.1:8888/index.html")!))
        
        let xwebview = XWKWebView(webView);
        xwebview.registerPlugin(LocalFilePlugin(), namespace: "localFilePlugin")
        xwebview.registerPlugin(AnotherPlugin(), namespace: "anotherPlugin")
    }
}
