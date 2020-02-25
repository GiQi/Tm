//
//  WXMediaMessage+MessageConstruct.h
//  RJManagerTool
//
//  Created by Apple on 2020/2/25.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "WXApiObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface WXMediaMessage (MessageConstruct)

+(WXMediaMessage*)sendAppContentData:(NSData * _Nullable)data
                               Title:(NSString *)title
                             extInfo:(NSString *)extInfo
                                 Url:(NSString *)url
                         Description:(NSString *)description
                               Scene:(enum WXScene)scene;

@end

NS_ASSUME_NONNULL_END
