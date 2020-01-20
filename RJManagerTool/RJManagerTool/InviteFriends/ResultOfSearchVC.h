//
//  ResultOfSearchVC.h
//  Client-mobile
//
//  Created by Apple on 2019/9/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
static NSString *const kUITableViewCellIdentifier = @"cellIdentifier";

@interface ResultOfSearchVC : UITableViewController

//搜索结果数据
@property (nonatomic,strong) NSArray *results;

@end

NS_ASSUME_NONNULL_END
