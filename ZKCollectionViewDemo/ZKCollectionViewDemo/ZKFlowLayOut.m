//
//  ZKFlowLayOut.m
//  05-UICollectionView基本使用
//
//  Created by 闫振奎 on 14/4/21.
//  Copyright © 2014年 only. All rights reserved.
//

#import "ZKFlowLayOut.h"

#define ZKScreenW [UIScreen mainScreen].bounds.size.width
#define ZKScreenH [UIScreen mainScreen].bounds.size.height

@implementation ZKFlowLayOut

/*
 自定义UICollectionView布局:了解5个方法
 
 - (void)prepareLayout;
 
 - (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect;
 
 - (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds; // return YES to cause the collection view to requery the layout for geometry information
 
 - (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity; // return a point at which to rest after scrolling - for layouts that want snap-to-point scrolling behavior
 
 - (CGSize)collectionViewContentSize;
 
 */

/*
 UICollectionViewLayoutAttributes:描述cell的布局
 每一个cell就对应一个UICollectionViewLayoutAttributes
 只要拿到UICollectionViewLayoutAttributes,相当于拿到cell
 */


// 什么时候调用:当用户停止拖拽时就会调用该方法
// 作用:决定最终的偏移量
// proposedContentOffset:表示预计最终的偏移量
// self.collectionView.contentOffset:表示手指离开一瞬间当前的偏移量

// 定位:
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    // 1.获取最终显示区域
    CGRect lastRect = CGRectMake(proposedContentOffset.x, 0, ZKScreenW, MAXFLOAT);
    // 2.获取最终显示的Cell布局
    NSArray *attrs = [super layoutAttributesForElementsInRect:lastRect];
    
    CGFloat minDelta = MAXFLOAT;
    // 3.遍历所有的cell,获取距离中心点最近的那个距离
    for (UICollectionViewLayoutAttributes *attr in attrs) {
        
        //  计算每个Cell距离CollectionView中心点的距离
        CGFloat delta = attr.center.x - (proposedContentOffset.x + ZKScreenW * 0.5);
        
        if (fabs(delta) < fabs(minDelta)) {
            minDelta = delta;
        }
        NSLog(@"minDelta=%lf",minDelta);
        
    }
    proposedContentOffset.x += minDelta;
    NSLog(@"proposedContentOffset.x = %lf",proposedContentOffset.x);
    
    
    // 排除proposedContentOffset.x = - 0的bug
    if (proposedContentOffset.x < 0) {
        proposedContentOffset.x = 0;
    }
    
    return proposedContentOffset;
}


/*
 什么时候调用:设置cell布局时调用
 作用:
  返回数组就是cell的布局'
  指定一段区域,就能返回这段区域内的所有cell
  可以一次性返回所有cell的布局
 */
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    // 1.获取当前显示的cell
    NSArray *attrs =[super layoutAttributesForElementsInRect:self.collectionView.bounds];
    
    // 2.遍历当前显示的所有的Cell
    for(UICollectionViewLayoutAttributes *attr in attrs){
        
        //  计算每个Cell距离CollectionView中心点的距离
        CGFloat delta = fabs(attr.center.x - (self.collectionView.contentOffset.x + ZKScreenW * 0.5));
        
        // 获取缩放比例
        CGFloat scale = 1 - delta / (ZKScreenW * 0.5) * 0.25;
        
        attr.transform = CGAffineTransformMakeScale(scale, scale);
        
    }
    

    return attrs;

}

// 当bounds改变(滑动界面)时是否刷新界面布局
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
//    int i = [super shouldInvalidateLayoutForBoundsChange:newBounds];
//    NSLog(@"%d",i);
    return YES;
}


@end
