//
//  ViewController.m
//  ZKDrawerDemo
//
//  Created by 闫振奎 on 16/6/27.
//  Copyright © 2016年 TowMen. All rights reserved.
//

#import "ViewController.h"
#import "ZKTestOneViewController.h"
#import "ZKTestTwoViewController.h"
#import "ZKThirdViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建控制器
    ZKTestOneViewController *vc1 = [[ZKTestOneViewController alloc] init];
    ZKTestTwoViewController *vc2 = [[ZKTestTwoViewController alloc] init];
    ZKThirdViewController *vc3 = [[ZKThirdViewController alloc] init];
    
    // 添加子控制器
    [self addChildViewController:vc1];
    [self addChildViewController:vc2];
    [self addChildViewController:vc3];
    
    // 设置子控制器View的位置尺寸
    vc1.view.frame = self.leftView.bounds;
    vc2.view.frame = self.mainView.bounds;
    vc3.view.frame = self.rightView.bounds;
    
    // 添加子控件
    [self.leftView addSubview:vc1.view];
    [self.mainView addSubview:vc2.view];
    [self.rightView addSubview:vc3.view];
    
}



@end
