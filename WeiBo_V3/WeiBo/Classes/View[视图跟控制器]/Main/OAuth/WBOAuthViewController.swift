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
        view.backgroundColor = UIColor.white()
        
        title = "登录新浪微博"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", normalColor:UIColor.black(), highlightedColor: UIColor.orange(), target: self, action: #selector(close))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
    }

    @objc private func close(){
                dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
