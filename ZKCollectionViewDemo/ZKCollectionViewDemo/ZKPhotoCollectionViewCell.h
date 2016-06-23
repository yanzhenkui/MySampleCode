//
//  ZKPhotoCollectionViewCell.h
//  05-UICollectionView基本使用
//
//  Created by 闫振奎 on 15/4/21.
//  Copyright © 2015年 only. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZKPhotoCollectionViewCell : UICollectionViewCell

/** 定义一个属性借口,接收数据,如果接收一个数据,如下;如接收多个数据使用数组结收 */
@property (nonatomic,strong) UIImage *image;

@end
