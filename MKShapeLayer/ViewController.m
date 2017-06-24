//
//  ViewController.m
//  MKShapeLayer
//
//  Created by gw on 2017/6/22.
//  Copyright © 2017年 VS. All rights reserved.
//

/** 物理屏幕宽高**/
#define SCREENW [UIScreen mainScreen].bounds.size.width
#define SCREENH [UIScreen mainScreen].bounds.size.height

#import "ViewController.h"
#import "BasicUseView.h"
#import "MKCheckButton.h"
#import "CircleProgressBar.h"
#import "MKCADisplayLink.h"
#import "MKWave.h"

@interface ViewController ()

@property (nonatomic, readwrite, weak)BasicUseView * basicUseView;
@property (nonatomic, readwrite, weak)MKCheckButton * mkButton;
@property (nonatomic, readwrite, weak)CircleProgressBar * circleProgressBarView;
@property (nonatomic, readwrite, weak)MKWave * waveView;
@property (nonatomic, readwrite, weak)MKWave * waveView1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

//    [self basicUseViewAPI];
    
//    [self showMKButton];
    
    
//    [[MKCADisplayLink manager] mkDisPlayLinkPerform:self withSEL:@"callBack"];
//    [[MKCADisplayLink manager] mkStart];

    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

        [self mkWave];
//    [self showCircleProgressBarView];
}


#pragma mark - mkWave

-(void)mkWave{
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, SCREENH/2.0, SCREENW, SCREENH/2.0)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];

    self.waveView.waveColor = [UIColor redColor];
    self.waveView.waveSpeed = 10.0f;
    [self.waveView mkStart];

//    self.waveView1.waveColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
//    self.waveView1.waveSpeed = 11.0f;
//    self.waveView1.angularSpeed = 1.2;
//    [self.waveView1 mkStart];
}

#pragma mark - CADisplayLink 简单实用
-(void)callBack{
    NSLog(@"callBack");
}

#pragma mark - CAShapeLayer 与 UIBesierPath  基本用法
-(void)basicUseViewAPI{

    [self.basicUseView bezierPathWithArc];
}

#pragma mark - CAShapeLayer 、 UIBesierPath 、CAAnimation  基本用法
-(void)showMKButton{

    self.mkButton.backgroundColor = [UIColor lightGrayColor];
}

-(void)showCircleProgressBarView{

    self.circleProgressBarView.backgroundColor = [UIColor lightGrayColor];
}

#pragma mark - lazy load

-(MKWave *)waveView{
    if (!_waveView) {
        MKWave * view = [MKWave addToSuperView:self.view withFrame:CGRectMake(0, SCREENH/2.0 -40, SCREENW, 40)];
        _waveView = view;
    }
    return _waveView;
}
-(MKWave *)waveView1{
    if (!_waveView1) {
        MKWave * view = [MKWave addToSuperView:self.view withFrame:CGRectMake(0, SCREENH/2.0 -40, SCREENW, 40)];
        _waveView1 = view;
    }
    return _waveView1;
}

-(CircleProgressBar *)circleProgressBarView{
    if (!_circleProgressBarView) {
        CircleProgressBar * view = [[CircleProgressBar alloc]initWithFrame:CGRectMake(0, 0, SCREENW, SCREENH/2.0)];
        _circleProgressBarView = view;
        [self.view addSubview:_circleProgressBarView];
        
    }
    return _circleProgressBarView;
}

-(MKCheckButton *)mkButton{
    if (!_mkButton) {
        MKCheckButton * button = [[MKCheckButton alloc]init];
        _mkButton = button;
        _mkButton.frame = CGRectMake(0, 0, 200, 50);
        _mkButton.center = CGPointMake(SCREENW/2.0, SCREENH/2.0);
        [self.view addSubview:_mkButton];
    }
    return _mkButton;
}

-(BasicUseView *)basicUseView{
    if (!_basicUseView) {
        BasicUseView * view = [[BasicUseView alloc]initWithFrame:CGRectMake(0, 0, SCREENW, SCREENH)];
        _basicUseView = view;
        [self.view addSubview:_basicUseView];
    }
    return _basicUseView;
}

#pragma mark - click events
- (IBAction)clearSbViews:(UIButton *)sender {
    NSArray * arr = [self.view subviews];
        for (UIView * v in arr) {
        if (![v isKindOfClass:[UIButton class]]) {
            [v removeFromSuperview];
        }
    }
}

- (IBAction)reStart:(UIButton *)sender {
    
    [self clearSbViews:nil];
    
    [self viewDidLoad];
}


@end
