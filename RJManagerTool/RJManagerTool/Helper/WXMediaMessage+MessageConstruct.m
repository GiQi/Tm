//
//  WXMediaMessage+MessageConstruct.m
//  RJManagerTool
//
//  Created by Apple on 2020/2/25.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "WXMediaMessage+MessageConstruct.h"

@implementation WXMediaMessage (MessageConstruct)
+(WXMediaMessage*)sendAppContentData:(NSData * _Nullable)data
                               Title:(NSString *)title
                             extInfo:(NSString *)extInfo
                                 Url:(NSString *)url
                         Description:(NSString *)description
                               Scene:(enum WXScene)scene
{
    WXAppExtendObject *ext = [WXAppExtendObject object];
    ext.extInfo = extInfo;
    ext.url = url;
    if (data) {
        ext.fileData = data; //指定下载数据
    }
    
    WXMediaMessage *message = [WXMediaMessage message];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Icon"
                                                         ofType:@"png"];
    message.thumbData = [NSData dataWithContentsOfFile:filePath];
    message.mediaObject = ext;
    message.title = title;
    message.description = description;
    return message;
}
@end
