//
//  RJRQCodeImageHandle.h
//  JDSGZ-mobile
//
//  Created by Apple on 2020/4/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RJRQCodeImageHandle : NSObject

//返回二维码保存本地路径
+(NSString *)getPathOfRQCodeImage:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
