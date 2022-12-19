//
//  QNBPMachineWiFi.h
//  QNBPMachinePluginLibrary
//
//  Created by sumeng on 2022/12/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QNBPMachineWiFi : NSObject
/// WiFi name
@property (nonatomic, strong) NSString *ssid;
/// WiFi password
@property (nonatomic, strong) NSString *pwd;
/// Server url
@property (nonatomic, strong) NSString *serverUrl;

@end

NS_ASSUME_NONNULL_END
