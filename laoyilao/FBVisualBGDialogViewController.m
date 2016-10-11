//
//  FBVisualBGDialogViewController.m
//  visual
//
//  Created by cc on 16/7/20.
//  Copyright © 2016年 cc. All rights reserved.
//

#import "FBVisualBGDialogViewController.h"
#import "constant.h"

@interface FBVisualBGDialogViewController ()

@property (strong, nonatomic) UIVisualEffectView *visualView;
@property (strong, nonatomic) UIView *contentView;

@property (strong, nonatomic) UIImageView *waterBGImageView2; // 里层水色背景
@property (strong, nonatomic) UIImageView *waterBGImageView;  // 外层水色背景

// 水色背景上面的图片
@property (strong, nonatomic) UIImageView *goodsImageView;

// 水色背景里的两个label
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *contentLabel;

// 水色背景下面的button
@property (strong, nonatomic) NSMutableArray<UIButton *> *buttonArray;
@property (assign, nonatomic) BOOL buttonFlg;

@end

@implementation FBVisualBGDialogViewController

- (instancetype)init
{
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        
        [self subInit];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self layoutInit];
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

#pragma mark ------------------------------init------------------------------


/**
 *  子控件初始化
 */
- (void)subInit
{
    self.visualView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    
    self.contentView = self.visualView.contentView;
    
    self.waterBGImageView2 = imageViewOfAutoScaleImage(@"background2.png");
    self.waterBGImageView = imageViewOfAutoScaleImage(@"background1.png");
    
    self.goodsImageView = [[UIImageView alloc] init];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.numberOfLines = 0;
    
    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.textAlignment = NSTextAlignmentCenter;
    self.contentLabel.numberOfLines = 0;
    
    self.buttonArray = [NSMutableArray arrayWithCapacity:2];
    self.buttonFlg = NO;
}

/**
 *  布局
 */
- (void)layoutInit
{
    WS(ws);
    
    // 虚化背景
    [self.view addSubview:self.visualView];
    [self.visualView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(ws.view);
    }];
    
    // 水色背景
    self.waterBGImageView2.layer.contentsCenter = CGRectMake(0, 0.45, 1, 0.1);
    [self.contentView addSubview:self.waterBGImageView2];
    [self.waterBGImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(250, 154));
        make.centerX.mas_equalTo(ws.contentView.mas_centerX);
        make.top.mas_equalTo(ws.contentView).offset(262 * RATIO_V);
    }];
    
    // 水色背景
    self.waterBGImageView.layer.contentsCenter = CGRectMake(0, 0.45, 1, 0.1);
    [self.contentView addSubview:self.waterBGImageView];
    [self.waterBGImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@250);
        make.centerX.mas_equalTo(ws.contentView.mas_centerX);
        make.top.mas_equalTo(ws.contentView).offset(262 * RATIO_V);
    }];
    
    // 水色背景里的label
    [self.waterBGImageView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@202.0);
        make.centerX.mas_equalTo(ws.waterBGImageView.mas_centerX);
        make.top.mas_equalTo(ws.waterBGImageView).offset(31);
    }];
    
    [self.waterBGImageView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@202.0);
        make.centerX.mas_equalTo(ws.waterBGImageView.mas_centerX);
        make.bottom.mas_equalTo(ws.waterBGImageView).offset(-31);
        make.top.mas_equalTo(ws.titleLabel.mas_bottom);
    }];
    
    // 水色背景上面的图片
    [self.contentView insertSubview:self.goodsImageView aboveSubview:self.waterBGImageView2];
    [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (ws.goodsImage != nil) {
            make.size.mas_equalTo(ws.goodsImage.size);
        } else {
            make.size.mas_equalTo(CGSizeMake(0, 0));
        }
        make.centerX.mas_equalTo(ws.contentView.mas_centerX);
        make.bottom.mas_equalTo(ws.waterBGImageView2.mas_top).offset(48);
    }];
    
    // button
    if (self.buttonArray.count == 1) {
        [self.contentView addSubview:self.buttonArray[0]];
        [self.buttonArray[0] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(67, 21));
            make.centerX.mas_equalTo(ws.contentView.mas_centerX);
            make.top.mas_equalTo(ws.waterBGImageView.mas_bottom).offset(12);
        }];
    } else if (self.buttonArray.count == 2) {
        [self.contentView addSubview:self.buttonArray[0]];
        [self.contentView addSubview:self.buttonArray[1]];
        
        [self.buttonArray[0] mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(67, 21));
            make.centerX.mas_equalTo(ws.contentView.mas_centerX).offset(-(13+33.5));
            make.top.mas_equalTo(ws.waterBGImageView.mas_bottom).offset(12);
        }];
        
        [self.buttonArray[1] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(67, 21));
            make.centerX.mas_equalTo(ws.contentView.mas_centerX).offset(13+33.5);
            make.top.mas_equalTo(ws.waterBGImageView.mas_bottom).offset(12);
        }];
    }
    
    self.buttonFlg = YES;
}



