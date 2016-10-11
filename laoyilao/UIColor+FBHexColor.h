//
//  UIColor+FBHexColor.h
//  SignUp
//
//  Created by 朱志先 on 16/7/18.
//  Copyright © 2016年 朱志先. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (FBHexColor)
+ (UIColor *)getColor:(NSString*)hexColor;
+ (UIColor*)UIColorFromHex:(NSInteger)colorInHex;
+ (UIColor*)UIColorFromHex:(NSInteger)colorInHex andAlpha:(CGFloat)alpha;
@end
