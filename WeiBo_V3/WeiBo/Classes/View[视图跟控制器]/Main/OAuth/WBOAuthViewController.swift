//
//  WBOAuthViewController.swift
//  WeiBo
//
//  Created by Qinting on 16/9/8.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import UIKit
import SVProgressHUD
//通过webView登录
class WBOAuthViewController: UIViewController {

    private lazy var webView = UIWebView()
    
    override func loadView() {
        view = webView
        webView.delegate = self
        webView.scrollView.isScrollEnabled = false
        view.backgroundColor = UIColor.white()
        
        title = "登录新浪微博"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", normalColor:UIColor.black(), highlightedColor: UIColor.orange(), target: self, action: #selector(close))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "自动填充", style: .plain, target: self, action: #selector(autoFill))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
   let urlStr = "https://api.weibo.com/oauth2/authorize?redirect_uri=\(WBRedirectURI)&client_id=\(WBAppKey)"
        guard let url = URL.init(string: urlStr)  else {
             return
        }
        webView.loadRequest(URLRequest.init(url: url))
    }

    @objc private func close(){
                SVProgressHUD.dismiss()
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
    
    /// 是否加载request
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        //确认思路
        //1.如果请求地址包含 http://baidu.com 不加载页面 ／ 否则加载页面
        //        print("加载请求---\(request.url?.absoluteString)")

        if request.url?.absoluteString?.hasPrefix(WBRedirectURI) == false {
                return true
        }
        //2. 如果回调地址的 '查询' 字符串中查找 'code='  query 就是URL中 ‘？’后面的所有部分
        if request.url?.query?.hasPrefix("code=" )  == false{
        print("取消授权")
            close()
            return false
        }
           //3.如果有 则授权成功，如果没有授权失败
        //来到此处 url中肯定包含 ‘ code ＝’
        let code = request.url?.absoluteString?.substring(from:"code".endIndex)  ?? ""
     //4.用授权码获取accessToken
        WBNetworkManager.shared.loadAccessToken(code: code)
       
        return true
    }

    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
    }

    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    func webView(_ webView: UIWebView, didFailLoadWithError error: NSError?) {
        SVProgressHUD.dismiss()
    }
}
