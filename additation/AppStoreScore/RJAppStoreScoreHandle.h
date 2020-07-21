//
//  RJAppStoreScoreHandle.h
//  TestDemo-mobile
//
//  Created by Apple on 2020/7/2.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RJAppStoreScoreHandle : NSObject
- (void)goToAppStore:(NSString*)appid;
- (void)onAppScore:(UIViewController *)vc appID:(NSString*)appid;
@end

NS_ASSUME_NONNULL_END
