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

    @IBOutlet weak var invokeJsBtn: UIButton!
    
    private var xwebview: XWKWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 100), configuration: WKWebViewConfiguration())
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
        
        invokeJsBtn.addTarget(self, action: #selector(self.invokeJsBtnClicked), for: .touchUpInside)
    }
    
    @objc func invokeJsBtnClicked(_ sender:UIButton!) {
        let anotherPlugin = AnotherPlugin()
        let nativePayload = "native payload - iOS info: \(anotherPlugin.getOSInfo())"
        
        xwebview?.invokeJs("invokeFromNative(\"\(nativePayload)\")",
            onSuccess: { payload in
                print("invokeJs onSuccess payload: \(payload)")
            },
            onFailure: { error in
                print("invokeJs onFailure error: \(error)")
            })
    }
}

