//
//  CLTool.h
//  WPProductOne
//
//  Created by ZeroHour on 2017/9/12.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLTool : NSObject

// 网络请求返回数据判断
+ (BOOL)isHaveData:(id)obj;

// 文字分散对齐
+ (void)labelAlightLeftAndRight:(UILabel *)label;

// 背景颜色渐变
+ (void)gradualBackgroundColor:(UIView *)targetView;
+ (void)gradualBackgroundColorLeftAndRight:(UIView *)targetView firstColor:(UIColor *)firstColor secondColor:(UIColor *)secondColor;

// 弹窗提示
+ (void)showAlert:(NSString *)msg target:(UIViewController *)target;

// 时间转换
+ (NSString *)dateConvert:(NSString *)dateadd;

@end
