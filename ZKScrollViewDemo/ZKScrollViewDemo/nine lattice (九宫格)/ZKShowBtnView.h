//
//  ZKShowBtnView.h
//  scrollView九宫格封装
//
//  Created by 闫振奎 on 16/4/24.
//  Copyright © 2016年 only. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZKShowBtnView : UIView
/** 模型数组 */
@property (nonatomic,strong) NSArray *imageNames;

/** 页码 */
@property (nonatomic,weak,readonly) UIPageControl *pageControl;
@end
