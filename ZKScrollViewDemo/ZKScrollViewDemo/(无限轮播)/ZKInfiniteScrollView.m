//
//  ZKInfiniteScrollView.m
//  (ZK)scrollView的无限循环展示图片
//
//  Created by 闫振奎 on 15/4/20.
//  Copyright © 2015年 only. All rights reserved.
//

#import "ZKInfiniteScrollView.h"

// 定时器时间间隔
static CGFloat const TimeInterval = 3.0;

@interface ZKInfiniteScrollView ()<UIScrollViewDelegate>

@property (nonatomic,weak) UIScrollView *scrollView;
@property (nonatomic,weak) UIImageView *centerImageV;
@property (nonatomic,weak) UIImageView *reuseImageV;

/** 记录当前页码 */
@property (nonatomic,assign) NSInteger pageIndex;
/** 定时器 */
@property (nonatomic,weak) NSTimer *timer;

@end

@implementation ZKInfiniteScrollView

#pragma mark -------------------
#pragma mark 类工厂方法
+(ZKInfiniteScrollView *)infiniteScrollView
{
    return [[self alloc]init];
}


// 1.初始化方法中添加子控件
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 1.添加scrollView滚动视图
        UIScrollView *scrollView = [[UIScrollView alloc]init];

        scrollView.pagingEnabled = YES;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.delegate = self;

        
        
        _scrollView = scrollView;
        
        [self addSubview:scrollView];
        
        
        // 2.添加pageControl页码控件
        UIPageControl *pageControl = [[UIPageControl alloc]init];
            // 设置单页隐藏功能
        pageControl.hidesForSinglePage = YES;
        
        _pageControl = pageControl;
        
        [self addSubview:pageControl];
        
        // 3.添加图片视图
        UIImageView *centerImageV = [[UIImageView alloc]init];

        UIImageView *reuseImageV = [[UIImageView alloc]init];

        _centerImageV = centerImageV;
        
        _reuseImageV = reuseImageV;
        
        [self.scrollView addSubview:centerImageV];
        
        [self.scrollView addSubview:reuseImageV];
        
    }
    return self;
}

// 2.布局子控件
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat scrollViewW = self.scrollView.frame.size.width;
    CGFloat scrollViewH = self.scrollView.frame.size.height;
    
    // 1.scrollView位置
    self.scrollView.frame = self.bounds;
    
    // 2.pageControl位置
    CGFloat pageW = 150;
    CGFloat pageH = 30;
    CGFloat pageX = self.scrollView.frame.size.width - pageW;
    CGFloat pageY = self.scrollView.frame.size.height - pageH;
    
    self.pageControl.frame = CGRectMake(pageX, pageY, pageW, pageH);
    
    // 3.图片控件位置
    self.reuseImageV.frame = CGRectMake(0, 0, scrollViewW, scrollViewH);
    self.centerImageV.frame = CGRectMake(scrollViewW, 0, scrollViewW, scrollViewH);
    
    
    self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
//    NSLog(@"%@",NSStringFromCGPoint(self.scrollView.contentOffset));
    if (!self.scrollView.contentSize.width) {
        self.scrollView.contentSize = CGSizeMake(self.frame.size.width * 3, 0);
//        NSLog(@"%@",NSStringFromCGSize(self.scrollView.contentSize));
    }
    
}

// 3. 传递图片数组
-(void)setImageNames:(NSArray *)imageNames
{
    // 取消之前的定时器
    [self.timer invalidate];
    // 清空之前的数据
    _imageNames = nil;
    
    _imageNames = imageNames;
    
    // 设置页码
    self.pageControl.numberOfPages = imageNames.count;
    self.pageControl.currentPage = 0;
    
    //设置默认图片(图片名字数组第一个为默认图片)
    NSString *imageName = _imageNames[0];
    _centerImageV.image = [UIImage imageNamed:imageName];
    
    // 开始定时器
    [self startTimer];
    
}


#pragma mark -------------------
#pragma mark UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 获取scrollViewx轴方向的偏移量
    CGFloat offSetX = scrollView.contentOffset.x;
    
    // scrollView的宽度
    CGFloat w = scrollView.frame.size.width;
    
    // 记录当前第几页
    NSInteger index = 0;
    
    // 获取reuseImageV的frame
    CGRect reuseImageVFrame = self.reuseImageV.frame;
    
    // 2.如果偏移量>w(scrollView的宽度)向右滚动;如果偏移量<w(scrollView的宽度)向左滚动
    if (offSetX > self.centerImageV.frame.origin.x) {
        //如果是向右滚动
        //让重复利用的图片X在中间ImageView的后面.
         reuseImageVFrame.origin.x = CGRectGetMaxX(self.centerImageV.frame);
        // 设置页码数
        index = self.centerImageV.tag + 1;
        // 判断(如果页码数大于总个数,从第0页开始)
        if (index > self.imageNames.count - 1) {
            // 从第0页开始
            index = 0;
        }
        
    }else{
        //如果是向左滚动.
        //设置重复利用的图片X在左侧,0的位置
        reuseImageVFrame.origin.x = 0;
        // 设置页码数
        index = self.centerImageV.tag - 1;
        // 判断(如果页码数小于0,从最后一页开始)
        if (index < 0) {
            // 从最大页数开始
            index = self.imageNames.count - 1;
        }
    }
    
    // 设置reuseImageV图片的位置
    self.reuseImageV.frame = reuseImageVFrame;
    
    // 让重复利用的图片的tag等于当前要跳转的页码数(注意这一步必须要有,这样交换指针后下次取出来self.centerImageV.tag才等于当前页码,下次取出来的self.centerImageV.tag值才正确)
    _reuseImageV.tag = index;
    
    // 设置重复利用的图片
    NSString *imageName = self.imageNames[index];
    self.reuseImageV.image = [UIImage imageNamed:imageName];
    
    // 设置循环利用(设置如果滚动到最左侧,或者滚动到最右侧.)
    if (offSetX <= 0 || offSetX >= 2 * w) {
        // 交换中间的图片 和 重复利用图片的两个指针指向
        UIImageView *temp = self.centerImageV;
        self.centerImageV = self.reuseImageV;
        self.reuseImageV = temp;
        
        // 交换两个图片的位置
        CGRect temp2 = self.centerImageV.frame;
        self.centerImageV.frame = self.reuseImageV.frame;
        self.reuseImageV.frame = temp2;
        
//        NSLog(@"%ld",self.centerImageV.tag);
//        NSLog(@"%ld",self.reuseImageV.tag);
        //初始化scrollView的偏移量(显示中间部分)
        scrollView.contentOffset = CGPointMake(w, 0);
        
        // 当滚动到最左侧,或则最右侧停止滚动时,记录当前的页码._centerImageV.tag就是当前的页码数
        // 设置当前pageControl显示的页码数
        self.pageControl.currentPage = _centerImageV.tag;
    }
}

// 将要开始拖拽时调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}

// 已经停止拖拽时调用
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 当减速完成时初始化scrollView的偏移量(显示中间部分)
    [scrollView setContentOffset:CGPointMake(scrollView.frame.size.width, 0) animated:YES];

}

#pragma mark - 定时器处理
- (void)startTimer
{
    NSTimer *timer = [NSTimer timerWithTimeInterval:TimeInterval target:self selector:@selector(next) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}

- (void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)next
{
    // 注意设置ContentOffset时,会自动调用scrollViewDidScroll方法
    [self.scrollView setContentOffset:CGPointMake(2 * self.scrollView.frame.size.width, 0) animated:YES];
}

@end
