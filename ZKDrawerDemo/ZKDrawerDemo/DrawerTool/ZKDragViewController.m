//
//  ZKDragViewController.m
//  04-抽屉效果
//
//  Created by 闫振奎 on 16/3/20.
//  Copyright © 2016年 only. All rights reserved.
//

#import "ZKDragViewController.h"

#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height

// X值最大和最小偏移量
#define targetR 275
#define targetL -275

// 最大Y值偏移量
#define mainViewMaxY 100

@interface ZKDragViewController ()

@end

@implementation ZKDragViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.初始化View,添加子控件
    [self setUpView];
    
    
    //  2.添加拖拽手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [_mainView addGestureRecognizer:pan];
    
    /** 3.增加点按手势做复位*/
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        // 手势对象添加给View,当点击屏幕View时,就会复位
    [self.view addGestureRecognizer:tap];
}

-(void)tap
{
    [UIView animateWithDuration:0.5 animations:^{
        _mainView.frame = self.view.bounds;
        [_mainView layoutIfNeeded];
    }];
}


/** 拖拽手势方法 */
-(void) pan:(UIPanGestureRecognizer *)panObj
{
    //获得偏移量
    CGPoint offset = [panObj translationInView:_mainView];
    
    //由于既要改变位置又要改变尺寸,所以要修改mainView的Frame才能做到
    //根据偏移量修改frame
    _mainView.frame = [self frameWithOffset:offset.x];
    
    //复位
    [panObj setTranslation:CGPointZero inView:_mainView];
    
    //根据X值判断View的显示隐藏
    if (_mainView.frame.origin.x > 0) {
        _leftView.hidden = NO;

    }else if(_mainView.frame.origin.x < 0)
    {
        _leftView.hidden = YES;

    }
    
    
/**
 *  定位
 */
    CGFloat target = 0;
    //手指抬起
    if (panObj.state == UIGestureRecognizerStateEnded) {
        
        if (_mainView.frame.origin.x > screenW * 0.5) {
            target = targetR;
        }else if (CGRectGetMaxX(_mainView.frame) < screenW * 0.5){
            target = targetL;
        }
        
        //计算X轴将要移动的偏移量
        CGFloat offsetX = target - self.mainView.frame.origin.x;
        
        [UIView animateWithDuration:0.5 animations:^{
            _mainView.frame = [self frameWithOffset:offsetX];
            [_mainView layoutIfNeeded];
        }];

    }
    
}



#pragma mark 根据X轴偏移量计算mainView最新frame
-(CGRect)frameWithOffset:(CGFloat)offsetX
{
    // 获取上一次mainView的frame
    CGRect frame =  _mainView.frame;
    // 修改frame的X值
    frame.origin.x += offsetX;
    // 修改frame的Y值(fabs()是标示取绝对值)
    frame.origin.y = fabs(frame.origin.x / screenW * mainViewMaxY);
    
    //根据Y值重新计算高度
    frame.size.height = screenH - frame.origin.y * 2;
    
    return frame;
    
}



#pragma mark 初始化View,添加子控件
-(void)setUpView
{
    UIView *rightView = [[UIView alloc]initWithFrame:self.view.bounds];
    rightView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:rightView];
    
    UIView *leftView = [[UIView alloc]initWithFrame:self.view.bounds];
    leftView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:leftView];
    _leftView = leftView;
    
    UIView *mainView = [[UIView alloc]initWithFrame:self.view.bounds];
    mainView.backgroundColor = [UIColor redColor];
    _mainView = mainView;
    [self.view addSubview:mainView];
    _rightView = rightView;
}

@end
