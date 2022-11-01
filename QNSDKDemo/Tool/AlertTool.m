//
//  AlertTool.m
//  QNSDKDemo
//
//  Created by qingniu on 2022/10/27.
//

#import "AlertTool.h"
#import <UIKit/UIKit.h>

@implementation AlertTool

+ (void)showAlertMsg:(NSString *)msg {
    [self showAlertMsg:msg cancelHandle:nil sureHandle:nil];
}

+ (void)showAlertMsg:(NSString *)msg cancelHandle:(AlertBlock)cancelBlock sureHandle:(AlertBlock)sureBlock {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Tips" message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (cancelBlock) cancelBlock();
    }];
    [alert addAction:cancelAction];

    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (sureBlock) sureBlock();
    }];
    [alert addAction:okAction];
    
    UIView *window = [UIApplication sharedApplication].keyWindow;
    
    if ([alert respondsToSelector:@selector(popoverPresentationController)]) {
        alert.popoverPresentationController.sourceView = window;
        alert.popoverPresentationController.sourceRect = CGRectMake(window.bounds.size.width*0.5, window.bounds.size.height, 1.0, 1.0);
    }
    [[self currentVc] presentViewController:alert animated:true completion:nil];
}


+ (UIViewController *)currentVc {
    UIViewController *rootVc = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVc  = [self getCurrentVCFrom:rootVc];
    return (UIViewController *)currentVc;
}

+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC {
    UIViewController *currentVC;
    if ([rootVC presentedViewController]) {
        rootVC = [rootVC presentedViewController];
    }
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    } else {
        currentVC = rootVC;
    }
    return currentVC;
}

@end
