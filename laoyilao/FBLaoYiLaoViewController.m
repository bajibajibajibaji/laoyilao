//
//  FBLaoYiLaoViewController.m
//  laoyilao
//
//  Created by cc on 16/7/29.
//  Copyright © 2016年 cc. All rights reserved.
//

#import "FBLaoYiLaoViewController.h"
#import "constant.h"
#import "CALayer+FBAnimation.h"
#import "FBVisualBGDialogViewController.h"
#import "FBOpenBottleViewController.h"
#import "FBCoupon.h"

@interface FBLaoYiLaoViewController ()


/** 还剩捞一捞的次数 */
@property (assign, nonatomic) NSInteger laoyilaoNum;
@property (strong, nonatomic) UILabel *handNumLabel;

/** 上面金币数量 */
@property (assign, nonatomic) NSInteger goldNum;
@property (strong, nonatomic) UIImageView * goldNumImageView;
@property (strong, nonatomic) UICountingLabel *goldNumLabel;

@property (strong, nonatomic) UIImageView *laoziImageView;
@property (strong, nonatomic) UIImageView *laozipingziImageView;
@property (strong, nonatomic) UIImageView *goodsImageView;

@property (assign, nonatomic) BOOL laoziAnimIsStop;
@property (assign, nonatomic) BOOL laopingziAnimIsStop;

@property (strong, nonatomic) UIButton *immediately_openButton;
@property (strong, nonatomic) UIButton *put_inButton;
@property (strong, nonatomic) UIButton *one_moreButton;
@property (strong, nonatomic) UIButton *nextButton;

@property (assign, nonatomic) BOOL isHaveToy; // 是否捞出玩具

@end

@implementation FBLaoYiLaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self subInit];
    
    self.goldNum = 100;
    [self.goldNumLabel countFromCurrentValueTo:self.goldNum withDuration:0.5];
    
    self.laoyilaoNum = 3;
    self.handNumLabel.text = @"3";
}

