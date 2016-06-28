//
//  ZKThirdViewController.m
//  ZKDrawerDemo
//
//  Created by 闫振奎 on 16/6/27.
//  Copyright © 2016年 TowMen. All rights reserved.
//

#import "ZKThirdViewController.h"

@interface ZKThirdViewController ()

@property (nonatomic,strong) UIImageView *myImageView ;
@property (nonatomic,strong) UILabel *label ;

@end

@implementation ZKThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *myImageView = [[UIImageView alloc] init];
    myImageView.image = [UIImage imageNamed:@"3"];
    _myImageView = myImageView;
    [self.view addSubview:myImageView];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"我是控制器TestThree的View";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:20];
    label.textColor = [UIColor orangeColor];
    _label = label;
    [self.view addSubview:label];
    

}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.myImageView.frame = self.view.bounds;
    self.label.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100);
    
}

@end
