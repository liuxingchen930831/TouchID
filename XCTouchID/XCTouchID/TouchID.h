//
//  TouchID.h
//  XCTouchID
//
//  Created by liuxingchen on 17/4/20.
//  Copyright © 2017年 liuxingchen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LocalAuthentication/LocalAuthentication.h>
@interface TouchID : NSObject

typedef void(^touchIdValidationFailureBack)(LAError result);
+(instancetype) shardInstanceTouchid;
/**
 *  TouchId 验证
 *
 *  @param localizedReason TouchId信息
 *  @param title           验证错误按钮title
 *  @param backSuccess     成功返回Block
 *  @param backFailure     失败返回Block
 */
-(void)evaluatePolicy:(NSString *)localizedReason fallbackTitle:(NSString *)title successResult:(void(^)())backSuccess FailureResult:(touchIdValidationFailureBack)backFailure;

@end
