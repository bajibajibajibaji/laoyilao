//
//  FBLaoYiLaoViewController.h
//  laoyilao
//
//  Created by cc on 16/7/29.
//  Copyright © 2016年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBNaviBaseViewController.h"

@interface FBLaoYiLaoViewController : FBNaviBaseViewController

- (CGRect)goldNumFrame;
- (void)goldNumChange:(NSInteger)num;
- (void)hideLaozi;
- (void)showLaozi;

@end
