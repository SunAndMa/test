//
//  ViewController.m
//  test
//
//  Created by 孙继桐 on 2020/2/15.
//  Copyright © 2020 Sun. All rights reserved.
//

#import "ViewController.h"
#import "RepView.h"

@interface ViewController ()
@property (nonatomic,weak) CALayer *layer;

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    //这是我的1版本
    //这里是2版本
    //3版本
    //4banben

    //5banben
    //dev分支
    //dev new
    // Do any additional setup after loading the view. 
    
}


- (void)test1 {
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(100, 100, 100, 100);
    layer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:layer];
    self.layer = layer;
    
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"position"];
    ani.fromValue = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    ani.toValue = [NSValue valueWithCGPoint:CGPointMake(100, 500)];
    ani.duration = 10;
    ani.removedOnCompletion = NO;
    ani.fillMode = kCAFillModeForwards;
    [layer addAnimation:ani forKey:nil];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(200, 100, 50, 50);
    [btn1 setTitle:@"暂停" forState:UIControlStateNormal];
    [btn1 setBackgroundColor:[UIColor redColor]];
    [btn1 addTarget:self action:@selector(btn1:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(200, 200, 50, 50);
    [btn2 setTitle:@"回复" forState:UIControlStateNormal];
    [btn2 setBackgroundColor:[UIColor redColor]];
    [btn2 addTarget:self action:@selector(btn2:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
}

- (void)btn1:(CALayer *)layer {
    CFTimeInterval pausedTime = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    
    //让CALayer的时间停止走动
    self.layer.speed = 0.0;
    //让CALayer的时间停留在pausedTime这个时刻
    self.layer.timeOffset = pausedTime;
}

- (void)btn2:(CALayer *)layer {
    CFTimeInterval pausedTime = self.layer.timeOffset;
    //1. 让CALayer的时间继续行走
    self.layer.speed = 1.0;
    //2. 取消上次记录的停留时刻
    self.layer.timeOffset = 0.0;
    //3. 取消上次设置的时间
    self.layer.beginTime = 0.0;
    //4. 计算暂停的时间(这里也可以用CACurrentMediaTime()-pausedTime)
    CFTimeInterval timeSincePause = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    //5. 设置相对于父坐标系的开始时间(往后退timeSincePause)
    self.layer.beginTime = timeSincePause;
}


@end
