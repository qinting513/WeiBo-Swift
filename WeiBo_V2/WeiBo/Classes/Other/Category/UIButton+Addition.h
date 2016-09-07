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
 *  @param normalColor      默认字体颜色
 *  @param highlightedColor 高亮字体颜色
 *
 *  @return UIButton
 */
+ (instancetype)qt_textButton:(NSString*)title fontSize:(CGFloat)fontSize normalColor:(UIColor*)normalColor highlightedColor:(UIColor *)highlightedColor;


/**
 *   创建文本按钮
 *
 *  @param title                显示的标题
 *  @param fontSize         字体大小
 *  @param normalColor      默认字体颜色
 *  @param highlightedColor 高亮字体颜色
 *  @param backgroundImageName 背景图片
 *  @param bgHighlightImageName 背景高亮时的图片
 *
 *  @return UIButton
 */

+ (instancetype)qt_textButton:(NSString*)title fontSize:(CGFloat)fontSize normalColor:(UIColor*)normalColor highlightedColor:(UIColor *)highlightedColor backgroundImageName:(NSString *)backgroundImageName  backgroundHighlightImageName:(NSString *)bgHighlightImageName;


/**
 *  创建图像按钮
 *
 *  @param imageName           图像名称
 *  @param backgroundImageName 背景图像名称
 *
 *  @return UIButton
 */
+ (instancetype)qt_imageButton:(NSString *)imageName  highlightedImageName:(NSString *)highlightedImageName;

+ (instancetype)qt_imageButton:(NSString *)imageName  highlightedImageName:(NSString *)highlightedImageName backgroundImageName:(NSString *)backgroundImageName  bgHighlightedImageName:(NSString *)bgHighlightedImageName;

@end
