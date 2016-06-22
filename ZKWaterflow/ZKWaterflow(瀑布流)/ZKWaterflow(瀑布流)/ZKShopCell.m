//
//  ZKShopCell.m
//  ZKWaterflow(瀑布流)
//
//  Created by 闫振奎 on 16/6/22.
//  Copyright © 2016年 TowMen. All rights reserved.
//

#import "ZKShopCell.h"
#import "ZKShop.h"
#import "UIImageView+WebCache.h"

@interface ZKShopCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@end
@implementation ZKShopCell

- (void)setShop:(ZKShop *)shop
{
    _shop = shop;
    
    // 1.图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:shop.img] placeholderImage:[UIImage imageNamed:@"loading"]];
    
    // 2.价格
    self.priceLabel.text = shop.price;
}

@end
