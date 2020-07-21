//
//  RJWechatHandle.m
//  TestDemo-mobile
//
//  Created by Apple on 2020/4/24.
//

#import "RJWechatHandle.h"

@implementation RJWechatHandle

+(RJWechatHandle*)sharedInstance
{
    static RJWechatHandle *wechatHandle =NULL;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        wechatHandle = [[RJWechatHandle alloc]init];
    });
    
    return wechatHandle;
}

+(id)copyWithZone:(struct _NSZone *)zone
{
    return [RJWechatHandle sharedInstance];
}

+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [RJWechatHandle sharedInstance];
}

-(void)openWechat{
    NSURL * url = [NSURL URLWithString:@"weixin://"];
    BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:url];
    //先判断是否能打开该url
    if (canOpen)
    {   //打开微信
        [[UIApplication sharedApplication] openURL:url options:nil completionHandler:nil];
    }else {
        NSLog(@"");
    }
}

@end
