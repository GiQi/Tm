//
//  ViewController.m
//  testRJFramwork
//
//  Created by Apple on 2020/1/18.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "ViewController.h"
#import <RJManagerTool/RJButton.h>
#import <RJManagerTool/RJWechatManager.h>

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
    
    [self.view addSubview:loginBtn];
}

-(void)responseOnResp:(NSDictionary *)dict
{
    NSLog(@"获取用户信息");
}

@end