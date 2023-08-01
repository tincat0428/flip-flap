//
//  HelpViewController.swift
//  App
//
//  Created by shine on 2023/6/16.
//

import Foundation
import UIKit
import WebKit

class HelpViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
    var wkView : WKWebView!
    private var popWebView: WKWebView?
    
    override func loadView() {
        let wkPreferences = WKPreferences()
        wkPreferences.javaScriptEnabled = true
        wkPreferences.javaScriptCanOpenWindowsAutomatically = true
        let wkConfiguration = WKWebViewConfiguration()
        wkConfiguration.preferences = wkPreferences
        wkConfiguration.websiteDataStore = WKWebsiteDataStore.nonPersistent()
        wkView = WKWebView(frame: .zero, configuration: wkConfiguration)
        wkView.uiDelegate = self
        wkView.navigationDelegate = self
        view = wkView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // wkView must be loaded here, otherwise uploading pictures on the deposit page will not work
        let settings = Bundle.main.infoDictionary?["AppSettings"] as! [AnyHashable: Any]
        let env = settings["UseEnv"] as! String
        var helpURL = URL(string: "https://www.apple.com")
        switch env {
        case "2":  //dev
            helpURL = URL(string: "https://devipa.1win118.net/m")
        case "0":  //sta
            helpURL = URL(string: "https://ipa.1win118.net/m")
        case "1":  //prod
            helpURL = URL(string: "https://www.c336688.net/m")
        default:
            helpURL = URL(string: "https://www.apple.com")
        }
        if let openURL = helpURL {
            let request = URLRequest(url: openURL)
            wkView.load(request)
            wkView.allowsBackForwardNavigationGestures = true
        }
    }
    
    //另開視窗一 target="_blank"開啟分頁的解法
    //WKNavigationDelegate 在發送請求之前，決定是否跳轉
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.navigationType == .linkActivated  {
            if let url = navigationAction.request.url,
                UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
                //print(url)
                decisionHandler(.cancel)
                return
            }
        }
        
        //.allow 是預設的行為
        decisionHandler(.allow)
    }
    
    //另開視窗二 window.open開啟分頁的解法
    //WKUIDelegate 創建一個新的webView
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {

        //開網址－用瀏覽器開啟
        if let url = navigationAction.request.url,
            UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
            return nil
        }

        //包iframe要這樣開
        popWebView = WKWebView(frame: self.wkView.frame, configuration: configuration)
        popWebView?.tag = 321
        popWebView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        popWebView?.navigationDelegate = self
        popWebView?.uiDelegate = self
        if let newWebView = popWebView {
            view.addSubview(newWebView)
            //print("View Count: \(view.subviews.count)")
            return popWebView ?? nil
        }
        
        return nil
    }
    
    func webViewDidClose(_ webView: WKWebView) {
        webView.removeFromSuperview()
        popWebView = nil
    }
}
