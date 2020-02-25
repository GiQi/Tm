//
//  SendMessageToWXReq+requestMediaMessage.m
//  RJManagerTool
//
//  Created by Apple on 2020/2/25.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "SendMessageToWXReq+requestMediaMessage.h"

@implementation SendMessageToWXReq (requestMediaMessage)

+(SendMessageToWXReq*)SendMessageText:(NSString*_Nullable)text
                              Message:(WXMediaMessage*_Nullable)message
                                bText:(BOOL)bText
                                Scene:(enum WXScene)scene
{
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc]init];
    req.bText = bText;
    req.message = message;
    if (bText) {
        req.text = text;
    }else{
        req.message = message;
    }
    req.scene = scene;
    return req;
}

@end
