//
//  ViewController.m
//  MKTest
//
//  Created by gw on 2017/5/27.
//  Copyright © 2017年 VS. All rights reserved.
//
/** 物理屏幕宽高**/
#define SCREENW [UIScreen mainScreen].bounds.size.width
#define SCREENH [UIScreen mainScreen].bounds.size.height

#import "BasicUseView.h"

@interface BasicUseView ()

@end

@implementation BasicUseView

-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
/*
 以某个点为中心画圆弧
 */
-(void)bezierPathWithArc{
    
    UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(SCREENW/2.0, SCREENH/2.0) radius:100.0 startAngle:0.0 endAngle:M_PI clockwise:YES];
    
    CAShapeLayer * layer = [[CAShapeLayer alloc] init];
    layer.path = path.CGPath;
    layer.fillColor = [UIColor orangeColor].CGColor;
    [self.layer addSublayer:layer];
}

/*
 设置矩形某个角为圆角
 */
-(void)bezierPathWithRoundedRectByCornerRadi{
    
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(50, 50, 100, 100) byRoundingCorners:UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    
    CAShapeLayer * layer = [[CAShapeLayer alloc] init];
    layer.path = path.CGPath;
    layer.fillColor = [UIColor orangeColor].CGColor;
    [self.layer addSublayer:layer];
}
/*
 画带圆角的矩形
 */
-(void)bezierPathWithRoundedRectByAllCorner{
    
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(50, 50, 100, 100) cornerRadius:20.0];
    
    CAShapeLayer * layer = [[CAShapeLayer alloc] init];
    layer.path = path.CGPath;
    layer.fillColor = [UIColor orangeColor].CGColor;
    [self.layer addSublayer:layer];
}
/*
 画矩形内切圆
 */
-(void)bezierPathWithOvalInRect{
    
    UIBezierPath * path  =[UIBezierPath bezierPathWithOvalInRect:CGRectMake(50, 50, 100, 100)];
    
    CAShapeLayer * shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = [UIColor orangeColor].CGColor;
    [self.layer addSublayer:shapeLayer];
}
/*
 矩形
*/
-(void)bezierPathWithRect{
    
    UIBezierPath * path = [UIBezierPath bezierPathWithRect:CGRectMake(50, 50, 100, 100)];
    path.lineWidth = 10;
    
    CAShapeLayer * shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = [UIColor redColor].CGColor;
    shapeLayer.strokeColor = [UIColor greenColor].CGColor;
    [self.layer addSublayer:shapeLayer];
    
}

/*
 画二元曲线，一般和moveToPoint配合使用
 */
-(void)QuadCurveWithControlPoint{
    
    CGFloat shapeLayerHeight = SCREENH * 0.3;
    CAShapeLayer * shapeLayer = [[CAShapeLayer alloc] init];
    
    UIBezierPath * path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(0, SCREENH-shapeLayerHeight)];
    [path addLineToPoint:CGPointMake(0, SCREENH)];
    [path addLineToPoint:CGPointMake(SCREENW, SCREENH)];
    [path addLineToPoint:CGPointMake(SCREENW, SCREENH-shapeLayerHeight)];
    [path addQuadCurveToPoint:CGPointMake(0, SCREENH-shapeLayerHeight) controlPoint:CGPointMake(SCREENW/2.0, SCREENH-shapeLayerHeight-100)];
    
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = [UIColor orangeColor].CGColor;
    [self.layer addSublayer:shapeLayer];
}
/*
 //以三个点画一段曲线，一般和moveToPoint配合使用
 */
-(void)QuadCurveWithTwoControlPoints{
    
    CGPoint startPoint = CGPointMake(50, 100);
    CGPoint endPoint = CGPointMake(250, 100);
    
    UIBezierPath * path = [[UIBezierPath alloc] init];
    [path moveToPoint:startPoint];
    [path addCurveToPoint:endPoint controlPoint1:CGPointMake(100, 50) controlPoint2:CGPointMake(200, 150)];
    
    CAShapeLayer * shapeLayer = [[CAShapeLayer alloc] init];
    [self.layer addSublayer:shapeLayer];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = [UIColor redColor].CGColor;
    shapeLayer.strokeColor = [UIColor blackColor].CGColor;
    shapeLayer.lineWidth = 5.0;
}
@end
