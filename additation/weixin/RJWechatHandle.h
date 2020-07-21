//
//  RJWechatHandle.h
//  TestDemo-mobile
//
//  Created by Apple on 2020/4/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RJWechatHandle : NSObject

+(instancetype)sharedInstance;
-(void)openWechat;

@end

NS_ASSUME_NONNULL_END
