//
//  MKCADisplayLink.m
//  MKShapeLayer
//
//  Created by gw on 2017/6/23.
//  Copyright © 2017年 VS. All rights reserved.
//

#import "MKCADisplayLink.h"
#import <QuartzCore/QuartzCore.h>

@interface MKCADisplayLink ()

@property CADisplayLink * disPlayLink;

@end

@implementation MKCADisplayLink

static MKCADisplayLink * _manager;

+(__kindof MKCADisplayLink *)manager{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [super allocWithZone:NULL];
    });
    return _manager;
}
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    return [MKCADisplayLink manager];
}
-(id)copyWithZone:(struct _NSZone *)zone{
    return [MKCADisplayLink manager];
}

-(void)mkDisPlayLinkPerform:(id)instance withSEL:(NSString *)selString{
    
    SEL selecter = NSSelectorFromString(selString);

    CADisplayLink * disP = [CADisplayLink displayLinkWithTarget:instance selector:selecter];
    self.disPlayLink = disP;
    [self.disPlayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    [self.disPlayLink setPaused:YES];

}

-(void)mkStart{

    [self.disPlayLink setPaused:NO];
}

-(void)mkStop{
    [self.disPlayLink setPaused:YES];
}

-(void)mkCancel{

    [self.disPlayLink invalidate];
    self.disPlayLink = nil;
}

@end
