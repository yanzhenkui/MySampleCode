//
//  ZKTestTwoViewController.m
//  ZKDrawerDemo
//
//  Created by 闫振奎 on 16/6/27.
//  Copyright © 2016年 TowMen. All rights reserved.
//

#import "ZKTestTwoViewController.h"

#define ZKScreenW [UIScreen mainScreen].bounds.size.width
#define ZKScreenH [UIScreen mainScreen].bounds.size.height

static CGFloat  const smallLabelW = 80;
static CGFloat  const smallLabelH = 40;

@interface ZKTestTwoViewController ()

@property (nonatomic,strong) UIImageView *myImageView ;
@property (nonatomic,strong) UILabel *label1 ;
@property (nonatomic,strong) UILabel *label2 ;
@property (nonatomic,strong) UILabel *label3 ;

@end

@implementation ZKTestTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *myImageView = [[UIImageView alloc] init];
    myImageView.image = [UIImage imageNamed:@"2"];
    _myImageView = myImageView;
    [self.view addSubview:myImageView];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.text = @"我是控制器TestTwo的View";
    label1.textAlignment = NSTextAlignmentCenter;
    label1.font = [UIFont systemFontOfSize:20];
    label1.textColor = [UIColor purpleColor];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.text = @"向左拖拽";
    label2.textAlignment = NSTextAlignmentCenter;
    label2.textColor = [UIColor purpleColor];

    
    UILabel *label3 = [[UILabel alloc] init];
    label3.text = @"向右拖拽";
    label3.textAlignment = NSTextAlignmentCenter;
    label3.textColor = [UIColor purpleColor];
    
    _label1 = label1;
    _label2 = label2;
    _label3 = label3;
    [self.view addSubview:label1];
    [self.view addSubview:label2];
    [self.view addSubview:label3];
}


- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];


    self.myImageView.frame = self.view.bounds;
    self.label1.frame = CGRectMake(0, 0, ZKScreenW, smallLabelW);
    self.label2.frame = CGRectMake(0, self.view.bounds.size.height * 0.5, smallLabelW, smallLabelH);
    self.label3.frame = CGRectMake(self.view.bounds.size.width-smallLabelW, self.view.bounds.size.height * 0.5, smallLabelW, smallLabelH);
    
    
}


@end
