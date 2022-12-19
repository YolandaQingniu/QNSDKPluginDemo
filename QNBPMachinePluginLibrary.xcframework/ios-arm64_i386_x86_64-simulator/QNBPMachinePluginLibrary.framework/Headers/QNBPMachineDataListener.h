//
//  QNBPMachineDataListener.h
//  QNBPMachinePluginLibrary
//
//  Created by sumeng on 2022/12/12.
//

#import <Foundation/Foundation.h>
#import <QNBPMachinePluginLibrary/QNBPMachineData.h>
#import <QNBPMachinePluginLibrary/QNBPMachineDevice.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(int, QNBPMachineMeasureResult) {
    QNBPMachineMeasureResultUndone = 0,  // Measurement not completed
    QNBPMachineMeasureResultErr1,        // Device not calibrated
    QNBPMachineMeasureResultErr2,        // Cuff comes off or Excessive movement
    QNBPMachineMeasureResultErr3,        // High voltage detection failed
    QNBPMachineMeasureResultErr4,        // Low voltage detection failed
    QNBPMachineMeasureResultErr5,        // Blood pressure pulses not detected
    QNBPMachineMeasureResultErr6,        // Measurement timeout
    QNBPMachineMeasureResultErr7,        // Over pressurization
    QNBPMachineMeasureResultErr8,        // Air leaks during pressurization
    QNBPMachineMeasureResultErr9,        // Missing cuff
    QNBPMachineMeasureResultSuccess,     // Measurement success
};

@protocol QNBPMachineDataListener <NSObject>

/// Receive real time data
/// @param measureResult QNBPMachineMeasureResult
/// @param data QNBPMachineData
/// @param device QNBPMachineDevice
- (void)onBPMachineReceiveRealTimeData:(QNBPMachineMeasureResult)measureResult data:(nullable QNBPMachineData *)data device:(QNBPMachineDevice *)device;

/// Receive stored data
/// @param data QNBPMachineData
/// @param device QNBPMachineDevice
- (void)onBPMachineReceiveStoredData:(QNBPMachineData *)data device:(QNBPMachineDevice *)device;
@end

NS_ASSUME_NONNULL_END
