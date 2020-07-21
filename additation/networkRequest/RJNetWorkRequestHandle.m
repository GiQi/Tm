//
//  RJNetWorkRequestHandle.m
//  TestDemo-mobile
//
//  Created by Apple on 2020/6/4.
//

#define UQID_KEY @"GAME_UID"
#import "RJNetWorkRequestHandle.h"
@interface RJNetWorkRequestHandle()
@property(nonatomic,strong)NSString *isSend;
@end
static RJNetWorkRequestHandle *_instance= NULL;
@implementation RJNetWorkRequestHandle
+(RJNetWorkRequestHandle*)shareInstance
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc]init];
    });
    return _instance;
}
-(void)requestNetWork:(NSString*)url
{
    NSURL *requestUrl = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:requestUrl];
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    if (timer) {
        dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 3.0 * NSEC_PER_SEC, 1.0 * NSEC_PER_SEC);
       
            dispatch_source_set_event_handler(timer, ^{
                 if ([self.isSend isEqualToString:@"true"]) {
                [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {

                    if (response) {
                        self.isSend = @"false";
                        NSLog(@"网络响应：response：%@",response);
                    }

                    if(connectionError)
                    {
                        self.isSend = @"true";
                        NSLog(@"网络error：connectionError：%@",connectionError);
                    }
                }];
                }else{
                    [self destoryTimer:timer];
                }
            });
            dispatch_resume(timer);
            }
}

- (void)destoryTimer:(dispatch_source_t)timer{
    dispatch_source_cancel(timer);
    timer = nil;
}

+(id)copyWithZone:(struct _NSZone *)zone
{
    if (!_instance) {
        _instance=[RJNetWorkRequestHandle shareInstance];
    }
    return _instance;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    if (!_instance) {
        _instance=[super allocWithZone:zone];
    }
    return _instance;
}
- (NSString *)isSend
{
    if (!_isSend) {
        _isSend = @"true";
    }
    return _isSend;
}

@end
