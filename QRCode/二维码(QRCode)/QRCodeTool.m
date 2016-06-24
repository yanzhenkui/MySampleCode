//
//  QRCodeTool.m
//  二维码(QRCode)
//
//  Created by 闫振奎 on 16/5/20.
//  Copyright © 2016年 only. All rights reserved.
//

#import "QRCodeTool.h"
#import <CoreImage/CoreImage.h>

@implementation QRCodeTool


// 根据传入的二维码图片尺寸, 要转化为二维码的文字 创建一张二维码图片
+ (UIImage *)creatQRCodeWithString:(NSString *)str imageSize:(CGFloat)imageSize
{
    return [self creatQRCodeWithString:str imageSize:imageSize imageColorWithRed:0 andGreen:0 andBlue:0];
}


// 根据传入的二维码图片尺寸, 要转化为二维码的文字, 二维码的颜色 创建一张二维码图片
+ (UIImage *)creatQRCodeWithString:(NSString *)str imageSize:(CGFloat)imageSize imageColorWithRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue
{
    // 1.创建滤镜对象 CIQRCodeGenerator
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];

        //1.1恢复滤镜默认设置
        [filter setDefaults];
    
        //1.2获取data数据
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];

    // 2.通过KVC 设置滤镜的输入信息 inputMessage
    [filter setValue:data forKey:@"inputMessage"];

    // 3.获取滤镜输出的图像
    CIImage *image = [filter outputImage];

    // 4.将CIImage 转换成为UIImage 并展示
    UIImage *qrImage = [self createNonInterpolatedUIImageFormCIImage:image withSize:imageSize];

    return [self imageBlackToTransparent:qrImage withRed:red andGreen:green andBlue:blue];
}



/**
 *  根据CIImage, 生成一张指定大小的正方形UIImage图片
 *
 *  @param image 传入的图片
 *  @param size  指定生成的图片尺寸
 *
 *  @return 生成好的正方形UIImage图片
 */
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    
    return [UIImage imageWithCGImage:scaledImage];
}


void ProviderReleaseData (void *info, const void *data, size_t size){
    free((void*)data);
}


/**
 *  传入一张二维码图片生成一张彩色二维码图片
 *
 *  @param image 传入的图片
 *
 *  @return 返回一张彩色图片
 */
+ (UIImage*)imageBlackToTransparent:(UIImage*)image withRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue{
    const int imageWidth = image.size.width;
    const int imageHeight = image.size.height;
    size_t      bytesPerRow = imageWidth * 4;
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    // 遍历像素
    int pixelNum = imageWidth * imageHeight;
    uint32_t* pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++){
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900)    // 将白色变成透明
        {
            // 改成下面的代码，会将图片转成想要的颜色
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[3] = red; //0~255
            ptr[2] = green;
            ptr[1] = blue;
        }
        else
        {
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[0] = 0;
        }
    }
    // 输出图片
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace,
                                        kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,
                                        NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];
    // 清理空间
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return resultUIImage;
}




@end
