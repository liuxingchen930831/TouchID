//
//  TouchID.m
//  XCTouchID
//
//  Created by liuxingchen on 17/4/20.
//  Copyright © 2017年 liuxingchen. All rights reserved.
//

#import "TouchID.h"
#import <UIKit/UIKit.h>
#define  iOS8 ([UIDevice currentDevice].systemVersion.doubleValue >= 8.0)
@implementation TouchID
+(instancetype)shardInstanceTouchid
{
    static TouchID * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[TouchID alloc]init];
    });
    return instance;
}
-(void)evaluatePolicy:(NSString *)localizedReason fallbackTitle:(NSString *)title successResult:(void (^)())backSuccess FailureResult:(touchIdValidationFailureBack)backFailure
{
    //初始化上下文对象
    LAContext *context = [[LAContext alloc]init];
    NSError *error = nil;
    //TouchID 必须支持iOS8 以上的系统
    if (iOS8) {
        //判断设备支持状态 最低iPhone5s
        if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
            //支持指纹验证
            [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:localizedReason reply:^(BOOL success, NSError * _Nullable error) {
                if (success) {
                    NSLog(@"验证成功");
                    dispatch_async(dispatch_get_main_queue(), ^{
                        backSuccess(success);
                    });
                }else{
                    NSLog(@"验证失败,错误信息为 %@",error.localizedDescription);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        backFailure(error.code);
                    });
                }
            }];
        }
    }else{
        NSLog(@"不支持指纹识别，LOG出错误详情");
        NSLog(@"%@",error.localizedDescription);
        dispatch_async(dispatch_get_main_queue(), ^{
            backFailure(error.code);
        });
    }
}
@end
