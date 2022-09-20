//
//  UserInfoVC.h
//  SDKDemo
//
//  Created by qingniu on 2022/6/14.
//

#import <UIKit/UIKit.h>
#import "QNUserInfo.h"


NS_ASSUME_NONNULL_BEGIN

@interface UserInfoVC : UIViewController

@end


@interface UserInfoCell : UITableViewCell

@property (nonatomic, strong) QNUserInfo *userInfo;

@end

NS_ASSUME_NONNULL_END
