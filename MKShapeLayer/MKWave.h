//
//  MKWave.h
//  MKShapeLayer
//
//  Created by gw on 2017/6/23.
//  Copyright © 2017年 VS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MKWave : UIView

@property (nonatomic, readwrite, assign)NSTimeInterval waveTime;
@property (nonatomic, readwrite, assign)CGFloat waveSpeed;
@property (nonatomic, readwrite, strong)UIColor * waveColor;
@property (nonatomic, readwrite, assign)CGFloat angularSpeed;

+(instancetype)addToSuperView:(UIView *)superView withFrame:(CGRect)frame;

-(void)mkStart;

-(void)mkStop;

-(void)mkCancel;

@end
