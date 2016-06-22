//
//  ZKInfiniteScrollView.h
//  (ZK)scrollView的无限循环展示图片
//
//  Created by 闫振奎 on 15/4/20.
//  Copyright © 2015年 only. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZKInfiniteScrollView : UIView

/** 要传入的图片名称数组 */
@property (nonatomic,strong) NSArray *imageNames;

/** 页码控件 */
@property (nonatomic,weak) UIPageControl *pageControl;

+(ZKInfiniteScrollView *)infiniteScrollView;

@end
