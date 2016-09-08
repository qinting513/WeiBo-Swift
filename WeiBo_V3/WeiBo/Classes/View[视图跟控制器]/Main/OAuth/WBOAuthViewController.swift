//
//  WBOAuthViewController.swift
//  WeiBo
//
//  Created by Qinting on 16/9/8.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import UIKit

//通过webView登录
class WBOAuthViewController: UIViewController {

    private lazy var webView = UIWebView()
    
    override func loadView() {
        view = webView
        webView.delegate = self
        view.backgroundColor = UIColor.white()
        
        title = "登录新浪微博"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", normalColor:UIColor.black(), highlightedColor: UIColor.orange(), target: self, action: #selector(close))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
   let urlStr = "https://api.weibo.com/oauth2/authorize?redirect_uri=\(redirectURI)&client_id=\(AppKey)"
        guard let url = URL.init(string: urlStr)  else {
             return
        }
        webView.loadRequest(URLRequest.init(url: url))
    }

    @objc private func close(){
                dismiss(animated: true, completion: nil)
    }

}

extension WBOAuthViewController : UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
    }

}
