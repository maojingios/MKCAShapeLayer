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
