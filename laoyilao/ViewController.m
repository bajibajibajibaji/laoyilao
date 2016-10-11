//
//  ViewController.m
//  laoyilao
//
//  Created by cc on 16/7/29.
//  Copyright © 2016年 cc. All rights reserved.
//

#import "ViewController.h"
#import "FBLaoYiLaoViewController.h"
#import "FBMyBoatSwichViewController.h"
#import "FBNaviBaseViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    FBLaoYiLaoViewController *laoYiLaoVC = [[FBLaoYiLaoViewController alloc] init];
    laoYiLaoVC.fbTabBarImage = [UIImage imageNamed:@"c8 get"];
    laoYiLaoVC.title = @"捞一捞";
    
    FBNaviBaseViewController *laoYiLaoVC2 = [[FBNaviBaseViewController alloc] init];
    laoYiLaoVC2.fbTabBarImage = [UIImage imageNamed:@"c8 bottle"];
    laoYiLaoVC2.title = @"我的瓶子";
    laoYiLaoVC2.view.backgroundColor = [UIColor redColor];
    
    FBNaviBaseViewController *laoYiLaoVC3 = [[FBNaviBaseViewController alloc] init];
    laoYiLaoVC3.fbTabBarImage = [UIImage imageNamed:@"c8 Cabin"];
    laoYiLaoVC3.title = @"我的船舱";
    laoYiLaoVC3.view.backgroundColor = [UIColor blueColor];
    
    FBNaviBaseViewController *laoYiLaoVC4 = [[FBNaviBaseViewController alloc] init];
    laoYiLaoVC4.fbTabBarImage = [UIImage imageNamed:@"c8 Salvage log"];
    laoYiLaoVC4.title = @"打捞记录";
    laoYiLaoVC4.view.backgroundColor = [UIColor whiteColor];
    
    
    FBMyBoatSwichViewController *boatswitchVC =  [[FBMyBoatSwichViewController alloc]init];
    boatswitchVC.viewControllers = @[laoYiLaoVC, laoYiLaoVC2, laoYiLaoVC3, laoYiLaoVC4];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = [[UINavigationController alloc]initWithRootViewController:boatswitchVC];;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
