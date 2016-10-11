//
//  CALayer+FBAnimation.m
//  NewMainLand
//
//  Created by 朱志先 on 16/7/5.
//  Copyright © 2016年 朱志先. All rights reserved.
//

#import "CALayer+FBAnimation.h"

@implementation CALayer (FBAnimation)


static void *isAutoRepeatKey = &isAutoRepeatKey;

- (void)setIsAutoRepeat:(BOOL)isAutoRepeat
{
    objc_setAssociatedObject(self, & isAutoRepeatKey, @(isAutoRepeat), OBJC_ASSOCIATION_ASSIGN );
}

- (BOOL)isAutoRepeat
{
    return objc_getAssociatedObject(self, isAutoRepeatKey );
}



- (void)startLinearAnimatonWithStartPoint:(CGPoint)startPoint AndEndPoint:(CGPoint)endPoint IsBounce:(BOOL)isBounce duration:(CGFloat)duration delay:(CGFloat)delay
{
    NSArray * array = [self createLinearAnimatonWithStartPoint:startPoint AndEndPoint:endPoint IsBounce:isBounce duration:duration delay:delay];
    for (CABasicAnimation *animation in array) {
        [self addAnimation:animation forKey:nil];
    }
}



- (NSArray<CABasicAnimation * > *)createLinearAnimatonWithStartPoint:(CGPoint)startPoint AndEndPoint:(CGPoint)endPoint IsBounce:(BOOL)isBounce duration:(CGFloat)duration delay:(CGFloat)delay
{
    NSMutableArray *array = [NSMutableArray array];
    if (startPoint.x - endPoint.x != 0) {
        CABasicAnimation *animation= [self creatLinearAnimationFromA:startPoint.x ToB:endPoint.x isBounce:isBounce AnimationKeyPath:@"transform.translation.x" duration:(CGFloat)duration delay:(CGFloat)delay];
        [array addObject:animation];
    }
    
    if (startPoint.y - endPoint.y != 0) {
        CABasicAnimation *animation= [self creatLinearAnimationFromA:startPoint.y ToB:endPoint.y isBounce:isBounce AnimationKeyPath:@"transform.translation.y" duration:(CGFloat)duration delay:(CGFloat)delay];
        [array addObject:animation];
    }
    
    
    return array;
}

- (CABasicAnimation *)creatLinearAnimationFromA:(CGFloat)a ToB:(CGFloat)b isBounce:(BOOL)isBounce AnimationKeyPath:(NSString *)keyPath duration:(CGFloat)duration delay:(CGFloat)delay
{
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:keyPath];
    
    animation.fromValue = [NSNumber numberWithFloat:a];
    
    animation.toValue = [NSNumber numberWithFloat:b];
    
    animation.duration= duration;
    
    animation.beginTime = delay;
    
    animation.repeatCount = HUGE_VALF;
    
    animation.autoreverses = YES;
    
    animation.removedOnCompletion = NO;
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.fillMode=kCAFillModeForwards;
    
    return animation;
}



- (void)setRotaionCenter:(CGPoint)rotaionCenter
{
    if (CGRectGetWidth(self.frame) == 0) {
        NSLog(@"frame为CGectZero");
        return;
    }
    
    CGFloat x = rotaionCenter.x/CGRectGetWidth(self.frame);
    CGFloat y = rotaionCenter.y/CGRectGetHeight(self.frame);
    
    CGFloat positionX = self.frame.origin.x + x * CGRectGetWidth(self.frame);
    CGFloat positionY = self.frame.origin.y + y * CGRectGetHeight(self.frame);
    
    self.position = CGPointMake(positionX, positionY);
    self.anchorPoint = CGPointMake(x, y);
    
    
}



-(void)startRepeatRotationAnimationDuration:(CFTimeInterval)duration Delay:(CFTimeInterval)delay Angel:(CGFloat)angel RotationCenter:(CGPoint)rotationCenter
{
    //    NSLog(@"%f,%f",rotationCenter.x,rotationCenter.y);
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    [self setRotaionCenter:rotationCenter];
    
    // 设定动画选项
    animation.duration = duration; // 持续时间
    animation.repeatCount = HUGE_VALF; // 重复次数
    animation.autoreverses = YES;
    
    // 设定旋转角度
    animation.fromValue = [NSNumber numberWithFloat:-angel]; // 起始角度
    animation.toValue = [NSNumber numberWithFloat:angel]; // 终止角度
    animation.removedOnCompletion = NO;
    animation.beginTime = delay;
    
    //rNSLog(@"%f,%f,%f,%f",self.position.x,self.position.y,self.anchorPoint.x,self.anchorPoint.y);
    
    
    
    
    [self addAnimation:animation forKey:@"animation"];
}


- (void)startBounceAnimationDuration:(CFTimeInterval)duration firstStepHeightRatio:(CGFloat)heightRatio secondStepWidthRatio:(CGFloat)widthRatio
{
    //   CABasicAnimation *stepOneAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
    CABasicAnimation *stepOneAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    //    stepOneAnimation.fromValue = [NSNumber numberWithDouble:1];
    stepOneAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(heightRatio, widthRatio, 1)];
    stepOneAnimation.duration = duration/2;
    stepOneAnimation.repeatCount = 1;
    stepOneAnimation.autoreverses = YES;
    
    //   CABasicAnimation *stepTwoAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
    CABasicAnimation *stepTwoAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    //   stepTwoAnimation.fromValue = [NSNumber numberWithDouble:1];
    stepTwoAnimation.toValue =  [NSValue valueWithCATransform3D:CATransform3DMakeScale(heightRatio, widthRatio, 1)];
    stepTwoAnimation.duration = duration/2;
    stepTwoAnimation.beginTime = duration;
    stepTwoAnimation.autoreverses = YES;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[stepOneAnimation,stepTwoAnimation];
    group.beginTime = 2 + arc4random()%5;
    group.duration = (10 + arc4random()%10) * duration;
    group.repeatCount = HUGE_VALF;
    group.removedOnCompletion = NO;
    
    
    
    [self addAnimation:group forKey:nil];
    
}

- (void)startChangeAlpha
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    
    // 设定动画选项
    animation.duration = 2; // 持续时间
    animation.repeatCount = HUGE_VALF; // 重复次数
    animation.autoreverses = YES;
    animation.removedOnCompletion = NO;
    
    animation.fromValue = [NSNumber numberWithFloat:1.0];
    animation.toValue = [NSNumber numberWithFloat:0.2];
    
    [self addAnimation:animation forKey:nil];
    
    
    
    
}



- (void)stopAnimation
{
    [self removeAllAnimations];
}


@end
