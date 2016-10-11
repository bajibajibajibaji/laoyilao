//
//  CALayer+FBAnimation.h
//  NewMainLand
//
//  Created by 朱志先 on 16/7/5.
//  Copyright © 2016年 朱志先. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

@interface CALayer (FBAnimation)
@property (nonatomic, assign) BOOL isAutoRepeat;
- (void)stopAnimation;
- (void)startRepeatRotationAnimationDuration:(CFTimeInterval)duration Delay:(CFTimeInterval)delay Angel:(CGFloat)angel RotationCenter:(CGPoint)rotationCenter;
- (void)startLinearAnimatonWithStartPoint:(CGPoint)startPoint AndEndPoint:(CGPoint)endPoint IsBounce:(BOOL)isBounce duration:(CGFloat)duration delay:(CGFloat)delay;

- (void)startBounceAnimationDuration:(CFTimeInterval)duration firstStepHeightRatio:(CGFloat)heightRatio secondStepWidthRatio:(CGFloat)widthRatio;
- (void)startChangeAlpha;

@end
