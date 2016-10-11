//
//  FBNaviBaseViewController.m
//  FBMyBoatSwichController
//
//  Created by 朱志先 on 16/7/29.
//  Copyright © 2016年 朱志先. All rights reserved.
//

#import "FBNaviBaseViewController.h"
#import "UIColor+FBHexColor.h"
#import "UIImage+ImageRendering.h"

@interface FBNaviBaseViewController ()

@end

@implementation FBNaviBaseViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self customNavigationBar];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self customNavigationBar];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self customNavigationBar];
    }
    return self;
}

- (void)customNavigationBar
{
    CGFloat ratio = [UIScreen mainScreen].bounds.size.width / 414;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:(UIBarButtonItemStylePlain) target:self action:@selector(pop)];
    self.view.backgroundColor = [UIColor colorWithRed:35.0f/255.0f green:205.0f/255.0f blue:250.0f/255.0f alpha:1.0f];
    [self.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName : [UIFont systemFontOfSize:12 * ratio weight:0.7]} forState:(UIControlStateSelected)];
    [self.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor UIColorFromHex:0x086A8F], NSFontAttributeName : [UIFont systemFontOfSize:12 * ratio weight:0.7]} forState:(UIControlStateNormal)];
    self.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -8 * ratio);

}

- (void)pop
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor UIColorFromHex:0x086A8F];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:(UIBarMetricsDefault)];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor UIColorFromHex:0x086A8F]}];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.navigationItem.title = self.title;
}

- (void)setFbTabBarImage:(UIImage *)fbTabBarImage
{
    CGFloat ratio = [UIScreen mainScreen].bounds.size.width / 414;
    _fbTabBarImage = [fbTabBarImage imageWithRoundCornerAndSize:CGSizeMake(ratio * 60, ratio * 60) andCornerRadius:0];
    self.tabBarItem.image = [_fbTabBarImage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
//    
//    if (!self.fbTabBarSelectedImage) {
//        [self setFbTabBarSelectedImage:fbTabBarImage];
//    }
}

- (void)setFbTabBarSelectedImage:(UIImage *)fbTabBarSelectedImage
{
    CGFloat ratio = [UIScreen mainScreen].bounds.size.width / 414;
    _fbTabBarSelectedImage= [fbTabBarSelectedImage imageWithRoundCornerAndSize:CGSizeMake(ratio * 60 , ratio * 60) andCornerRadius:0];
    self.tabBarItem.selectedImage = [_fbTabBarSelectedImage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
//    
//    if (!self.fbTabBarImage) {
//        [self setFbTabBarImage:fbTabBarSelectedImage];
//    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