- (void)subInit
{
    WS(ws);
    
    // 背景色
    self.view.backgroundColor = [UIColor colorWithRed:35.0f/255.0f green:205.0f/255.0f blue:250.0f/255.0f alpha:1.0f];
    
    // 金币数量
    self.goldNumImageView = imageViewOfAutoScaleImage(@"integral3.png");
    [self.view addSubview:self.goldNumImageView];
    self.goldNumImageView.layer.contentsCenter = CGRectMake(0.45, 0.2, 0.1, 0); // 9切片
    [self.goldNumImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@30.0f);
        make.top.mas_equalTo(ws.view).offset(64 * RATIO);
        make.right.mas_equalTo(ws.view).offset(-39 * RATIO);
    }];
    
    self.goldNumLabel = [[UICountingLabel alloc] init];
    [self.goldNumImageView addSubview:self.goldNumLabel];
    self.goldNumLabel.format = @"%ld";
    self.goldNumLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightRegular];
    self.goldNumLabel.numberOfLines = 1;
    self.goldNumLabel.text = @"0";
    [self.goldNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ws.goldNumImageView.mas_top);
        make.left.mas_equalTo(ws.goldNumImageView.mas_left).offset(30);
        make.bottom.mas_equalTo(ws.goldNumImageView.mas_bottom);
        make.right.mas_equalTo(ws.goldNumImageView.mas_right).offset(-20);
    }];
    
    // 背景波浪
    UIImageView *wave1ImageView = imageViewOfAutoScaleImage(@"c2 wave1.png");
    UIImageView *wave2ImageView = imageViewOfAutoScaleImage(@"c2 wave2.png");
    UIView *waveView = [[UIView alloc] init];
    waveView.backgroundColor = [UIColor colorWithRed:163/255.0 green:235/255.0 blue:252/255.0 alpha:1.0];
    
    [self.view addSubview:wave1ImageView];
    [self.view addSubview:wave2ImageView];
    [self.view addSubview:waveView];
    
    [wave1ImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 62.33*RATIO));
        make.centerX.mas_equalTo(ws.view);
        make.bottom.mas_equalTo(wave2ImageView.mas_top);
    }];
    
    [wave2ImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 74*RATIO));
        make.centerX.mas_equalTo(ws.view);
        make.bottom.mas_equalTo(waveView.mas_top);
    }];
    
    [waveView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 150*RATIO_V));
        make.centerX.mas_equalTo(ws.view);
        make.bottom.mas_equalTo(ws.view);
    }];
    
    // 左上角岛屿
    UIImageView *isLandImageView = imageViewOfAutoScaleImage(@"c2 island.png");
    [self.view addSubview:isLandImageView];
    [isLandImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(260*RATIO, 186*RATIO));
        make.top.mas_equalTo(ws.view).offset(94*RATIO);
        make.left.mas_equalTo(ws.view);
    }];
    
    // 光
    UIImageView *shineImageView = imageViewOfAutoScaleImage(@"c2 light.png");
    [self.view addSubview:shineImageView];
    [shineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(133*RATIO, 30*RATIO));
        make.top.mas_equalTo(isLandImageView);
        make.left.mas_equalTo(isLandImageView);
    }];
    
    [shineImageView.layer startChangeAlpha];
    
    // 气球
    UIImageView *ballonImageView = imageViewOfAutoScaleImage(@"c2 Balloon.png");
    [self.view addSubview:ballonImageView];
    [ballonImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(27*RATIO, 36*RATIO));
        make.top.mas_equalTo(ws.view).offset(120*RATIO);
        make.left.mas_equalTo(ws.view).offset(105*RATIO);
    }];
    
    [ballonImageView.layer startLinearAnimatonWithStartPoint:CGPointMake(-30, 0) AndEndPoint:CGPointMake(20, 20) IsBounce:YES duration:13 delay:0];
    
    UIImageView *ballon1ImageView = imageViewOfAutoScaleImage(@"c2 Balloon1.png");
    [self.view addSubview:ballon1ImageView];
    [ballon1ImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20*RATIO, 26*RATIO));
        make.top.mas_equalTo(ws.view).offset(145*RATIO);
        make.left.mas_equalTo(ws.view).offset(144*RATIO);
    }];
    
    [ballon1ImageView.layer startLinearAnimatonWithStartPoint:CGPointMake(-30, 0) AndEndPoint:CGPointMake(30, 5) IsBounce:YES duration:14 delay:1];
    
    // 云
    UIImageView *cloudImageView = imageViewOfAutoScaleImage(@"c2 cloud.png");
    [self.view addSubview:cloudImageView];
    [cloudImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(47*RATIO, 26*RATIO));
        make.top.mas_equalTo(ws.view).offset(110*RATIO);
        make.left.mas_equalTo(ws.view).offset(160*RATIO);
    }];
    
    [cloudImageView.layer startLinearAnimatonWithStartPoint:CGPointMake(-10, 0) AndEndPoint:CGPointMake(30, 0) IsBounce:YES duration:25 delay:1];
    
    UIImageView *cloud1ImageView = imageViewOfAutoScaleImage(@"c2 cloud1.png");
    [self.view addSubview:cloud1ImageView];
    [cloud1ImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(59*RATIO, 33*RATIO));
        make.top.mas_equalTo(ws.view).offset(145*RATIO);
        make.left.mas_equalTo(ws.view).offset(200*RATIO);
    }];
    
    [cloud1ImageView.layer startLinearAnimatonWithStartPoint:CGPointMake(-10, -10) AndEndPoint:CGPointMake(20, -10) IsBounce:YES duration:27 delay:0];
    
    // 鸟
    UIImageView *birdImageView = imageViewOfAutoScaleImage(@"c2 bird.png");
    [self.view insertSubview:birdImageView aboveSubview:wave1ImageView];
    [birdImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(37*RATIO, 19*RATIO));
        make.top.mas_equalTo(ws.view).offset(300*RATIO);
        make.left.mas_equalTo(ws.view).offset(300*RATIO);
    }];
    
    [birdImageView.layer startLinearAnimatonWithStartPoint:CGPointMake(-30, 0) AndEndPoint:CGPointMake(60, 0) IsBounce:YES duration:15 delay:0];
    
    UIImageView *bird1ImageView = imageViewOfAutoScaleImage(@"c2 bird1.png");
    [self.view insertSubview:bird1ImageView aboveSubview:birdImageView];
    [bird1ImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60*RATIO, 30*RATIO));
        make.top.mas_equalTo(ws.view).offset(400*RATIO);
        make.left.mas_equalTo(ws.view).offset(100*RATIO);
    }];
    
    [bird1ImageView.layer startLinearAnimatonWithStartPoint:CGPointMake(-60, 0) AndEndPoint:CGPointMake(60, 0) IsBounce:YES duration:13 delay:1];
    
    // 捞子
    self.laoziImageView = imageViewOfAutoScaleImage(@"c2 Fishing.png");
    [self.view insertSubview:self.laoziImageView aboveSubview:birdImageView];
    [self.laoziImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(223*RATIO, 232*RATIO));
        make.top.mas_equalTo(ws.view).offset(221*RATIO);
        make.left.mas_equalTo(ws.view).offset(115*RATIO);
    }];
    
    self.laoziImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *laoziImageViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHand)];
    laoziImageViewTap.numberOfTapsRequired = 1;
    laoziImageViewTap.numberOfTouchesRequired = 1;
    [self.laoziImageView addGestureRecognizer:laoziImageViewTap];
    
    // 捞子(带宝贝)
