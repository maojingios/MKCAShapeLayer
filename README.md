## 前言

* 本篇是针对前期关于CAShapeLayer、CADisplayLink、UIBezierPath等相关技术的整理和总结。很长一段时间都处于赶项目状态，即使boss口口声声说：“这个月周末加加班，等项目上架后，调调修、、、”。不说还好，一说就假啦😀！得益于代码强健，拓展性好，近期新增功能，客户端调整很小，得空整理下，一则温故知新；二则练练文字！（最主要还是跟大家分享交流，欢迎拍砖！）。
 
* 言归正传，本篇最终会介绍如何使用CAShapeLayer、CADisplayLink绘制水波浪效果。如下：


## 拓展
##### 在完成最终目的前，就相关设计技术点进行一下拓展。

* 关于CAShapeLayer和UIBezierPath。

     >  关于CAShapeLayer？
		
	1、CAShapeLayer继承自CALayer，可使用CALayer的所有属性
	2、CAShapeLayer需要和贝塞尔曲线配合使用才有意义。
	3、贝塞尔曲线可以为其提供形状，而单独使用CAShapeLayer意义不大。
	4、使用CAShapeLayer与贝塞尔曲线可以实现不在view的DrawRect方法中画出一些想要的图形
		
	> 关于CAShapeLayer和DrawRect的比较？
		
	1、DrawRect：DrawRect属于CoreGraphic框架，占用CPU，消耗性能大
	2、CAShapeLayer：CAShapeLayer属于CoreAnimation框架，通过GPU来渲染图形，节省性能。动画渲染直接提交给手机GPU。
		
	> 贝塞尔曲线与CAShapeLayer的关系
	
	1、CAShapeLayer中shape代表形状的意思，所以需要形状才能生效
	2、贝塞尔曲线可以创建基于矢量的路径
	3、贝塞尔曲线给CAShapeLayer提供路径，CAShapeLayer在提供的路径中进行渲染。路径会闭环，所以绘制出了Shape
	4、用于CAShapeLayer的贝塞尔曲线作为Path，其path是一个首尾相接的闭环的曲线，即使该贝塞尔曲线不是一个闭环的曲线
		

		
* Demo

	> 这里总结了将UIBezierPath描述路径赋给CAShapeLayer的用法。详见工程BasicUseView。		
	
	
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
	
* CADisplayLink

 > 简介
	
		 CADisplayLink是一个能让我们以和屏幕刷新率相同的频率将内容画到屏幕上的定时器。
		 我们在应用中创建一个新的 CADisplayLink 对象，把它添加到一个runloop中，并给它提供一个 target 和selector 在屏幕刷新的时候调用。
		
	> 与NSTimer区别
		
		iOS设备的屏幕刷新频率是固定的，CADisplayLink在正常情况下会在每次刷新结束都被调用，精确度相当高。
		NSTimer的精确度就显得低了点，比如NSTimer的触发时间到的时候，runloop如果在阻塞状态，触发时间就会推迟到下一个runloop周期。并且 NSTimer新增了tolerance属性，让用户可以设置可以容忍的触发的时间的延迟范围。
		CADisplayLink使用场合相对专一，适合做UI的不停重绘，比如自定义动画引擎或者视频播放的渲染。NSTimer的使用范围要广泛的多，各种需要单次或者循环定时处理的任务都可以使用。
		在UI相关的动画或者显示内容使用 CADisplayLink比起用NSTimer的好处就是我们不需要在格外关心屏幕的刷新频率了，因为它本身就是跟屏幕刷新同步的。
		
* Demo
	> 	这里总结了CADisplayLink的用法。详见MKCADisplayLink单利类
		
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

* 正弦曲线

		定义：
		正弦曲线可表示为y=Asin(ωx+φ)+k，定义为函数y=Asin(ωx+φ)+k在直角坐标系上的图象，其中sin为正弦符号，x是直角坐标系x轴上的数值，y是在同一直角坐标系上函数对应的y值，k、ω和φ是常数（k、ω、φ∈R且ω≠0）
		
		参数定义：
		A——振幅，当物体作轨迹符合正弦曲线的直线往复运动时，其值为行程的1/2。
		(ωx+φ)——相位，反映变量y所处的状态。
		φ——初相，x=0时的相位；反映在坐标系上则为图像的左右移动。
		k——偏距，反映在坐标系上则为图像的上移或下移。
		ω——角速度， 控制正弦周期(单位角度内震动的次数)。

## 应用
		
 * 这里将利用CAShapeLayer、CADisplayLink、UIBezierPath具体运用到三个简单的场景中，这里您看到的是gif图，有点卡顿，将工程运行起来后效果会更加流畅。直接上效果，就不使用文字过多描述。
		
> 1.我们将利用CAShapeLayer、UIBezierPath完成画圆圈效果。注意strokeEnd运用。详见：CircleProgressBar类：
		
 ![](https://github.com/maojingios/MKCAShapeLayer/blob/master/circle.gif)
    
> 2.对勾效果。详见：MKCheckButton类：

 ![](https://github.com/maojingios/MKCAShapeLayer/blob/master/对勾.gif)
 
> 3.水波浪效果。详见：MKWave类：

  ![](https://github.com/maojingios/MKCAShapeLayer/blob/master/wave.gif)
  
## 总结
		
#####  CAShapeLayer 和 UIBezierPath 配合使用可以完成非常惊艳的效果，这里只是简单应用。网上也是有很多牛人分享的效果，都是非常好的学习资源。另外，体会最深的感觉是：想做出富有创新的效果，数学基础和动效设计基础相当重要。（分享结束，欢迎拍砖哦！）
