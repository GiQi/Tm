//
//  RJUrlImageHandle.h
//  TestDemo-mobile
////  将网络图片保存到系统相册
//  Created by Apple on 2020/5/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RJUrlImageHandle : NSObject
//imagepath 网络图片路径
-(void)saveImage:(NSString*)imagePath;
//target 第三方名字
+(void)openThirdParty:(NSString*)target;
@end

NS_ASSUME_NONNULL_END
