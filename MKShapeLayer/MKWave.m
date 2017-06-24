//
//  MKWave.m
//  MKShapeLayer
//
//  Created by gw on 2017/6/23.
//  Copyright © 2017年 VS. All rights reserved.

#import "MKWave.h"
#import <QuartzCore/QuartzCore.h>
@interface MKWave ()

@property (nonatomic, readwrite, strong)CAShapeLayer * shapeLayer;
@property (nonatomic, readwrite, strong)CADisplayLink * displayLink;

@property (nonatomic, readwrite, assign)CGFloat waveOffset;


@end

@implementation MKWave

+(instancetype)addToSuperView:(UIView *)superView withFrame:(CGRect)frame{

    MKWave * wave = [[MKWave alloc] initWithFrame:frame];
    [superView addSubview:wave];
    return wave;
}

-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        [self initialize];
    }
    return self;
}
// xib
-(instancetype)initWithCoder:(NSCoder *)aDecoder{

    if (self = [super initWithCoder:aDecoder]) {
        
        [self initialize];
    }
    return self;
}

-(void)initialize{

    self.waveColor = [UIColor whiteColor];
    self.waveTime = 2.0f;
    self.waveSpeed = 15.0f;
    self.angularSpeed = 1.0f;
    self.waveOffset = 1.0f;
    
}
#pragma mark - lazy load
-(CAShapeLayer *)shapeLayer{
    if (!_shapeLayer) {
        _shapeLayer = [[CAShapeLayer alloc]init];
        _shapeLayer.fillColor = self.waveColor.CGColor;
        [self.layer addSublayer:_shapeLayer];
    }
    return _shapeLayer;
}

-(CADisplayLink *)displayLink{
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(refreshWave)];
        [_displayLink setPaused:YES];
        [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
    return _displayLink;
}

#pragma mark - refresh Wave
-(void)refreshWave{

    self.waveOffset += self.waveSpeed;
    
    CGFloat kwidth = CGRectGetWidth(self.frame);
    CGFloat kheight = CGRectGetHeight(self.frame);
    
    CGMutablePathRef paths = CGPathCreateMutable();
    CGPathMoveToPoint(paths, NULL, 0, kheight/2.0);
    
    CGFloat y = 0.0f;
    for (CGFloat x = 0; x<=kwidth; x++) {
        
        y = kheight * sin(0.01 * (self.angularSpeed * x + self.waveOffset));
        CGPathAddLineToPoint(paths, NULL, x, y);
    }
    
    /*
     定义:
     正弦曲线可表示为y=Asin(ωx+φ)+k，定义为函数y=Asin(ωx+φ)+k在直角坐标系上的图象，其中sin为正弦符号，x是直角坐标系x轴上的数值，y是在同一直角坐标系上函数对应的y值，k、ω和φ是常数（k、ω、φ∈R且ω≠0）
     
     参数定义:
     A——振幅，当物体作轨迹符合正弦曲线的直线往复运动时，其值为行程的1/2。
     (ωx+φ)——相位，反映变量y所处的状态。
     φ——初相，x=0时的相位；反映在坐标系上则为图像的左右移动。
     k——偏距，反映在坐标系上则为图像的上移或下移。
     ω——角速度， 控制正弦周期(单位角度内震动的次数)。
     */
    
    CGPathAddLineToPoint(paths, NULL, kwidth, kheight);
    CGPathAddLineToPoint(paths, NULL, 0, kheight);
    CGPathCloseSubpath(paths);
    
    self.shapeLayer.path = paths;
    
    CGPathRelease(paths);
    
}

-(void)mkStart{

    [self.displayLink setPaused:NO];
}

-(void)mkStop{

    [self.displayLink setPaused:YES];
}

-(void)mkCancel{

    [self.displayLink invalidate];
    self.displayLink = nil;
}

@end
