//
//  RJWechatSDK.h
//  WeChat1-mobile
//
//  Created by Apple on 2019/12/26.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
#import "WXApiObject.h"

NS_ASSUME_NONNULL_BEGIN
#define kAuthScope @"snsapi_userinfo"
#define kAuthState @"123"
#define kAuthOpenID @"sxsxsxsx"
#define AppSecret @"96f49034bdb1db00c3e577188d806005"
#define APP_ID @"wx9ecf48468f517cbc"

typedef void (^completionBlock)(BOOL success);
typedef void (^respBlock)(BaseResp* resp);
@protocol RJWechatDelegate <NSObject>
@optional
/*！@brief
*@param 登录回调
 */
-(void)responseOnReq:(NSDictionary *)dict;
-(void)responseOnResp:(NSDictionary *)dict;
-(void)responseError:(NSError*)error;

@end

@interface RJWechatManager : NSObject<WXApiDelegate>

@property (nonatomic, assign) id<RJWechatDelegate> delegate;
@property(nonatomic,strong)completionBlock tempBlock;
@property(nonatomic,strong)completionBlock respBlock;
@property(nonatomic,strong)completionBlock reqBlock;

+(instancetype)sharedManager;

/*! @brief 发送Auth请求到微信，支持用户没安装微信，等待微信返回onResp
*
* 函数调用后，会切换到微信的界面。第三方应用程序等待微信返回onResp。微信在异步处理完成后一定会调用onResp。支持SendAuthReq类型。
* @param controller 当前界面对象。
* @param delegate  RJWechatManager对象，用来接收微信触发的消息。
* @param block 调用结果回调block
*/
+(void)sendAuthRequest:(nullable completionBlock)block viewController:(UIViewController*)controller delegate:(id)delegate;
+(void)registerAppID:(NSString*)appId universalLink:(NSString*)link;

@end
NS_ASSUME_NONNULL_END

