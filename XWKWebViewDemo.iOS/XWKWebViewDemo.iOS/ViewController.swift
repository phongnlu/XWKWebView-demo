//
//  ViewController.swift
//  XWKWebViewDemo.iOS
//
//  Created by plu on 2/14/19.
//  Copyright © 2019 plu. All rights reserved.
//

import UIKit
import WebKit
import XWKWebView

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let webView = WKWebView(frame: view.frame, configuration: WKWebViewConfiguration())
        webView.scrollView.bounces = false
        view.addSubview(webView)
        
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

