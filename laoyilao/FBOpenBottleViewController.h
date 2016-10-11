//
//  FBOpenBottleViewController.h
//  laoyilao
//
//  Created by cc on 16/8/2.
//  Copyright © 2016年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FBLaoYiLaoViewController;

@interface FBOpenBottleViewController : UIViewController

@property (strong, nonatomic) UIView *goodsView;

@property (assign, nonatomic) BOOL isGold;
@property (copy, nonatomic) void (^putInButtonAction)(UIButton *button);
@property (copy, nonatomic) void (^throwButtonAction)(UIButton *button);

@property (weak, nonatomic) FBLaoYiLaoViewController *lylVC;

- (void)escapeVCWithStoreAnim;
- (void)escapeVCWithGoldAnim;
- (void)escapeVCWithThrowingAnim;

@end
