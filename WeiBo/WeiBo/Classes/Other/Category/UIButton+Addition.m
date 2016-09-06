//
//  UIButton+Addition.m
//  WeiBo
//
//  Created by Qinting on 16/9/6.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "UIButton+Addition.h"

@implementation UIButton (Addition)


+(instancetype)qt_imageButton:(NSString *)imageName backgroundImageName:(NSString *)backgroundImageName{
    UIButton *b = [UIButton buttonWithType:0];
    [b setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [b setBackgroundImage:[UIImage imageNamed:backgroundImageName] forState:UIControlStateNormal];
    return b;
}
@end
