//
//  RJWechatSDK.m
//  WeChat1-mobile
//
//  Created by Apple on 2019/12/26.
//

#import "RJWechatManager.h"

@implementation RJWechatManager

#pragma mark - LifeCycle
+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static RJWechatManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[RJWechatManager alloc] init];
    });
    return instance;
}

+(void)sendAuthRequest:(completionBlock)block viewController:(UIViewController*)controller delegate:(id)delegate
{
    if ([WXApi isWXAppInstalled]) {
        SendAuthReq* req    =[[SendAuthReq alloc]init];
        req.scope = kAuthScope;
        req.state = kAuthState;
        req.openID = kAuthOpenID;
        //第三方向微信终端发送一个SendAuthReq消息结构
        [WXApi sendAuthReq:req viewController:controller delegate:[RJWechatManager sharedManager] completion:^(BOOL success) {
            if (block) {
                block(success);
            }
        }];

    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"未安装微信" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://apps.apple.com/cn/app/%E5%BE%AE%E4%BF%A1/id414478124"]];
            
        }];
        [alert addAction:action];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window.rootViewController presentViewController:alert animated:YES completion:nil];
        
    }
}

+(void)registerAppID:(NSString*)appId universalLink:(NSString*)link
{
        [WXApi registerApp:appId universalLink:link];
}

-(void)onReq:(BaseReq *)req
{
    [_delegate responseOnReq:req];
}

-(void)onResp:(BaseResp *)resp
{
    switch (resp.errCode) {
        case WXSuccess:
        {
            // 返回成功，获取Code
            SendAuthResp *sendResp = (SendAuthResp*)resp;
            NSString *code = sendResp.code;
            NSLog(@"code=%@",sendResp.code);
            // 根据Code获取AccessToken(有限期2个小时）
            // 发起GET请求
            // 2.1.设置请求路径
            NSString *urlStr = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",APP_ID,AppSecret,code];
            
            // 转码
            urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            // URL里面不能包含中文
            NSURL *url = [NSURL URLWithString:urlStr];
            
            // 2.2.创建请求对象
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url]; // 默认就是GET请求
            request.timeoutInterval = 5; // 设置请求超时
            
            // 2.3.发送请求
            [self sendAsync:request];
            
            NSLog(@"---------已经发出请求");
            [self showMessage:@"微信授权成功!" andBlock:^{
                
            }];
        }
            break;
            
        default:
        {
            [self showMessage:@"微信授权失败!" andBlock:^{
                
            }];
        }
            break;
    }
}
// 发送异步：GET请求
- (void)sendAsync:(NSURLRequest *)request
{
    NSOperationQueue *queue = [NSOperationQueue mainQueue];
//    [NSURLSession dataTaskWithRequest:completionHandler:]
//    [NSURLSession]
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data) { // 请求成功
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            NSString *error = dict[@"errcode"];
            if (error) { // 登录失败
                NSLog(@"请求失败!");
            } else {     // 登录成功
                NSString *access_token  =  dict[@"access_token"]; // 接口调用凭证(有效期2h)
                NSString *openid        =  dict[@"openid"];       // 授权用户唯一标识
                
                NSLog(@"openid=%@"      ,openid);
                NSLog(@"access_token=%@",access_token);
                if (_delegate && [_delegate respondsToSelector:@selector(ResponseOnResp:)]) {
                    [_delegate responseOnResp:dict];
                    NSLog(@"请求成功!");
                }
                NSLog(@"请求成功!");
            }
        } else { // 请求失败
            NSLog(@"网络繁忙, 请稍后再试");
        }
    }];
}

-(void)showMessage:(NSString*)message andBlock:(void(^ __nullable)(void))templateBlock
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (templateBlock) {
            templateBlock();
        }
        //                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://apps.apple.com/cn/app/%E5%BE%AE%E4%BF%A1/id414478124"]];
        
    }];
    [alert addAction:action];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window.rootViewController presentViewController:alert animated:YES completion:nil];
    
}



@end