//    self.laozipingziImageView = imageViewOfAutoScaleImage(@"c2 Fishing1.png");
    self.laozipingziImageView = [[UIImageView alloc] init];
    self.laozipingziImageView.alpha = 0;
    [self.view insertSubview:self.laozipingziImageView aboveSubview:birdImageView];
    [self.laozipingziImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(223*RATIO, 232*RATIO));
        make.top.mas_equalTo(ws.view).offset(221*RATIO);
        make.left.mas_equalTo(ws.view).offset(115*RATIO);
    }];
    
    // 宝贝
    self.goodsImageView = [[UIImageView alloc] init];
    self.goodsImageView.alpha = 0;
    [self.view insertSubview:self.goodsImageView aboveSubview:birdImageView];
    [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(223*RATIO, 232*RATIO));
        make.top.mas_equalTo(ws.view).offset(221*RATIO);
        make.left.mas_equalTo(ws.view).offset(115*RATIO);
    }];
    
    // 立即打开 按钮
    self.immediately_openButton = [[UIButton alloc] init];
    self.immediately_openButton.layer.opacity = 0;
    [self.immediately_openButton setImage:imageOfAutoScaleImage(@"c2 open.png") forState:UIControlStateNormal];
    [self.immediately_openButton addTarget:self action:@selector(immediately_openbuttonPress) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:self.immediately_openButton aboveSubview:birdImageView];
    [self.immediately_openButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(71*RATIO, 25*RATIO));
        make.left.mas_equalTo(ws.laoziImageView);
        make.top.mas_equalTo(ws.laoziImageView.mas_bottom).offset(10 * RATIO);
    }];
    
    // 放进仓库 按钮
    self.put_inButton = [[UIButton alloc] init];
    self.put_inButton.alpha = 0;
    [self.put_inButton setImage:imageOfAutoScaleImage(@"c2 in.png") forState:UIControlStateNormal];
    [self.put_inButton addTarget:self action:@selector(put_inButtonPress) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:self.put_inButton aboveSubview:birdImageView];
    [self.put_inButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(71*RATIO, 25*RATIO));
        make.left.mas_equalTo(ws.immediately_openButton.mas_right).offset(10 * RATIO);
        make.top.mas_equalTo(ws.laoziImageView.mas_bottom).offset(10 * RATIO);
    }];
    
    // 再捞一次 按钮
    self.one_moreButton = [[UIButton alloc] init];
    self.one_moreButton.alpha = 0;
    [self.one_moreButton setImage:imageOfAutoScaleImage(@"c2 one more.png") forState:UIControlStateNormal];
    [self.one_moreButton addTarget:self action:@selector(one_moreButtonPress) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:self.one_moreButton aboveSubview:birdImageView];
    [self.one_moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(71*RATIO, 25*RATIO));
        make.left.mas_equalTo(ws.laoziImageView);
        make.top.mas_equalTo(ws.laoziImageView.mas_bottom).offset(10 * RATIO);
    }];
    
    // 下次再捞 按钮
    self.nextButton = [[UIButton alloc] init];
    self.nextButton.alpha = 0;
    [self.nextButton setImage:imageOfAutoScaleImage(@"c2 next2.png") forState:UIControlStateNormal];
    [self.nextButton addTarget:self action:@selector(nextButtonPress) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:self.nextButton aboveSubview:birdImageView];
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(71*RATIO, 25*RATIO));
        make.left.mas_equalTo(ws.immediately_openButton.mas_right).offset(10 * RATIO);
        make.top.mas_equalTo(ws.laoziImageView.mas_bottom).offset(10 * RATIO);
    }];
    
    // 捞子手
    UIImageView *handImageView = [[UIImageView alloc] init];
    handImageView.animationImages = @[imageOfAutoScaleImage(@"c8 click1.png"), imageOfAutoScaleImage(@"c8 click2.png")];
    handImageView.animationDuration = 1;
    handImageView.animationRepeatCount = 0;
    [self.view insertSubview:handImageView aboveSubview:birdImageView];
    [handImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.right.mas_equalTo(ws.view).offset(-40 * RATIO);
        make.bottom.mas_equalTo(ws.view).offset(-310 * RATIO);
    }];
    [handImageView startAnimating];
    
    handImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *handTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHand)];
    handTap.numberOfTapsRequired = 1;
    handTap.numberOfTouchesRequired = 1;
    [handImageView addGestureRecognizer:handTap];
    
    UILabel *handLabel = [[UILabel alloc] init];
    handLabel.textAlignment = NSTextAlignmentCenter;
    handLabel.text = @"点我打捞";
    handLabel.textColor = [UIColor colorWithRed:0 green:80/255.0 blue:100/255.0 alpha:1.0];
    handLabel.font = [UIFont boldSystemFontOfSize:14];
    [self.view insertSubview:handLabel aboveSubview:birdImageView];
    [handLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@70);
        make.centerX.mas_equalTo(handImageView.mas_centerX);
        make.top.mas_equalTo(handImageView.mas_bottom).offset(4 * RATIO);
    }];
    
    handLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *handLabelTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHand)];
    handLabelTap.numberOfTapsRequired = 1;
    handLabelTap.numberOfTouchesRequired = 1;
    [handLabel addGestureRecognizer:handLabelTap];
    
    // 捞子手中的数量
    self.handNumLabel = [[UILabel alloc] init];
    self.handNumLabel.textAlignment = NSTextAlignmentCenter;
