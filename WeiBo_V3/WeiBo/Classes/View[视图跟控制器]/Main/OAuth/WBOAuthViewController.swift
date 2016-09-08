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
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "自动填充", style: .plain, target: self, action: #selector(autoFill))
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
    
    /// 自动填充 － webView的注入 直接通过 js 修改‘本地浏览器中的缓存’的页面内容
    /// 点击登录 执行 submit（） 将本地数据提交给服务器  注意啊 有分号区别
    //js 语句一定要写对
    @objc private func autoFill() {
        let js = "document.getElementById('userId').value =  '906113907@qq.com' ; " + "document.getElementById('passwd').value = 'Chunwoaini7758'; "
        webView.stringByEvaluatingJavaScript(from: js)
    }

}

extension WBOAuthViewController : UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
    }

}
