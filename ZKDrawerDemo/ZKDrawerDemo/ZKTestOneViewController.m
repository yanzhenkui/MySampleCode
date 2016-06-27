//
//  ZKTestOneViewController.m
//  ZKDrawerDemo
//
//  Created by 闫振奎 on 16/6/27.
//  Copyright © 2016年 TowMen. All rights reserved.
//

#import "ZKTestOneViewController.h"

@interface ZKTestOneViewController ()

@property (nonatomic,strong) UIImageView *myImageView ;

@end

@implementation ZKTestOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *myImageView = [[UIImageView alloc] init];
    myImageView.image = [UIImage imageNamed:@"0"];
    _myImageView = myImageView;
    [self.view addSubview:myImageView];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.myImageView.frame = self.view.bounds;
    
}



@end
