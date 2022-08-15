//
//  UnitChooseViewController.h
//  SDKDemo
//
//  Created by qingniu on 2022/6/14.
//

#import <UIKit/UIKit.h>
#import "ScaleViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, QNUnitType) {
    QNUnitTypeWeight, // weight
    QNUnitTypeHeight, // height
};

@interface UnitChooseViewController : UITableViewController

@property (nonatomic, assign) QNUnitType unitType;

@end

NS_ASSUME_NONNULL_END
