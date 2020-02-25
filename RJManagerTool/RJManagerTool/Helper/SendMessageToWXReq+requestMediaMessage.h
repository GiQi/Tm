//
//  SendMessageToWXReq+requestMediaMessage.h
//  RJManagerTool
//
//  Created by Apple on 2020/2/25.
//  Copyright © 2020 Apple. All rights reserved.
//
#import "WXApiObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface SendMessageToWXReq (requestMediaMessage)

+(SendMessageToWXReq*)SendMessageText:(NSString * _Nullable)text
                              Message:(WXMediaMessage * _Nullable)message
                                bText:(BOOL)bText
                                Scene:(enum WXScene)scene;

@end

NS_ASSUME_NONNULL_END
