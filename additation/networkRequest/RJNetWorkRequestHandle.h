//
//  RJNetWorkRequestHandle.h
//  TestDemo-mobile
//
//  Created by Apple on 2020/6/4.
//

#define UQID_KEY @"GAME_UID"
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RJNetWorkRequestHandle : NSObject
+(RJNetWorkRequestHandle*)shareInstance;
-(void)requestNetWork:(NSString*)url;

@end

NS_ASSUME_NONNULL_END
