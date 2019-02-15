//
//  ViewController.swift
//  XWKWebViewDemo.macOS
//
//  Created by plu on 2/14/19.
//  Copyright © 2019 plu. All rights reserved.
//

import Cocoa
import WebKit
import XWKWebView

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.window?.setFrame(NSRect(x:0, y:0, width: 800, height: 600), display: true) 
        let webView = WKWebView(frame: view.frame, configuration: WKWebViewConfiguration())
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

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

