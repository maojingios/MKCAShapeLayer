//
//  MKCheckButton.m
//  MKShapeLayer
//
//  Created by gw on 2017/6/22.
//  Copyright © 2017年 VS. All rights reserved.
//

#import "MKCheckButton.h"

static CGSize MKCheckButtonSize () {
    return CGSizeMake(100.0, 100.0);
}

@interface MKCheckButton ()<CAAnimationDelegate>

@property (nonatomic, readwrite, assign, getter=isAnimating) BOOL animating;

@end

@implementation MKCheckButton

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self =[super initWithFrame:frame]) {
        
        [self setUp];
    }
    return self;
}

-(void)setUp{
    
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchMe:)]];
    
}
#pragma mark - 生命周期
-(void)layoutSubviews{
    
    self.layer.cornerRadius = self.frame.size.height/2.0;

}


#pragma mark - 点击事件
-(void)touchMe:(UITapGestureRecognizer *)tap{

    CGFloat kheight = self.frame.size.height;
    
    if (self.isAnimating) { return; }
    
    self.layer.cornerRadius = MKCheckButtonSize().height/2.0;
    CABasicAnimation * basicRadiusAnimation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    basicRadiusAnimation.duration = 0.2;
    basicRadiusAnimation.delegate = self;
    basicRadiusAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    basicRadiusAnimation.fromValue = @(kheight/2.0);
    [self.layer addAnimation:basicRadiusAnimation forKey:@"basicRadiusAnimation"];

}

#pragma mark - CAAnimationDelegate
-(void)animationDidStart:(CAAnimation *)anim{

    if ([[self.layer animationForKey:@"basicRadiusAnimation"] isEqual:anim]) {
        
        [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
           
            self.bounds = CGRectMake(0, 0, MKCheckButtonSize().width, MKCheckButtonSize().height);
            self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
            
        } completion:^(BOOL finished) {
            
            [self.layer removeAllAnimations];
            
            [self checkMarkAnimation];
        }];
    }
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{

    if ([[self.layer animationForKey:@"checkMarkAnimation"] isEqual:anim]) {
        
        self.animating = NO;
    }

}

-(void)checkMarkAnimation{

    CGFloat kwidth = self.frame.size.width;
    CGFloat kheight = self.frame.size.height;
    
    CAShapeLayer * checkMarkLayer = [[CAShapeLayer alloc] init];
    
    UIBezierPath * path = [[UIBezierPath alloc]init];
    [path moveToPoint:CGPointMake(kwidth/4, kheight/2.0)];
    [path addLineToPoint:CGPointMake(kwidth/2.0, (kheight*3)/4)];
    [path addLineToPoint:CGPointMake((kwidth*3)/4.0, kheight/4)];
    
    checkMarkLayer.path = path.CGPath;
    checkMarkLayer.fillColor = [UIColor clearColor].CGColor;
    checkMarkLayer.strokeColor = [UIColor blackColor].CGColor;
    checkMarkLayer.lineWidth = 15;
    checkMarkLayer.lineCap = kCALineCapRound;
    checkMarkLayer.lineJoin = kCALineJoinRound;
    [self.layer addSublayer:checkMarkLayer];
    
    CABasicAnimation * checkMarkAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    checkMarkAnimation.duration = 0.5f;
    checkMarkAnimation.fromValue = @(0.0);
    checkMarkAnimation.toValue = @(1.0);
    checkMarkAnimation.delegate = self;
    [checkMarkLayer addAnimation:checkMarkAnimation forKey:@"checkMarkAnimation"];

}

@end
