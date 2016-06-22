//
//  ZKShowBtnView.m
//  scrollView九宫格封装
//
//  Created by 闫振奎 on 16/4/24.
//  Copyright © 2016年 only. All rights reserved.
//

#import "ZKShowBtnView.h"
#import "UIView+Frame.h"
#import "ZKShopButton.h"

@interface ZKShowBtnView ()<UIScrollViewDelegate>
/** 保存按钮的数组 */
@property (nonatomic,strong) NSMutableArray *btnArray;

@property (nonatomic,weak) UIScrollView *scrollV;

/** 保存View的数组 */
@property (nonatomic,strong) NSMutableArray *viewArray;

@end


/** 每页显示的按钮个数 */
static NSInteger const countPerPage = 8;

/** 每行的列数 */
static NSInteger const colsPerRow = 4;

/** 按钮间的间距 */
static CGFloat const margin = 10;

@implementation ZKShowBtnView
/**
    懒加载
 */
- (NSMutableArray *)btnArray
{
    if (_btnArray == nil) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

- (NSMutableArray *)viewArray
{
    if (_viewArray == nil) {
        _viewArray = [NSMutableArray array];
    }
    return _viewArray;
}

/**
 *  1.初始化添加子控件
 */
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 1.创建scrollView
        UIScrollView *scrollV = [[UIScrollView alloc]init];
        
        scrollV.pagingEnabled = YES;
        scrollV.showsHorizontalScrollIndicator =NO;
        scrollV.delegate = self;
        
        _scrollV = scrollV;
        [self addSubview:scrollV];

        
        // 2.添加页码控件
        UIPageControl *pageControl = [[UIPageControl alloc]init];
        _pageControl = pageControl;
        self.pageControl.hidesForSinglePage = YES;
        [self addSubview:pageControl];
    
        
    }
    return self;
}

/**
 *  2.布局子控件位置
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.scrollV.frame = self.bounds;
    
    for (int i = 0; i < self.viewArray.count; i ++) {
        UIView *view = self.viewArray[i];
        view.frame =CGRectMake(self.scrollV.frame.size.width * i, 0, self.scrollV.frame.size.width, self.scrollV.frame.size.height);
    }
    
    self.pageControl.center = CGPointMake(self.scrollV.frame.size.width * 0.5, self.scrollV.frame.size.height + 8);
    

    // 最大行数
    NSInteger maxRows = countPerPage / colsPerRow;
    
    CGFloat btnW = (self.scrollV.frame.size.width - margin * (colsPerRow + 1)) / colsPerRow;
    CGFloat btnH = (self.scrollV.frame.size.height - margin * (maxRows + 1)) / maxRows;;

    for (int i = 0; i < self.btnArray.count; i ++) {
        NSInteger rowsIndex = i / colsPerRow;
        NSInteger colsIndex = i % colsPerRow;
        
        CGFloat btnX = (margin + btnW) * colsIndex + margin;
        CGFloat btnY = (margin + btnH) * rowsIndex + margin;
        
        // 取出数组中的按钮
        NSInteger index = i % countPerPage;
        UIButton *btn = self.btnArray[i];
        
        if (i / countPerPage == 0) {
            btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        }else{
            UIButton *temp = self.btnArray[index];
            CGRect rect = temp.frame;
            btn.frame = rect;
        }
        
    }
    
    // 设置滚动范围
    if (!self.scrollV.contentSize.width) {
        self.scrollV.contentSize = CGSizeMake(self.frame.size.width * ((self.imageNames.count - 1)/ countPerPage + 1), 0);
    }

    
}

-(void)setImageNames:(NSArray *)imageNames
{
    for (UIView *view in self.scrollV.subviews) {
        [view removeFromSuperview];
    }
    _viewArray = nil;
    
    _imageNames = imageNames;
    
    self.btnArray = nil;
    
    // 1.添加View
    for (int i = 0; i < (imageNames.count - 1) / countPerPage + 1; i ++) {
        UIView *v = [[UIView alloc]init];
        [self.scrollV addSubview:v];
        [self.viewArray addObject:v];
    }
    
    // 2.添加按钮
    for (int i = 0; i < self.imageNames.count; i ++) {
        
        ZKShopButton *btn = [[ZKShopButton alloc] init];
        [self.btnArray addObject:btn];
        
        // 取出要添加的那个View
        NSInteger index =i/countPerPage ;
        UIView *view = self.viewArray[index];
        // 将按钮添加到对应的View上
        [view addSubview:btn];
        
        btn.tag = i;
        // 监听按钮点击按钮
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        // 3.设置按钮数据
        UIImage *image = [UIImage imageNamed:imageNames[i]];
        [btn setImage:image forState:UIControlStateNormal];
        [btn setTitle:[NSString stringWithFormat:@"第%ld个按钮",btn.tag] forState:UIControlStateNormal];
        btn.titleLabel.alpha = 0;

    }
    
    // 设置页码数,默认显示第0页
    self.pageControl.numberOfPages = self.viewArray.count;
    

}
// 按钮点击方法
- (void)btnClick:(UIButton *)btn
{
    [UIView animateWithDuration:1.0 animations:^{
        
        btn.titleLabel.alpha = 1.0;
    }];
    
    NSLog(@"点击了第%ld个按钮",btn.tag);
}

#pragma mark -------------------
#pragma mark UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger page = self.scrollV.contentOffset.x/self.scrollV.frame.size.width;
    self.pageControl.currentPage = page;
    self.pageControl.hidesForSinglePage = YES;
}
@end
