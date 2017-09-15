//
//  CLTool.m
//  WPProductOne
//
//  Created by ZeroHour on 2017/9/12.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import "CLTool.h"

@implementation CLTool

+ (void)showAlert:(NSString *)msg target:(UIViewController *)target {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:msg preferredStyle:UIAlertControllerStyleAlert];
    [target presentViewController:alert animated:YES completion:nil];
    [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil]];
}

@end
