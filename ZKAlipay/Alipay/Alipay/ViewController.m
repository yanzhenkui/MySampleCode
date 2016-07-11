//
//  ViewController.m
//  Alipay
//
//  Created by 闫振奎 on 16/7/11.
//  Copyright © 2016年 TowMen. All rights reserved.
//

#import "ViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "DataSigner.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = @"2088402263917341"; // 合作商家ID
    NSString *seller = @"18588630902"; // 收款账号ID(支付宝账号)
    NSString *privateKey = @"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBAMooaWQLs7T4RTBF"
    "iTKTD1NEp5PN+plDqzhWqz3dotKXRBd4HHcIdYOGu+LolieEJpwymYastbP2omEL"
    "pMtf+mr7+O4p9jAh3dHCPcacRoeCcrn56OhiKk6bGsKTUO2/b1tyVNpRIUYZ9O3a"
    "Xu0epRM8I7NFOpHGSf6fjNTNVkmjAgMBAAECgYAev2bIQL9klx5u6SSk/JkoIRkb"
    "8ghbp18zgnspPby2KyvAJhSuRisZhjStnpK4D/GPcGLJiRtZ8/leqVa3WDHOLq8a"
    "py0qXfQ7R2LFFoQCvW5+oizLzvGqNKtj+wsyID2j87Qeui3zp0b7XaWB9yS1Sexc"
    "PowetTt+1zqDpwVWgQJBAObrrbRSZUB7fNHparPDV4Uthu4K+BIce1aGkdDxUR+l"
    "eaMkSSwKp/txDQ0nthif0r5fhBF7SgSlr5lOBuc5OYUCQQDgHQmlhBzHHx2T7Hz0"
    "Mf/gEErcuqbeS6NwZy23tfoE4TJQa60hebQsn8ChouJ2B2XrcDMH+bNhovipjJlD"
    "KQsHAkEAyg5U2yDxyd+D06U7oXn+3eB9XVMpx6c2YPq1Iq/VPSys54x7nlbgr8o3"
    "Eli6JIfMfpnTVPydQr27jhhRQAe5hQJBAK+HzsBmgyuqQT5UoWGZr7FM0XWkc4H0"
    "eCRXi8UxsIsV3pSCYW2wpt+0l+mBbCHJlZgbnryGZGr6fAw/5OJnSQ0CQQCr974t"
    "x7uDRt5mx9MhXuh1SB18ID7ibnzZOmSDRPnYTAJSRZ0YVAfNpkjsjw508MGRSsrY"
    "UwLmuDHefePlKChH"; // 私钥(注意: pkcs8格式)
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.sellerID = seller;
    order.outTradeNO = @"123456"; //订单ID（由商家自行制定）
    order.subject = @"下期双色球彩票中奖号码"; //商品标题
    order.body = @"此订单永久有效"; //商品描述
    order.totalFee = @"100"; //商品价格
    order.notifyURL =  @"http://www.baidu.com"; //回调URL 用于异步通知服务器支付结果的
    
    // 固定写法
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1"; // 默认类型，商品购买
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m"; // 订单过期时间
    order.showURL = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"alisdkcustomdemo";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic); // 为了适配Auth2.0授权
        }];
    }
    
}

@end
