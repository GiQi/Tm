//
//  ViewController.m
//  testRJFramwork
//
//  Created by Apple on 2020/1/18.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "ViewController.h"
#import <RJManagerTool/RJWechatManager.h>
#import <RJManagerTool/RJButton.h>

@interface ViewController ()<RJWechatDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [RJWechatManager sharedManager].delegate=self;
    // Do any additional setup after loading the view.
    RJButton *loginBtn = [RJButton buttonWithFrame:CGRectMake(150, 150, 150, 150) title:@"" andBlock:^{
        [RJWechatManager sendAuthRequest:nil viewController:self delegate:[RJWechatManager sharedManager]];
    }];
    RJButton *shareBtn = [RJButton buttonWithFrame:CGRectMake(150, 250, 150, 150) title:@"分享" andBlock:^{
        [RJWechatManager sendAppContentTitle:@"这是测试标题" extInfo:@"11" Url:@"https://giqi.github.io/" Description:@"这是测试内容" Scene:WXSceneSession];
    }];
    
    [self.view addSubview:loginBtn];

    [self.view addSubview:shareBtn];
    
}

-(void)responseOnResp:(NSDictionary *)dict
{
    NSLog(@"获取用户信息");
}
//-(void)responseOnReq:(BaseReq *)req
//{
//    NSLog(@"获取用户信息");
//}


@end