#pragma mark ------------------------------set&get------------------------------
- (void)setGoodsImage:(UIImage *)goodsImage
{
    _goodsImage = goodsImage;
    
    self.goodsImageView.image = goodsImage;
    [self.goodsImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(goodsImage.size);
    }];
}

- (void)setTitleText:(NSString *)titleText
{
    _titleText = titleText;
    self.titleLabel.text = _titleText;
}

- (void)setTitleTextColor:(UIColor *)titleTextColor
{
    _titleTextColor = titleTextColor;
    self.titleLabel.textColor = _titleTextColor;
}

- (void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    self.titleLabel.font = _titleFont;
}

- (void)setTitleTextAlignment:(NSTextAlignment)titleTextAlignment
{
    _titleTextAlignment = titleTextAlignment;
    self.titleLabel.textAlignment = _titleTextAlignment;
}

- (void)setAttributedTitleText:(NSAttributedString *)attributedTitleText
{
    _attributedTitleText = attributedTitleText;
    self.titleLabel.attributedText = _attributedTitleText;
}


- (void)setContentText:(NSString *)contentText
{
    _contentText = contentText;
    self.contentLabel.text = _contentText;
}

- (void)setContentTextColor:(UIColor *)contentTextColor
{
    _contentTextColor = contentTextColor;
    self.contentLabel.textColor = _contentTextColor;
}

- (void)setContentFont:(UIFont *)contentFont
{
    _contentFont = contentFont;
    self.contentLabel.font = _contentFont;
}

- (void)setContentTextAlignment:(NSTextAlignment)contentTextAlignment
{
    _contentTextAlignment = contentTextAlignment;
    self.contentLabel.textAlignment = _contentTextAlignment;
}

- (void)setAttributedContentText:(NSAttributedString *)attributedContentText
{
    _attributedContentText = attributedContentText;
    self.contentLabel.attributedText = _attributedContentText;
}

#pragma mark ------------------------------interface------------------------------
- (void)addButton:(UIButton *)button
{
    WS(ws);
    
    [self.buttonArray addObject:button];
    
    if (self.buttonFlg == YES) {
        if (self.buttonArray.count == 1) {
            [self.contentView addSubview:self.buttonArray[0]];
            
            [self.buttonArray[0] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(67, 21));
                make.centerX.mas_equalTo(ws.contentView.mas_centerX);
                make.top.mas_equalTo(ws.waterBGImageView.mas_bottom).offset(12);
            }];
        } else if (self.buttonArray.count == 2) {
            [self.contentView addSubview:self.buttonArray[0]];
            [self.contentView addSubview:self.buttonArray[1]];
            
            [self.buttonArray[0] mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(67, 21));
                make.centerX.mas_equalTo(ws.contentView.mas_centerX).offset(-(13+33.5));
                make.top.mas_equalTo(ws.waterBGImageView.mas_bottom).offset(12);
            }];
            
            [self.buttonArray[1] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(67, 21));
                make.centerX.mas_equalTo(ws.contentView.mas_centerX).offset(13+33.5);
                make.top.mas_equalTo(ws.waterBGImageView.mas_bottom).offset(12);
            }];
        }
    }


}

@end