//    self.handNumLabel.text = @"9";
    self.handNumLabel.textColor = [UIColor colorWithRed:255/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
    self.handNumLabel.font = [UIFont boldSystemFontOfSize:24];
    [handImageView addSubview:self.handNumLabel];
    [self.handNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(handImageView);
        make.top.mas_equalTo(handImageView).offset(16);
        make.right.mas_equalTo(handImageView).offset(-10);
    }];
}


#pragma mark --------------------------tap-------------------------------
- (void)tapHand
{
    if (self.laoyilaoNum > 0) {
        // 网络请求-----捞出的宝贝
        // test by cc
        static int index = 0;
        if (index %2 == 0) {
            self.isHaveToy = YES;
        } else {
            self.isHaveToy = NO;
        }
        index++;
        // test end
        
        if (self.isHaveToy) {
            self.laozipingziImageView.image = imageOfAutoScaleImage(@"c2 Fishing4.png");
            self.goodsImageView.image = imageOfAutoScaleImage(@"c2 bottle3.png");
        } else {
            self.laozipingziImageView.image = imageOfAutoScaleImage(@"c2 Fishing5.png");
        }
        
        [self laoyilaoAnim];
        
        self.laoyilaoNum--;
        self.handNumLabel.text = [NSString stringWithFormat:@"%ld", (long)self.laoyilaoNum];
    } else {
        FBVisualBGDialogViewController *laoyilaoVC = [[FBVisualBGDialogViewController alloc] init];
        laoyilaoVC.goodsImage = imageOfAutoScaleImage(@"c2 bottle.png");
        
        laoyilaoVC.titleText = @"没捞网了";
        laoyilaoVC.titleTextColor = [UIColor colorWithRed:10/255.0 green:62/255.0 blue:71/255.0 alpha:1.0];
        laoyilaoVC.titleFont = [UIFont systemFontOfSize:22 weight:UIFontWeightBold];
        
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:@"\n        亲~今天三个免费捞网已用完了，是否消费10漂贝再捞一次？"];
        [attrStr addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14.5]} range:NSMakeRange(0, attrStr.length)];
        [attrStr addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:208.0f/255 green:45.0f/255 blue:22.0f/255 alpha:1]} range:NSMakeRange(28, 2)];
        laoyilaoVC.attributedContentText = attrStr;
        laoyilaoVC.contentTextAlignment = NSTextAlignmentLeft;
        
        UIButton *okButton = [[UIButton alloc] init];
        [okButton setImage:imageOfAutoScaleImage(@"c2 ok.png") forState:UIControlStateNormal];
        [okButton addTarget:self action:@selector(okButtonPress) forControlEvents:UIControlEventTouchUpInside];
        [laoyilaoVC addButton:okButton];
        
        UIButton *nextTimeButton = [[UIButton alloc] init];
        [nextTimeButton setImage:imageOfAutoScaleImage(@"c2 next.png") forState:UIControlStateNormal];
        [nextTimeButton addTarget:self action:@selector(nextTimeButtonPress) forControlEvents:UIControlEventTouchUpInside];
        [laoyilaoVC addButton:nextTimeButton];
       
        [self presentViewController:laoyilaoVC animated:YES completion:nil];
    }
}

