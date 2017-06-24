//
//  circleProgressBar.m
//  MKShapeLayer
//
//  Created by gw on 2017/6/22.
//  Copyright © 2017年 VS. All rights reserved.
//

#import "CircleProgressBar.h"

@interface CircleProgressBar ()<CAAnimationDelegate>

@end

@implementation CircleProgressBar

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {

        [self setUp];
    }
    return self;
}

-(void)setUp{
    
    [self circleShapeLayer];

}
-(void)circleShapeLayer{

    CGFloat kwidth = self.frame.size.width;
    CGFloat kheight= self.frame.size.height;
    
    CAShapeLayer * circleShapeLayer = [[CAShapeLayer alloc] init];
    
    UIBezierPath * path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(kwidth/2.0, kheight/2.0, 100, 100)];
    
    circleShapeLayer.path = path.CGPath;
    circleShapeLayer.lineWidth = 5;
    circleShapeLayer.strokeColor = [UIColor blackColor].CGColor;
    circleShapeLayer.fillColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:circleShapeLayer];
    
    CABasicAnimation * basicAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    basicAnimation.duration = 2.0;
    basicAnimation.fromValue = @(0.0);
    basicAnimation.toValue = @(1.0);
    basicAnimation.delegate = self;
    [circleShapeLayer addAnimation:basicAnimation forKey:@"basicAnimation"];
    

}

@end
