//
//  ViewController.m
//  XCTouchID
//
//  Created by liuxingchen on 17/4/20.
//  Copyright © 2017年 liuxingchen. All rights reserved.
//

#import "ViewController.h"
#import "TouchID.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = ({
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height/2-30/2, self.view.frame.size.width, 30)];
        [button setTitle:@"点击进行Touch ID测试" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickTouchID) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    
    [self.view addSubview:button];
}
-(void)clickTouchID
{
    [[TouchID shardInstanceTouchid]evaluatePolicy:@"touch ID 测试title" fallbackTitle:@"输入密码" successResult:^{
        NSLog(@"验证成功");
    } FailureResult:^(LAError result) {
        switch (result) {
            case LAErrorSystemCancel:
            {
                NSLog(@"切换到其他APP");
                break;
            }
            case LAErrorUserCancel:
            {
                NSLog(@"用户取消验证Touch ID");
                
                break;
            }
            case LAErrorTouchIDNotEnrolled:
            {
                NSLog(@"TouchID is not enrolled");
                break;
            }
            case LAErrorUserFallback:
            {
                
                NSLog(@"用户选择输入密码");
                
                break;
            }
            default:
            {
                
                NSLog(@"其他情况");
                
                break;
            }
                
        }

    }];
}
@end