#pragma mark ------------------------button action-------------------------
- (void)immediately_openbuttonPress
{
    // 网络请求 打开瓶子
    BOOL isGold = NO;
    // test by cc
    static int index = 0;
    if (index %2 == 0) {
        isGold = YES;
    } else {
        isGold = NO;
    }
    index++;
    // test end
    
    FBCoupon *coupon = [[FBCoupon alloc] init];
    if (isGold) {
        coupon.couponType =FBCouponViewTypeCoin;
        coupon.coinNumber = 500;
    } else {
        coupon.couponType = FBCouponViewTypeCustomCoupon;
    }
    
    FBOpenBottleViewController *openBottleVC = [[FBOpenBottleViewController alloc] init];
    openBottleVC.goodsView = coupon;
    openBottleVC.isGold = isGold;
    openBottleVC.putInButtonAction = ^(UIButton *button){
        NSLog(@"putinButton");
    };
    openBottleVC.throwButtonAction = ^(UIButton *button){
        NSLog(@"throwButton");
    };
    openBottleVC.lylVC = self;
    
    [self presentViewController:openBottleVC animated:YES completion:nil];
    
    self.immediately_openButton.alpha = 0;
    self.put_inButton.alpha = 0;
    self.laoziImageView.alpha = 1;
    self.laozipingziImageView.alpha = 0;
}

- (void)put_inButtonPress
{
    WS(ws);
    
    self.immediately_openButton.alpha = 0;
    self.put_inButton.alpha = 0;
    self.laoziImageView.alpha = 1;
    self.laozipingziImageView.alpha = 0;
    
    self.goodsImageView.alpha = 1;
    CGPoint goodsCenter = self.goodsImageView.center;
    goodsCenter.y -= 50;
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        ws.goodsImageView.alpha = 0;
        ws.goodsImageView.center = goodsCenter;
    } completion:^(BOOL finished) {
        CGPoint tmp_goodsCenter = self.goodsImageView.center;
        tmp_goodsCenter.y += 50;
        ws.goodsImageView.center = tmp_goodsCenter;
    }];
}

- (void)one_moreButtonPress
{
    [self tapHand];
}

- (void)nextButtonPress
{
    self.laoziImageView.alpha = 1;
    self.laozipingziImageView.alpha = 0;
    self.one_moreButton.alpha = 0;
    self.nextButton.alpha = 0;
}

