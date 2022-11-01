//
//  BindDeviceVC.h
//  QNSDKDemo
//
//  Created by qushaohua on 2022/10/27.
//

#import <UIKit/UIKit.h>
#import "QNDBManager.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BindDeviceDelegate <NSObject>

@required
- (void)didClickUnbindDevice:(BindDeviceModel *)device;
- (void)didClickDeleteScaleUser:(BindDeviceModel *)device;
- (void)didClickPairWiFiDevice:(BindDeviceModel *)device;

@end

@interface BindDeviceVC : UIViewController

@end

@interface BindDeviceCell : UITableViewCell

@property (nonatomic, weak) id<BindDeviceDelegate> delegate;

@property (nonatomic, strong) BindDeviceModel *bindDevice;

@end

NS_ASSUME_NONNULL_END
