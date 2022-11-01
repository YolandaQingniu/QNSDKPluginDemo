//
//  QNWiFiInfo.h
//  QNScalePlugin
//
//  Created by sumeng on 2022/6/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QNWiFiInfo : NSObject
/// WiFi name
@property (nonatomic, strong) NSString *ssid;
/// password
@property (nonatomic, strong) NSString *pwd;
/// server address
@property (nonatomic, strong) NSString *serverUrl;
@end

NS_ASSUME_NONNULL_END
