//
//  FBOpenBottleViewController.m
//  laoyilao
//
//  Created by cc on 16/8/2.
//  Copyright © 2016年 cc. All rights reserved.
//

#import "FBOpenBottleViewController.h"
#import "FBLaoYiLaoViewController.h"
#import "constant.h"

@interface FBOpenBottleViewController ()
@property (strong, nonatomic) UIVisualEffectView *visualView;
@property (strong, nonatomic) UIView *contentView;

@property (strong, nonatomic) UIView *edgView; // 宝贝外层view

@property (strong, nonatomic) UIButton *putInButton;
@property (strong, nonatomic) UIButton *throwButton;

@end

@implementation FBOpenBottleViewController

- (instancetype)init
{
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        
        self.visualView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
        self.contentView = [[UIView alloc] init];
        
        self.edgView = [[UIView alloc] init];
        
        self.putInButton = [[UIButton alloc] init];
        [self.putInButton setImage:imageOfAutoScaleImage(@"c2 in.png") forState:UIControlStateNormal];
        [self.putInButton addTarget:self action:@selector(putInButtonPress:) forControlEvents:UIControlEventTouchUpInside];
        
        self.throwButton = [[UIButton alloc] init];
        [self.throwButton setImage:imageOfAutoScaleImage(@"c2 out.png") forState:UIControlStateNormal];
        [self.throwButton addTarget:self action:@selector(throwButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    WS(ws);
    
    // 虚化背景
    UIView *visualSuperView = [[UIView alloc] init];
    [self.view addSubview:visualSuperView];
    [visualSuperView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(ws.view);
    }];
    
    [visualSuperView addSubview:self.visualView];
    [self.visualView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(visualSuperView);
    }];
    
    [self.view addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(ws.view);
    }];
    
    // 宝贝外层view
    [self.contentView addSubview:self.edgView];
    [self.edgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(267 * RATIO, 199 *RATIO));
        make.centerX.mas_equalTo(ws.contentView);
        make.bottom.mas_equalTo(ws.contentView).offset(-300 *RATIO_V);
    }];
    
    // button
    [self.contentView addSubview:self.putInButton];
    [self.putInButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(86*RATIO, 30*RATIO));
        make.bottom.mas_equalTo(ws.edgView).offset(-5 *RATIO);
        make.left.mas_equalTo(ws.edgView).offset(33 * RATIO);
    }];
    
    [self.contentView addSubview:self.throwButton];
    [self.throwButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(86*RATIO, 30*RATIO));
        make.bottom.mas_equalTo(ws.edgView).offset(-5 *RATIO);
        make.left.mas_equalTo(ws.putInButton.mas_right).offset(10 * RATIO);
    }];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    if (self.isGold) {
        [self escapeVCWithGoldAnim];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    WS(ws);
    
    self.contentView.transform = CGAffineTransformMakeScale(0, 0);
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        ws.contentView.transform = CGAffineTransformMakeScale(1, 1);
    } completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
}

- (void)setGoodsView:(UIView *)goodsView
{
    WS(ws);
    
    _goodsView = goodsView;
    
    [self.edgView addSubview:_goodsView];
    [_goodsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(ws.edgView);
    }];
}

- (void)setIsGold:(BOOL)isGold
{
    _isGold = isGold;
    
    self.putInButton.hidden = isGold;
    self.throwButton.hidden = isGold;
}

- (void)putInButtonPress:(UIButton *)button
{
    if (self.putInButtonAction != nil) {
        self.putInButtonAction(button);
        
        self.putInButton.layer.opacity = 0;
        self.throwButton.layer.opacity = 0;
        
        if (_isGold) {
            [self escapeVCWithGoldAnim];
        } else {
            [self escapeVCWithStoreAnim];
        }
    }
}

- (void)throwButtonPress:(UIButton *)button
{
    if (self.throwButtonAction != nil) {
        self.throwButtonAction(button);
        
        self.putInButton.layer.opacity = 0;
        self.throwButton.layer.opacity = 0;
        
        [self escapeVCWithThrowingAnim];
    }
}

#pragma mark ----------------interface-------------------
- (void)escapeVCWithStoreAnim
{
    CGRect tabbarFrame = self.lylVC.tabBarController.tabBar.frame;
    CGPoint tabbarCenter = self.lylVC.tabBarController.tabBar.center;
    
    CGPoint tmpPoint = tabbarCenter;
    tmpPoint.x += tabbarFrame.size.width / 8;
    
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = @[[self animWithScaleWithDuration:0.3f],
                             [self animWithPosition:tmpPoint Duration:0.3f]
                             ];
    animGroup.duration = 0.3f;
    animGroup.removedOnCompletion = NO;
    animGroup.fillMode = kCAFillModeForwards;
    animGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animGroup.delegate = self;
    
    [self visualViwAnimWithDuration:0.3];
    [self.edgView.layer addAnimation:animGroup forKey:nil];
}

