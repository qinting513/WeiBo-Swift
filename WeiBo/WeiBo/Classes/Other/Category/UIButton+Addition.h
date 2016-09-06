//
//  UIButton+Addition.h
//  WeiBo
//
//  Created by Qinting on 16/9/6.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Addition)

/**
 *   创建文本按钮
 *
 *  @param title                显示的标题
 *  @param fontSize         字体大小
 *  @param normalColor      默认颜色
 *  @param highlightedColor 高亮颜色
 *
 *  @return UIButton
 */
+ (instancetype)qt_textButton:(NSString*)title fontSize:(CGFloat)fontSize normalColor:(UIColor*)normalColor highlightedColor:(UIColor *)highlightedColor;


/**
 *   创建文本按钮
 *
 *  @param title                显示的标题
 *  @param fontSize         字体大小
 *  @param normalColor      默认颜色
 *  @param highlightedColor 高亮颜色
 *  @param backgroundImageName 背景图片
 *
 *  @return UIButton
 */
+ (instancetype)qt_textButton:(NSString*)title fontSize:(CGFloat)fontSize normalColor:(UIColor*)normalColor highlightedColor:(UIColor *)highlightedColor backgroundImageName:(NSString *)backgroundImageName;

/**
 *  创建图像按钮
 *
 *  @param imageName           图像名称
 *  @param backgroundImageName 背景图像名称
 *
 *  @return UIButton
 */
+ (instancetype)qt_imageButton:(NSString *)imageName  backgroundImageName:(NSString *)backgroundImageName;

@end
