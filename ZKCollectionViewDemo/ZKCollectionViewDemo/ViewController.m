//
//  ViewController.m
//  05-UICollectionView基本使用
//
//  Created by 闫振奎 on 15/4/21.
//  Copyright © 2015年 only. All rights reserved.
//

#import "ViewController.h"
#import "ZKPhotoCollectionViewCell.h"
#import "ZKFlowLayOut.h"

#define ZKScreenW [UIScreen mainScreen].bounds.size.width
#define ZKScreenH [UIScreen mainScreen].bounds.size.height


@interface ViewController ()<UICollectionViewDataSource>

/** 图片数组 */
@property (nonatomic,strong) NSMutableArray *images;

@end


static NSInteger const cellWH = 220;
static NSString * const ID =@"cell";
static NSInteger const count = 20;

@implementation ViewController



- (NSMutableArray *)images
{
    if (_images == nil) {
        _images = [NSMutableArray array];
        
        for (int i = 0; i < count; i ++) {
            
            NSString *imageName = [NSString stringWithFormat:@"%d",i+1];
            
            UIImage *image = [UIImage imageNamed:imageName];
            
            [_images addObject:image];
        }
    }
    return _images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建布局方式 (这种封装操作一般用于控件的创建)
    ZKFlowLayOut *layOut = ({
        
        layOut = [[ZKFlowLayOut alloc]init];
        
        // 设置Cell的尺寸;
        layOut.itemSize = CGSizeMake(cellWH, cellWH);
        
        // 设置滚动方向
        layOut.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        // 设置最小行间距
        layOut.minimumLineSpacing = 0;
        
        // 设置额外的滚动区域
        CGFloat distance = (ZKScreenW - layOut.itemSize.width) * 0.5;
        layOut.sectionInset = UIEdgeInsetsMake(0, distance, 0, distance);
        
        layOut;
    });
    
    
    
    
    // 创建UICollectionView
    UICollectionView *collectionV =({
        
        UICollectionView *collectionV = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layOut];
        
        collectionV.bounds = CGRectMake(0, 0, ZKScreenW, 250);
        
        collectionV.backgroundColor = [UIColor cyanColor];
        
        collectionV.center = self.view.center;
        
        [self.view addSubview:collectionV];
        
        // 设置数据源
        collectionV.dataSource = self;
        
        collectionV;
        
    });
    
    
    // 注册cell
    [collectionV registerNib:[UINib nibWithNibName:NSStringFromClass([ZKPhotoCollectionViewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:ID];
    
}

#pragma mark -------------------
#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 创建添加cell
    ZKPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    // 设置数据
    UIImage *image = self.images[indexPath.row];
    
    cell.image = image;
    
    return cell;
}




@end
