//
//  AnotherPlugin.swift
//  XWKWebViewDemo.macOS
//
//  Created by plu on 2/14/19.
//  Copyright © 2019 plu. All rights reserved.
//

import Foundation
import XWKWebView

public class AnotherPlugin: NSObject {
    @objc func delay(_ payload: AnyObject?, _ promise: XWKWebViewPromise) {
        print("AnotherPlugin delay payload: \(payload)")
        print("Delaying 5s...")
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            print("getOSInfo: \(self.getOSInfo())")
            promise.resolve("{\"data\": \" OS Info: \(self.getOSInfo()) \"}")
        }
    }
    
    func getOSInfo()->String {
        let os = ProcessInfo().operatingSystemVersion
        return String(os.majorVersion) + "." + String(os.minorVersion) + "." + String(os.patchVersion)
    }
}