- (void)okButtonPress
{
    self.goldNum -= 10;
    [self.goldNumLabel countFromCurrentValueTo:self.goldNum withDuration:0.5];
    
    self.laoyilaoNum++;
    self.handNumLabel.text = [NSString stringWithFormat:@"%ld", (long)self.laoyilaoNum];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)nextTimeButtonPress
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ------------------anim---------------------
- (void)laoyilaoAnim
{
    self.laoziImageView.alpha = 1;
    self.laozipingziImageView.alpha = 0;
    self.immediately_openButton.alpha = 0;
    self.put_inButton.alpha = 0;
    self.one_moreButton.alpha = 0;
    self.nextButton.alpha = 0;
    
    
    // animaling
    CABasicAnimation *animInit = [CABasicAnimation animationWithKeyPath:@"position.y"];
    animInit.duration = 0.001;
    animInit.beginTime = 0;
    animInit.autoreverses = NO;
    animInit.toValue = [NSNumber numberWithFloat:self.laoziImageView.layer.position.y + 220*RATIO];
    animInit.removedOnCompletion = NO;
    animInit.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *animLeft = [CABasicAnimation animationWithKeyPath:@"position.x"];
    animLeft.duration = 0.25;
    animLeft.beginTime = 0;
    animLeft.autoreverses = YES;
    animLeft.toValue = [NSNumber numberWithFloat:self.laoziImageView.layer.position.x - 20];
    animLeft.removedOnCompletion = NO;
    animLeft.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *animRight = [CABasicAnimation animationWithKeyPath:@"position.x"];
    animRight.duration = 0.25;
    animRight.beginTime = 0.5;
    animRight.autoreverses = YES;
    animRight.toValue = [NSNumber numberWithFloat:self.laoziImageView.layer.position.x + 20];
    animRight.removedOnCompletion = NO;
    animRight.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *animLeft2 = [animLeft copy];
    animLeft2.beginTime = 1;
    
    CABasicAnimation *animUp = [CABasicAnimation animationWithKeyPath:@"position.y"];
    animUp.duration = 1;
    animUp.beginTime = 1.5 + 0.15;
    animUp.autoreverses = NO;
    animUp.toValue = [NSNumber numberWithFloat:self.laoziImageView.layer.position.y];
    animUp.removedOnCompletion = NO;
    animUp.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *animOpacity = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animOpacity.duration = 0.001;
    animOpacity.beginTime = 1.25;
    animOpacity.autoreverses = NO;
    animOpacity.toValue = [NSNumber numberWithFloat:0];
    animOpacity.removedOnCompletion = NO;
    animOpacity.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *animOpacity2 = [animOpacity copy];
    animOpacity2.toValue = [NSNumber numberWithFloat:1];
    
    CAAnimationGroup *laozi_animGroup = [CAAnimationGroup animation];
    laozi_animGroup.animations = @[animInit, animLeft, animRight, animLeft2, animUp, animOpacity];
    laozi_animGroup.beginTime = 0;
    laozi_animGroup.duration = 3.65;
    laozi_animGroup.removedOnCompletion = NO;
    laozi_animGroup.fillMode = kCAFillModeForwards;
    laozi_animGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    CAAnimationGroup *laopingzi_animGroup = [laozi_animGroup copy];
    laopingzi_animGroup.animations = @[animInit, animLeft, animRight, animLeft2, animUp, animOpacity2];
    
    [self.laoziImageView.layer       addAnimation: laozi_animGroup          forKey:@"layer_laozi"];
    [self.laozipingziImageView.layer addAnimation: laopingzi_animGroup      forKey:@"layer_pingzilaozi"];
    
    // 按钮显现出来
    CABasicAnimation *anim_buttonOpacity = [CABasicAnimation animationWithKeyPath:@"opacity"];
    anim_buttonOpacity.duration = 0.2;
    anim_buttonOpacity.beginTime = CACurrentMediaTime() + 2.7;
    anim_buttonOpacity.autoreverses = NO;
    anim_buttonOpacity.fromValue = @0.0;
    anim_buttonOpacity.toValue = @1.0;
    anim_buttonOpacity.removedOnCompletion = NO;
    anim_buttonOpacity.fillMode = kCAFillModeForwards;
    anim_buttonOpacity.delegate = self;
    
    if (self.isHaveToy) {
        [self.immediately_openButton.layer addAnimation:anim_buttonOpacity forKey:nil];
        [self.put_inButton.layer addAnimation:[anim_buttonOpacity copy] forKey:nil];
    } else {
        [self.one_moreButton.layer addAnimation:anim_buttonOpacity forKey:nil];
        [self.nextButton.layer addAnimation:anim_buttonOpacity forKey:nil];
    }

}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self.immediately_openButton.layer removeAllAnimations];
    [self.put_inButton.layer removeAllAnimations];
    [self.one_moreButton.layer removeAllAnimations];
    [self.nextButton.layer removeAllAnimations];
    [self.laoziImageView.layer removeAllAnimations];
    [self.laozipingziImageView.layer removeAllAnimations];
    
    if (self.isHaveToy) {
        self.immediately_openButton.alpha = 1;
        self.put_inButton.alpha = 1;
    } else {
        self.one_moreButton.alpha = 1;
        self.nextButton.alpha = 1;
    }
    
    self.laoziImageView.alpha = 0;
    self.laozipingziImageView.alpha = 1;
}

#pragma mark ----------------interface------------------
- (CGRect)goldNumFrame
{
    return self.goldNumImageView.frame;
}

- (void)goldNumChange:(NSInteger)num
{
    self.goldNum += num;
    [self.goldNumLabel countFromCurrentValueTo:self.goldNum withDuration:1.3];
}

- (void)hideLaozi
{
    self.laoziImageView.layer.opacity = 0;
}

- (void)showLaozi
{
    [UIView animateWithDuration:0.15 animations:^{
        self.laoziImageView.layer.opacity = 1;
    }];
}

@end
