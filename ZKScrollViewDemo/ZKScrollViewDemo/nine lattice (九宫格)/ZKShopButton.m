//
//  ZKShopButton.m
//  ZKScrollViewDemo
//
//  Created by 闫振奎 on 16/6/22.
//  Copyright © 2016年 TowMen. All rights reserved.
//

#import "ZKShopButton.h"
#import "UIView+Frame.h"

@implementation ZKShopButton

/******** 初始化设置 ********/
- (void)awakeFromNib
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:8];
}

/******** 布局子控件位置 ********/
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.zk_y = 0;
    self.titleLabel.backgroundColor = [UIColor greenColor];
    self.imageView.zk_centerX = self.zk_width * 0.5;
    
    /*方法2*/
    [self.titleLabel sizeToFit];
    self.titleLabel.zk_x = (self.zk_width - self.titleLabel.zk_width) * 0.5;
    self.titleLabel.zk_y = self.zk_height - self.titleLabel.zk_height;
    
}

@end
