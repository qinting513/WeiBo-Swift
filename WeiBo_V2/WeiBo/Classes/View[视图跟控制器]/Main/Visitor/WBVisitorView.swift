//
//  WBVisitorView.swift
//  WeiBo
//
//  Created by Qinting on 16/9/7.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import UIKit

///访客视图
class WBVisitorView: UIView {
    
    //MARK: - 构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    注册按钮
     lazy var registerBtn : UIButton = UIButton(title: "注册",
                                                       normalColor: UIColor.orange(),
                                                       highlightedColor: UIColor.black(),
                                                       backgroundImageName: "common_button_white_disable",
                                                       target: nil,
                                                       action: nil)!
    //    登录按钮
     lazy var loginBtn : UIButton = UIButton(title: "登录",
                                                    normalColor: UIColor.orange(),
                                                    highlightedColor: UIColor.black(),
                                                    backgroundImageName: "common_button_white_disable",
                                                    target: nil,
                                                    action: nil)!
    
    //MARK: - 设置访客视图信息  如果是首页，是空字符串
    var visitorInfo : [String:String]? {
        didSet{
            guard let imageName = visitorInfo?["imageName"], message = visitorInfo?["message"] else{
                   return
            }
            tipLabel.text = message
            if imageName == "" {
                startAnimation()
                return
            }
            iconView.image = UIImage(named: imageName)
            houseIconView.isHidden = true
            maskIconView.isHidden = true
        }
    }

//    旋转动画
    private func startAnimation(){
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.duration = 15
        anim.toValue = 2*M_PI
        anim.repeatCount = MAXFLOAT
        //完成后不删除，如果iconView被释放，动画会一起销毁，要在添加到图层之前设置
        anim.isRemovedOnCompletion = false
       iconView.layer.add(anim, forKey: nil)


    }
    
    //    懒加载属性只有调用UIKit控件的时候指定控件构造函数，其他都需要使用类型
    //    图像视图
    private lazy var iconView : UIImageView = UIImageView(image: UIImage(named:"visitordiscover_feed_image_smallicon"))
    //遮罩
    private lazy var maskIconView : UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
    //    小房子  visitordiscover_feed_mask_smallicon
    private lazy var houseIconView : UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
    //    提示标签
    private lazy var tipLabel : UILabel = UILabel(withText: "关注一些人，回这里看看有什么惊喜，关注一些人，回这里看看有什么惊喜",
                                                  fontSize: 14, color: UIColor.darkGray())!    
}

extension WBVisitorView {
    
    func setupUI() {
        
        self.backgroundColor  = UIColor.lightGray()
        addSubview(iconView)
        addSubview(maskIconView)
        addSubview(houseIconView)
        addSubview(tipLabel)
        addSubview(registerBtn)
        addSubview(loginBtn)
        tipLabel.textAlignment = .center
        //        autoresizing 跟autoLayout不能共存,xib默认是用autoLayout
        //        1，要先取消autoresizing
        for v in subviews {
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        
        //        2.自动布局
        //图像
        addConstraint(NSLayoutConstraint(item: iconView,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerX,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: iconView,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerY,
                                         multiplier: 1.0,
                                         constant: -60))
        //遮罩图片
        //        addConstraint(NSLayoutConstraint(item: maskIconView,
        //                                         attribute: .centerX,
        //                                         relatedBy: .equal,
        //                                         toItem: self,
        //                                         attribute: .centerX,
        //                                         multiplier: 1.0,
        //                                         constant: 0))
        //        addConstraint(NSLayoutConstraint(item: maskIconView,
        //                                         attribute: .centerY,
        //                                         relatedBy: .equal,
        //                                         toItem: self,
        //                                         attribute: .centerY,
        //                                         multiplier: 1.0,
        //                                         constant: -60))
        
        //小房子
        addConstraint(NSLayoutConstraint(item: houseIconView,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: iconView,
                                         attribute: .centerX,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: houseIconView,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: iconView,
                                         attribute: .centerY,
                                         multiplier: 1.0,
                                         constant: -10)) // -20表示往上移动
        let margin : CGFloat  = 20.0
        //提示标签
        addConstraint(NSLayoutConstraint(item: tipLabel,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: iconView,
                                         attribute: .centerX,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: tipLabel,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: iconView,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: margin)) // 20表示往下 移动
        addConstraint(NSLayoutConstraint(item: tipLabel,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1.0,
                                         constant: 236))
        
        //注册按钮
        addConstraint(NSLayoutConstraint(item: registerBtn,
                                         attribute: .left,
                                         relatedBy: .equal,
                                         toItem: tipLabel,
                                         attribute: .left,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: registerBtn,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: tipLabel,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: margin)) // 20表示往下 移动
        addConstraint(NSLayoutConstraint(item: registerBtn,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1.0,
                                         constant: 100))
        
        //登录按钮
        addConstraint(NSLayoutConstraint(item:loginBtn,
                                         attribute: .right,
                                         relatedBy: .equal,
                                         toItem: tipLabel,
                                         attribute: .right,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: loginBtn,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: tipLabel,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: margin)) // 20表示往下 移动
        addConstraint(NSLayoutConstraint(item: loginBtn,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1.0,
                                         constant: 100))
        
        //遮罩图片
        //views : 定义VFL 中控件名称跟实际名称映射关系
        // metrics : 定义VFL中 （）指定的常数映射关系
        let viewDict = ["maskIconView" : maskIconView,"registerBtn":registerBtn]
        let metrics = ["spacing":-150]
        addConstraints(NSLayoutConstraint.constraints(
                                                    withVisualFormat: "H:|-0-[maskIconView]-0-|",
                                                    options: [],
                                                    metrics: nil,
                                                    views: viewDict))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-0-[maskIconView]-(spacing)-[registerBtn]",
            options: [],
            metrics: metrics,
            views: viewDict))
    }
    
    
}
