//
//  BasicUse.h
//  MKShapeLayer
//
//  Created by gw on 2017/6/22.
//  Copyright © 2017年 VS. All rights reserved.
//
/** 物理屏幕宽高**/
#define SCREENW [UIScreen mainScreen].bounds.size.width
#define SCREENH [UIScreen mainScreen].bounds.size.height
#import <UIKit/UIKit.h>

@interface BasicUseView : UIView

/*
 以某个点为中心画圆弧
 */
-(void)bezierPathWithArc;

/*
 设置矩形某个角为圆角
 */
-(void)bezierPathWithRoundedRectByCornerRadi;

/*
 画带圆角的矩形
 */
-(void)bezierPathWithRoundedRectByAllCorner;

/*
 画矩形内切圆
 */
-(void)bezierPathWithOvalInRect;

/*
 矩形
 */
-(void)bezierPathWithRect;

/*
 画二元曲线，一般和moveToPoint配合使用
 */
-(void)QuadCurveWithControlPoint;

/*
 以三个点画一段曲线，一般和moveToPoint配合使用
 */
-(void)QuadCurveWithTwoControlPoints;

@end
