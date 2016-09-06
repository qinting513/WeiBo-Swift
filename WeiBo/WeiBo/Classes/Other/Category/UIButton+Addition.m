//
//  UIButton+Addition.m
//  WeiBo
//
//  Created by Qinting on 16/9/6.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "UIButton+Addition.h"

@implementation UIButton (Addition)

+ (instancetype)qt_textButton:(NSString *)title fontSize:(CGFloat)fontSize normalColor:(UIColor *)normalColor highlightedColor:(UIColor *)highlightedColor{
    UIButton *btn = [self qt_textButton:title fontSize:fontSize normalColor:normalColor highlightedColor:highlightedColor backgroundImageName:nil backgroundHighlightImageName:nil];
    return btn;
}

+ (instancetype)qt_textButton:(NSString*)title fontSize:(CGFloat)fontSize normalColor:(UIColor*)normalColor highlightedColor:(UIColor *)highlightedColor backgroundImageName:(NSString *)backgroundImageName  backgroundHighlightImageName:(NSString *)bgHighlightImageName{
    UIButton *b = [UIButton buttonWithType:0];
    [b setTitle:title forState:UIControlStateNormal];
    b.titleLabel.font = [ UIFont systemFontOfSize:fontSize];
    [b setTitleColor:normalColor forState:UIControlStateNormal];
    [b setTitleColor:highlightedColor forState:UIControlStateHighlighted];
//    b.backgroundColor = [UIColor redColor];
//    设置尺寸
    [b sizeToFit];
    [b  setBackgroundImage:[UIImage imageNamed:backgroundImageName] forState:UIControlStateNormal];
    [b  setBackgroundImage:[UIImage imageNamed:bgHighlightImageName] forState:UIControlStateHighlighted];
    return b;
}

+ (instancetype)qt_imageButton:(NSString *)imageName  highlightedImageName:(NSString *)highlightedImageName {
    return  [self qt_imageButton:imageName highlightedImageName:nil backgroundImageName:highlightedImageName bgHighlightedImageName:nil];
}

+ (instancetype)qt_imageButton:(NSString *)imageName  highlightedImageName:(NSString *)highlightedImageName backgroundImageName:(NSString *)backgroundImageName  bgHighlightedImageName:(NSString *)bgHighlightedImageName{
    UIButton *b = [UIButton buttonWithType:0];
    [b setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [b setImage:[UIImage imageNamed:highlightedImageName] forState:UIControlStateHighlighted];
    //    设置尺寸
    [b sizeToFit];
    [b setBackgroundImage:[UIImage imageNamed:backgroundImageName] forState:UIControlStateNormal];
    [b setBackgroundImage:[UIImage imageNamed:bgHighlightedImageName] forState:UIControlStateHighlighted];
    return b;
}
@end
