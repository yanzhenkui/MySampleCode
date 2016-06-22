//
//  UIView+Frame.m
//  百思不得姐(ZK)
//
//  Created by 闫振奎 on 16/4/25.
//  Copyright © 2016年 only. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

/** 宽度的getter,setter方法 */
- (CGFloat)zk_width
{
    return self.frame.size.width;
}

- (void)setZk_width:(CGFloat)zk_width
{
    CGRect frame = self.frame;
    frame.size.width = zk_width;
    self.frame = frame;
}

/** 高度的getter,setter方法 */
- (CGFloat)zk_height
{
    return self.frame.size.height;
}

- (void)setZk_height:(CGFloat)zk_height
{
    CGRect frame = self.frame;
    frame.size.height = zk_height;
    self.frame = frame;
}

/** X值的getter,setter方法 */
- (CGFloat)zk_x
{
    return self.frame.origin.x;
}

- (void)setZk_x:(CGFloat)zk_x
{
    CGRect frame = self.frame;
    frame.origin.x = zk_x;
    self.frame = frame;
}

/** Y值的getter,setter方法 */
- (CGFloat)zk_y
{
    return self.frame.origin.y;
}

- (void)setZk_y:(CGFloat)zk_y
{
    CGRect frame = self.frame;
    frame.origin.y = zk_y;
    self.frame = frame;
}


/** centerX值的getter,setter方法 */
- (CGFloat)zk_centerX
{
    return self.center.x;
}

- (void)setZk_centerX:(CGFloat)zk_centerX
{
    CGPoint center = self.center;
    center.x = zk_centerX;
    self.center = center;
}


/** centerY值的getter,setter方法 */
-(CGFloat)zk_centerY
{
    return self.center.y;
}

-(void)setZk_centerY:(CGFloat)zk_centerY
{
    CGPoint center = self.center;
    center.y = zk_centerY;
    self.center = center;
}

/** 控件size值的getter,setter方法 */
-(CGSize)zk_size
{
    return self.frame.size;
}

-(void)setZk_size:(CGSize)zk_size
{
    CGRect frame = self.frame;
    frame.size = zk_size;
    self.frame = frame;
}

/** 控件right值的getter,setter方法 */
-(CGFloat)zk_right
{
    return CGRectGetMaxX(self.frame);
}

-(void)setZk_right:(CGFloat)zk_right
{
    self.zk_x = zk_right - self.zk_width;
}

/** 控件bottom值的getter,setter方法 */
-(CGFloat)zk_bottom
{
    return CGRectGetMaxY(self.frame);
}

-(void)setZk_bottom:(CGFloat)zk_bottom
{
    self.zk_y = zk_bottom - self.zk_height;
}

@end
