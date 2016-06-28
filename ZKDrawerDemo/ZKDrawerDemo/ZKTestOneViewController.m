//
//  ZKTestOneViewController.m
//  ZKDrawerDemo
//
//  Created by 闫振奎 on 16/6/27.
//  Copyright © 2016年 TowMen. All rights reserved.
//

#import "ZKTestOneViewController.h"

#define ZKScreenW [UIScreen mainScreen].bounds.size.width
#define ZKScreenH [UIScreen mainScreen].bounds.size.height


@interface ZKTestOneViewController ()

@property (nonatomic,strong) UIImageView *myImageView ;
/** label */
@property (nonatomic,strong) UILabel *label ;

@end

@implementation ZKTestOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *myImageView = [[UIImageView alloc] init];
    myImageView.image = [UIImage imageNamed:@"0"];
    _myImageView = myImageView;
    [self.view addSubview:myImageView];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"我是控制器TestOne的View";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:20];
    label.textColor = [UIColor greenColor];
    _label = label;
    [self.view addSubview:label];
    
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.myImageView.frame = self.view.bounds;
    self.label.frame = CGRectMake(0, 0, ZKScreenW, 100);
}



@end