- (void)escapeVCWithGoldAnim
{
    WS(ws);
    
    UIImageView *coinImageView = imageViewOfAutoScaleImage(@"box coin2.png");
    [self.edgView addSubview:coinImageView];
    [coinImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(ws.edgView.mas_height).multipliedBy(0.14);
        make.left.mas_equalTo(ws.edgView.mas_right).multipliedBy(0.2774);
        make.bottom.mas_equalTo(ws.edgView.mas_bottom).multipliedBy(0.78875);
    }];
    
    UIImageView *coinImageView2 = imageViewOfAutoScaleImage(@"box coin2.png");
    [self.edgView addSubview:coinImageView2];
    [coinImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(ws.edgView.mas_height).multipliedBy(0.14);
        make.left.mas_equalTo(ws.edgView.mas_right).multipliedBy(0.2774);
        make.bottom.mas_equalTo(ws.edgView.mas_bottom).multipliedBy(0.78875);
    }];
    
    UIImageView *coinImageView3 = imageViewOfAutoScaleImage(@"box coin2.png");
    [self.edgView addSubview:coinImageView3];
    [coinImageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(ws.edgView.mas_height).multipliedBy(0.14);
        make.left.mas_equalTo(ws.edgView.mas_right).multipliedBy(0.2774);
        make.bottom.mas_equalTo(ws.edgView.mas_bottom).multipliedBy(0.78875);
    }];
    
    UIImageView *coinImageView4 = imageViewOfAutoScaleImage(@"box coin2.png");
    [self.edgView addSubview:coinImageView4];
    [coinImageView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(ws.edgView.mas_height).multipliedBy(0.14);
        make.left.mas_equalTo(ws.edgView.mas_right).multipliedBy(0.2774);
        make.bottom.mas_equalTo(ws.edgView.mas_bottom).multipliedBy(0.78875);
    }];
    
    UIImageView *coinImageView5 = imageViewOfAutoScaleImage(@"box coin2.png");
    [self.edgView addSubview:coinImageView5];
    [coinImageView5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(ws.edgView.mas_height).multipliedBy(0.14);
        make.left.mas_equalTo(ws.edgView.mas_right).multipliedBy(0.2774);
        make.bottom.mas_equalTo(ws.edgView.mas_bottom).multipliedBy(0.78875);
    }];
    
    [self visualViwAnimWithDuration:1];
    [self addGoldAnimDelay:0 View:coinImageView isEnd:NO];
    [self addGoldAnimDelay:0.15 View:coinImageView2 isEnd:NO];
    [self addGoldAnimDelay:0.3 View:coinImageView3 isEnd:NO];
    [self addGoldAnimDelay:0.45 View:coinImageView4 isEnd:NO];
    [self addGoldAnimDelay:0.6 View:coinImageView5 isEnd:YES];
    
    [self.lylVC goldNumChange:500];
    [self.lylVC hideLaozi];
}

- (void)escapeVCWithThrowingAnim
{
    CGPoint edgPoint = self.edgView.center;
    edgPoint.x += 100;
    edgPoint.y += 180;
    
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = @[[self animWithRotate360DegreeWithDuration:0.8f],
                             [self animWithScaleWithDuration:0.8f],
                             [self animWithPosition:edgPoint Duration:0.8f]
                            ];
    animGroup.duration = 0.8f;
    animGroup.removedOnCompletion = NO;
    animGroup.fillMode = kCAFillModeForwards;
    animGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animGroup.delegate = self;
    
    [self visualViwAnimWithDuration:0.3];
    [self.edgView.layer addAnimation:animGroup forKey:nil];
}

#pragma mark -------------anim---------------
- (void)visualViwAnimWithDuration:(NSTimeInterval)duration
{
    WS(ws);
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        ws.visualView.superview.alpha = 0;
    } completion:nil];
}

- (CABasicAnimation *)animWithRotate360DegreeWithDuration:(NSTimeInterval)duration
{
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:(2 * M_PI) * 2];
    // 3 is the number of 360 degree rotations
    // Make the rotation animation duration slightly less than the other animations to give it the feel
    // that it pauses at its largest scale value
    rotationAnimation.duration = duration;
    rotationAnimation.removedOnCompletion = NO;
    rotationAnimation.fillMode = kCAFillModeForwards;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    return rotationAnimation;
}

- (CABasicAnimation *)animWithScaleWithDuration:(NSTimeInterval)duration
{
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:0.0];
    scaleAnimation.duration = duration;
    scaleAnimation.removedOnCompletion = NO;
    scaleAnimation.fillMode = kCAFillModeForwards;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    return scaleAnimation;
}

- (CABasicAnimation *)animWithPosition:(CGPoint)toPoint Duration:(NSTimeInterval)duration
{
    CABasicAnimation *animation  = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.toValue = [NSValue valueWithCGPoint:toPoint];
    animation.duration = duration;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    return animation;
}

- (void)addGoldAnimDelay:(NSTimeInterval)delay View:(UIView *)view isEnd:(BOOL)isEnd
{
    CGRect currRect = [self.edgView convertRect:[self.lylVC goldNumFrame] fromView:self.contentView];
    CGFloat newX = currRect.origin.x + 15.0;
    CGFloat newY = currRect.origin.y + 15.0;
    
    CABasicAnimation *animRight = [CABasicAnimation animationWithKeyPath:@"position.x"];
    animRight.duration = 0.4;
    animRight.beginTime = delay;
    animRight.autoreverses = NO;
    animRight.toValue = [NSNumber numberWithFloat:newX];
    
    CABasicAnimation *animUp = [CABasicAnimation animationWithKeyPath:@"position.y"];
    animUp.duration = 0.4;
    animUp.beginTime = delay;
    animUp.autoreverses = NO;
    animUp.toValue = [NSNumber numberWithFloat:newY];
    
    CAAnimationGroup *goldAnimGroup = [CAAnimationGroup animation];
    goldAnimGroup = [CAAnimationGroup animation];
    goldAnimGroup.animations = @[animRight, animUp];
    goldAnimGroup.beginTime = 0;
    goldAnimGroup.duration = 0.4 + delay;
    goldAnimGroup.removedOnCompletion = YES;
    goldAnimGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    if (isEnd) {
        goldAnimGroup.delegate = self;
    }
    
    [view.layer addAnimation:goldAnimGroup forKey:nil];
    
}

#pragma mark --------------anim delegate--------------------
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    WS(ws);
    
    [self dismissViewControllerAnimated:NO completion:^{
        [ws.lylVC showLaozi];
    }];
}

@end
