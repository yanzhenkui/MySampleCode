//
//  ZKWaterflowLayout.h
//  ZKWaterflow(瀑布流)
//
//  Created by 闫振奎 on 16/6/22.
//  Copyright © 2016年 TowMen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZKWaterflowLayout;

@protocol ZKWaterflowLayoutDelegate <NSObject>
@required
- (CGFloat)waterflowLayout:(ZKWaterflowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth;

@optional
- (CGFloat)columnCountInWaterflowLayout:(ZKWaterflowLayout *)waterflowLayout;
- (CGFloat)columnMarginInWaterflowLayout:(ZKWaterflowLayout *)waterflowLayout;
- (CGFloat)rowMarginInWaterflowLayout:(ZKWaterflowLayout *)waterflowLayout;
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(ZKWaterflowLayout *)waterflowLayout;
@end


@interface ZKWaterflowLayout : UICollectionViewLayout
/** 代理 */
@property (nonatomic, weak) id<ZKWaterflowLayoutDelegate> delegate;
@end
