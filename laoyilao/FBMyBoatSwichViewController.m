//
//  FBMyBoatSwichViewController.m
//  FBMyBoatSwichController
//
//  Created by 朱志先 on 16/7/29.
//  Copyright © 2016年 朱志先. All rights reserved.
//

#import "FBMyBoatSwichViewController.h"
#import "UIColor+FBHexColor.h"

@interface FBMyBoatSwichViewController ()

@end

@implementation FBMyBoatSwichViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setTabBarStyle];
    }
    return self;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self setTabBarStyle];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self setTabBarStyle];
    }
    return self;
}

- (void)setTabBarStyle
{
    [self.tabBar setBackgroundImage:[UIImage new]];
    [self.tabBar setShadowImage:[UIImage new]];
//    self.tabBar.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:(UIBarButtonItemStylePlain) target:self action:@selector(pop)];
}

- (void)pop
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor UIColorFromHex:0x086A8F];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:(UIBarMetricsDefault)];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor UIColorFromHex:0x086A8F]}];
    self.navigationItem.title = self.selectedViewController.title;
}

- (void)viewWillLayoutSubviews
{
    CGFloat ratio = [UIScreen mainScreen].bounds.size.width / 414.0;
    CGFloat tabCenterX = self.tabBar.center.x;
    CGRect tabFrame = self.tabBar.frame; //self.TabBar is IBOutlet of your TabBar
    tabFrame.size.height = 100 * ratio;
    tabFrame.size.width = 300 * ratio;
    tabFrame.origin.y = self.view.frame.size.height - 100 * ratio;
    self.tabBar.frame = tabFrame;
    CGPoint tabCenter = self.tabBar.center;
    tabCenter.x = tabCenterX;
    self.tabBar.center = tabCenter;
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
