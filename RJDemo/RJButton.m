//
//  RJButton.m
//  AFNDemo
//
//  Created by Apple on 2019/11/12.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "RJButton.h"
@interface RJButton()

@property(nonatomic,copy)buttonBlock tempBlock;

@end
@implementation RJButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(RJButton*)buttonWithFrame:(CGRect)frame title:(NSString *)title andBlock:(buttonBlock)myBlock
{
    RJButton *button = [RJButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:button action:@selector(buttonBlockClick:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:button action:@selector(HighLightOfButton:) forControlEvents:UIControlEventTouchDown];
    button.tempBlock = myBlock;
    button.layer.cornerRadius = frame.size.width/2;
    [button setBackgroundColor:[UIColor systemGrayColor]];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    return button;
}

-(void)buttonBlockClick:(RJButton*)button
{
    [button setBackgroundColor:[UIColor systemGrayColor]];
    if (self.tempBlock) {
        self.tempBlock();
    }
}

-(void)HighLightOfButton:(RJButton*)button
{
    [button setBackgroundColor:[UIColor lightGrayColor]];
}

//-(void)ChangeButtonColor:(NSString*)value
//{
//    if ([value isEqualToString:@"default"];) {
//        [button setBackgroundColor:[UIColor systemGrayColor]];
//    }else{
//        [button setBackgroundColor:[UIColor lightGrayColor]];
//    }
//}
@end
