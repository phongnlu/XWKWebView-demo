//
//  LocalFilePlugin.swift
//  XWKWebViewDemo.macOS
//
//  Created by plu on 2/14/19.
//  Copyright © 2019 plu. All rights reserved.
//

import Foundation
import XWKWebView

public class LocalFilePlugin: NSObject {
    @objc func read(_ payload: AnyObject?, _ promise: XWKWebViewPromise) {
        print("LocalFilePlugin read payload: \(payload)")
        
        let bundle = Bundle.main
        let fileName = payload?["file"] as! String
        let fileExt = payload?["ext"] as! String
        
        guard let path = bundle.path(forResource: fileName, ofType: fileExt),
            var source = try? String(contentsOfFile: path, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) else {
                let err = "Failed to read file: \(fileName).\(fileExt)"
                print(err)
                promise.reject("{\"data\": \"\(err)\"}")
                return
        }
        if let sourceBase64Encoded = source.data(using: .utf8)?.base64EncodedString() {
            print(sourceBase64Encoded)
            promise.resolve("{\"data\": \"\(sourceBase64Encoded)\"}")
        } else {
            promise.reject("{\"data\": \"fail to base64 encode string\"}")
        }
    }
}
