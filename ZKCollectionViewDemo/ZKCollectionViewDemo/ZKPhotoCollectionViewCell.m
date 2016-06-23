//
//  ZKPhotoCollectionViewCell.m
//  05-UICollectionView基本使用
//
//  Created by 闫振奎 on 15/4/21.
//  Copyright © 2015年 only. All rights reserved.
//

#import "ZKPhotoCollectionViewCell.h"

@interface ZKPhotoCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;

@end

@implementation ZKPhotoCollectionViewCell

- (void)awakeFromNib {
    // Initialization code

}


-(void)setImage:(UIImage *)image
{
    _image = image;
    
    // 给当前cell内的imageView赋值图片
    self.photoImageView.image = image;
}

@end
