//
//  DeleteScaleUserVC.h
//  QNSDKDemo
//
//  Created by qushaohua on 2022/10/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeleteScaleUserModel : NSObject

// text
@property (nonatomic, strong) NSString *text;
/// isSelected
@property (nonatomic, assign) BOOL isSelected;

@end

@interface DeleteScaleUserCell : UICollectionViewCell

@property (nonatomic, strong) DeleteScaleUserModel *model;

@end




@interface DeleteScaleUserVC : UIViewController

@property (nonatomic, strong) NSString *mac;

@end

NS_ASSUME_NONNULL_END
