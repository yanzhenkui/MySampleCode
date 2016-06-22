//
//  ZKInfiniteViewController.m
//  ZKScrollViewDemo
//
//  Created by 闫振奎 on 15/4/20.
//  Copyright © 2015年 only. All rights reserved.
//

#import "ZKInfiniteViewController.h"
#import "ZKInfiniteScrollView.h"

@interface ZKInfiniteViewController ()

@end

@implementation ZKInfiniteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 1.创建一个UIScrollView
    ZKInfiniteScrollView *infiniteView= [ZKInfiniteScrollView infiniteScrollView];
    
    // 2.设置控件的frame
//    infiniteView.frame = self.view.bounds;
    infiniteView.frame = CGRectMake(37, 100, 300, 400);
    // 3.添加控件
    [self.view addSubview:infiniteView];
    
    // 4.给控件传数据
    //    scrollView.imageNames = @[@"00",@"01",@"02"];
    
    // 设置页码颜色
    infiniteView.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    infiniteView.pageControl.currentPageIndicatorTintColor = [UIColor yellowColor];
    
    infiniteView.imageNames = @[@"00",@"01",@"03"];
    
}



@end
