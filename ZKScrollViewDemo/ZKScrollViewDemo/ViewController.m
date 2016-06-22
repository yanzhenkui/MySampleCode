//
//  ViewController.m
//  ZKScrollViewDemo
//
//  Created by 闫振奎 on 16/6/22.
//  Copyright © 2016年 TowMen. All rights reserved.
//

#import "ViewController.h"
#import "ZKInfiniteViewController.h"
#import "ZKNineLatticeViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 70;
    
}


#pragma mark -------------------
#pragma mark 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * const ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"两个imageView实现图片无限轮播";
    }else if (indexPath.row == 1) {
        cell.textLabel.text = @"scrollView的九宫格封装";
    }
    return cell;
}


#pragma mark -------------------
#pragma mark 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        ZKInfiniteViewController *infiniteVC = [[ZKInfiniteViewController alloc] init];
        [self.navigationController pushViewController:infiniteVC animated:YES];
    }else if (indexPath.row == 1) {
        ZKNineLatticeViewController *nineLatticeVC = [[ZKNineLatticeViewController alloc] init];
        [self.navigationController pushViewController:nineLatticeVC animated:YES];
    }
}

@end
