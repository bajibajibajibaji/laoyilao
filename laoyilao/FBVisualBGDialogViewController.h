//
//  FBVisualBGDialogViewController.h
//  visual
//
//  Created by cc on 16/7/20.
//  Copyright © 2016年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBVisualBGDialogViewController : UIViewController

/** 顶部图片 */
@property (strong, nonatomic) UIImage *goodsImage;

/** 标题 */
@property (copy,   nonatomic) NSString           *titleText;
@property (strong, nonatomic) UIColor            *titleTextColor;
@property (strong, nonatomic) UIFont             *titleFont;
@property (assign, nonatomic) NSTextAlignment     titleTextAlignment;  // 默认NSTextAlignmentCenter
@property (copy,   nonatomic) NSAttributedString *attributedTitleText; // 覆盖titleText属性

/** 内容 */
@property (copy,   nonatomic) NSString           *contentText;
@property (strong, nonatomic) UIColor            *contentTextColor;
@property (strong, nonatomic) UIFont             *contentFont;
@property (assign, nonatomic) NSTextAlignment     contentTextAlignment;  // 默认NSTextAlignmentCenter
@property (copy,   nonatomic) NSAttributedString *attributedContentText; // 覆盖contentText属性

- (void)addButton:(UIButton *)button;

@end
