//
//  ZKNineLatticeViewController.m
//  ZKScrollViewDemo
//
//  Created by 闫振奎 on 14/8/22.
//  Copyright © 2014年 TowMen. All rights reserved.
//

#import "ZKNineLatticeViewController.h"
#import "ZKShowBtnView.h"


@interface ZKNineLatticeViewController ()

@end

@implementation ZKNineLatticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;

    
    // 1.创建
    ZKShowBtnView *showBtnV = [[ZKShowBtnView alloc]init];
    
    // 2.设置位置尺寸
    showBtnV.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height * 0.8);

    
    
    // 3.添加控件
    [self.view addSubview:showBtnV];
    
    // 设置页码颜色
    showBtnV.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    showBtnV.pageControl.currentPageIndicatorTintColor = [UIColor yellowColor];
    
    
    // 4.添加数据(保证重复赋值没有问题)
    showBtnV.imageNames = @[@"00",@"01",@"02",@"03"];
    
    showBtnV.imageNames = @[@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"07",@"06",@"05",@"04",@"03",@"02",@"01",@"00",@"07"];
}


@end
