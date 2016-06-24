//
//  QRCodeTool.h
//  二维码(QRCode)
//
//  Created by 闫振奎 on 16/5/20.
//  Copyright © 2016年 only. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface QRCodeTool : NSObject


/**
 *  根据传入的二维码图片尺寸, 要转化为二维码的文字,  创建一张二维码图片
 */
+ (UIImage *)creatQRCodeWithString:(NSString *)str imageSize:(CGFloat)imageSize;



/**
 *  根据传入的二维码图片尺寸, 要转化为二维码的文字, 二维码的颜色 创建一张二维码图片
 *
 *  @param str       要转化为二维码的文字
 *  @param imageSize 二维码图片的尺寸
 *  @param color     二维码的颜色
 *
 *  @return 返回一张二维码图片
 */
+ (UIImage *)creatQRCodeWithString:(NSString *)str imageSize:(CGFloat)imageSize imageColorWithRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue;

@end
