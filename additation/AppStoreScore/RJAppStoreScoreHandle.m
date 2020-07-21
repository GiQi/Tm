//
//  RJAppStoreScoreHandle.m
//  TestDemo-mobile
//
//  Created by Apple on 2020/7/2.
//

#import "RJAppStoreScoreHandle.h"
@interface RJAppStoreScoreHandle() <SKStoreProductViewControllerDelegate>

@end

@implementation RJAppStoreScoreHandle

-(void)goToAppStore:(NSString*)appid

{
    NSString *itunesurl = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@?mt=8&&pageNumber=0&sortOrdering=2&type=Purple+Software&action=write-review",appid];

//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:itunesurl]];
    if([SKStoreReviewController respondsToSelector:@selector(requestReview)]) {
        // iOS 10.3 以后
//        [SKStoreReviewController requestReview];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:itunesurl]];
    } else {
        // iOS 10.3 之前
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:itunesurl]];
    }

}

-(void)onAppScore:(UIViewController *)vc appID:(NSString*)appid
{
    SKStoreProductViewController *storeProductVC = [[SKStoreProductViewController alloc] init];
    storeProductVC.delegate = self;
    NSDictionary *dict = [NSDictionary dictionaryWithObject:appid forKey:SKStoreProductParameterITunesItemIdentifier];
    [storeProductVC loadProductWithParameters:dict completionBlock:^(BOOL result, NSError * _Nullable error) {
        if (result) {
            [vc presentViewController:storeProductVC animated:YES completion:nil];
        }
    }];
}

#pragma mark delegate
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController
{
    [viewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
