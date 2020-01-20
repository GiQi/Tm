//
//  RJButton.h
//  AFNDemo
//
//  Created by Apple on 2019/11/12.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^buttonBlock)();

@interface RJButton : UIButton

+(RJButton*)buttonWithFrame:(CGRect)frame title:(NSString*)title andBlock:(buttonBlock)myBlock;

@end

NS_ASSUME_NONNULL_END
