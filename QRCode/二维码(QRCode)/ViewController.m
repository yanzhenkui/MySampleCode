//
//  ViewController.m
//  二维码(QRCode)
//
//  Created by 闫振奎 on 16/5/20.
//  Copyright © 2016年 only. All rights reserved.
//

#import "ViewController.h"
#import "QRCodeTool.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet UIImageView *QRCodeImageView;

@end

@implementation ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    
    UIImage *image = [QRCodeTool creatQRCodeWithString:self.textView.text imageSize:self.QRCodeImageView.bounds.size.width * 2 imageColorWithRed:22 andGreen:26 andBlue:66];
    
    self.QRCodeImageView.image = image;
    
}



@end
