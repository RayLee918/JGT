//
//  CLTool.h
//  WPProductOne
//
//  Created by ZeroHour on 2017/9/12.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLTool : NSObject

// 返回的是否有数据
+ (BOOL)isHaveData:(id)obj;

// 文字分散对齐
+ (void)labelAlightLeftAndRight:(UILabel *)label;

// 背景颜色渐变
+ (void)gradualBackgroundColor:(UIView *)targetView;

// 弹窗提示
+ (void)showAlert:(NSString *)msg target:(UIViewController *)target;

// 时间转换
+ (NSString *)dateConvert:(NSString *)dateadd;

@end
