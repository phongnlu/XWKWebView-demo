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

    @IBOutlet weak var invokeJsBtn: NSButton!
    
    private var xwebview: XWKWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.window?.setFrame(NSRect(x:0, y:0, width: 800, height: 600), display: true)
        let webView = WKWebView(frame: NSRect(x: 0, y: 60, width: 800, height: 540), configuration: WKWebViewConfiguration())
        view.addSubview(webView)
        
        // Uncomment this to test loading html from local
        /*if let url = Bundle.main.url(forResource: "index", withExtension: "html") {
            webView.loadFileURL(url, allowingReadAccessTo: Bundle.main.resourceURL!)
        }*/
        
        // Uncomment this to test loading html from remote
        webView.load(URLRequest(url: URL(string: "http://127.0.0.1:8888/index.html")!))
        
        xwebview = XWKWebView(webView);
        xwebview?.registerPlugin(LocalFilePlugin(), namespace: "localFilePlugin")
        xwebview?.registerPlugin(AnotherPlugin(), namespace: "anotherPlugin")
        
        invokeJsBtn.target = self
        invokeJsBtn.action = #selector(self.invokeJsBtnClicked)
    }
    
    @objc func invokeJsBtnClicked() {
        let anotherPlugin = AnotherPlugin()
        let nativePayload = "native payload - macOS info: \(anotherPlugin.getOSInfo())"
        
        xwebview?.invokeJs("window.invokeFromNative(\"\(nativePayload)\")",
            onSuccess: { payload in
                print("invokeJs onSuccess payload: \(payload)")
            },
            onFailure: { error in
                print("invokeJs onFailure error: \(error)")
            })
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

