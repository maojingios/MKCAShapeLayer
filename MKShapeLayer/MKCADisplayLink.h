//
//  MKCADisplayLink.h
//  MKShapeLayer
//
//  Created by gw on 2017/6/23.
//  Copyright © 2017年 VS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MKCADisplayLink : NSObject

+(__kindof MKCADisplayLink *)manager;

-(void)mkDisPlayLinkPerform:(id)instance withSEL:(NSString *)selString;

-(void)mkStart;

-(void)mkStop;

-(void)mkCancel;

@end
