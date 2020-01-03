//
//  RJWechatSDK.h
//  WeChat1-mobile
//
//  Created by Apple on 2019/12/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
#define kAuthScope @"snsapi_userinfo"
#define kAuthState @"123"
#define kAuthOpenID @"sxsxsxsx"
#define AppSecret @"96f49034bdb1db00c3e577188d806005"
#define APP_ID @"wx9ecf48468f517cbc"
NS_ASSUME_NONNULL_END

#import "WXApi.h"
#import "WXApiObject.h"

typedef void (^completionBlock)(BOOL success);
typedef void (^respBlock)(BaseResp* resp);
@protocol RJWecatDelegate <NSObject>
@optional

-(void)ResponseError:(NSError*)error;
-(void)ResponseOnResp:(NSDictionary *)dict;

@end

@interface RJWechatManager : NSObject<WXApiDelegate>

@property (nonatomic, assign) id<RJWecatDelegate> delegate;

+(instancetype)sharedManager;
+(void)sendAuthRequest:(completionBlock)block viewController:(UIViewController*)controller delegate:(id)delegate;

@end


