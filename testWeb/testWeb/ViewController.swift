//
//  ViewController.swift
//  testWeb
//
//  Created by MeR on 16/9/28.
//  Copyright © 2016年 com.hh-medic. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKUIDelegate, WKNavigationDelegate
{
        /// 跳转 safari 按钮
    @IBOutlet weak var safariBtn: UIButton!
        /// 清除缓存 按钮
    @IBOutlet weak var clearBtn: UIButton!
        /// 测试 网址
    let webURL = "https://www.baidu.com"
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
    private func setupUI()
    {
        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height))
        view.addSubview(webView)
        view.bringSubview(toFront: safariBtn)
        view.bringSubview(toFront: clearBtn)
        
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        webView.load(URLRequest(url: URL(string: webURL)!))
    }
    
    
    private func clearWKWebViewCache()
    {
        // iOS9开始提供了清理WKWebView的API
        let version = UIDevice.current.systemVersion
        guard let aVersion = Double(version), aVersion > 9.0 else { return }
        
        let websiteDataTypes = Set([WKWebsiteDataTypeDiskCache,
                                    WKWebsiteDataTypeMemoryCache,
                                    WKWebsiteDataTypeOfflineWebApplicationCache,
                                    WKWebsiteDataTypeCookies,
                                    WKWebsiteDataTypeSessionStorage,
                                    WKWebsiteDataTypeLocalStorage,
                                    WKWebsiteDataTypeWebSQLDatabases,
                                    WKWebsiteDataTypeIndexedDBDatabases])
        
        let date = Date(timeIntervalSince1970: 0)
        WKWebsiteDataStore.default().removeData(ofTypes: websiteDataTypes, modifiedSince: date, completionHandler: {})
    }
    
    
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void)
    {
        // 此代理中实现这个 解决网页某些点击不跳转的问题（跨域跳转问题）
        if navigationAction.targetFrame == nil
        {
            webView.load(navigationAction.request)
        }
        
        // 判断 request的类型
        let requestType = navigationAction.navigationType
        switch requestType
        {
            case .backForward: print("backForward")
            case .formResubmitted: print("formResubmitted")
            case .formSubmitted: print("formSubmitted")
            case .linkActivated: print("linkActivated")
            case .reload: print("reload")
            case .other: print("other")
        }
        
        decisionHandler(.allow)
    }
    
    
    @IBAction func clickJumpToSafari(_ sender: UIButton)
    {
        guard let url = URL(string: webURL) else { return }
        UIApplication.shared.open(url)
    }
    
    
    @IBAction func clickClearCache(_ sender: UIButton)
    {
        clearWKWebViewCache()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}




