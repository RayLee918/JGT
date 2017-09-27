//
//  CLTool.m
//  WPProductOne
//
//  Created by ZeroHour on 2017/9/12.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import "CLTool.h"

@implementation CLTool

#pragma mark - 网络请求返回数据判断
+ (BOOL)isHaveData:(id)obj {
    
    if ([[obj objectForKey:kStatus] integerValue] == 1) {
        
        id value = [obj objectForKey:kData];
        
        if ([value respondsToSelector:@selector(count)]) {
            NSDictionary * dic = value;
            if (dic.count > 0) {
                return YES;
            } else {
                return NO;
            }
        } else if ([value respondsToSelector:@selector(isEqualToString:)]) {
            NSString * str = value;
            if (![str isEqualToString:@""]) {
                return YES;
            } else {
                return NO;
            }
        } else {
            return NO;
        }
    } else {
        return NO;
    }
}

#pragma mark - 文字分散对齐
+ (void)labelAlightLeftAndRight:(UILabel *)label
{
    [self labelAlightLeftAndRightWithWidth:label];
}

+ (void)labelAlightLeftAndRightWithWidth:(UILabel *)label
{
    //自适应高度
    CGSize textSize = [label.text boundingRectWithSize:CGSizeMake(label.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine| NSStringDrawingUsesFontLeading  attributes:@{NSFontAttributeName :label.font} context:nil].size;
    CGFloat margin = (label.frame.size.width - textSize.width)/(label.text.length - 1);
    NSNumber *number = [NSNumber numberWithFloat:margin];
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:label.text];
    
    //字间距 :NSKernAttributeName
    [attribute addAttribute:NSKernAttributeName value:number range:NSMakeRange(0, label.text.length - 1)];
    label.attributedText = attribute;
}

#pragma makr - 颜色渐变
+ (void)gradualBackgroundColor:(UIView *)targetView {
    
    //初始化CAGradientlayer对象，使它的大小为UIView的大小
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = targetView.bounds;
    
    //将CAGradientlayer对象添加在我们要设置背景色的视图的layer层
    [targetView.layer insertSublayer:gradientLayer atIndex:0];
    
    //设置渐变区域的起始和终止位置（范围为0-1）
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    
    //设置颜色数组
    gradientLayer.colors = @[(__bridge id)kColor(0xD00014).CGColor,
                             (__bridge id)kColor(0x900500).CGColor];
    
    //设置颜色分割点（范围：0-1）
    gradientLayer.locations = @[@(0.0f), @(1.0f)];
}

+ (void)gradualBackgroundColorLeftAndRight:(UIView *)targetView firstColor:(UIColor *)firstColor secondColor:(UIColor *)secondColor {
    
    //初始化CAGradientlayer对象，使它的大小为UIView的大小
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = targetView.bounds;
    
    //将CAGradientlayer对象添加在我们要设置背景色的视图的layer层
    [targetView.layer insertSublayer:gradientLayer atIndex:0];
    
    //设置渐变区域的起始和终止位置（范围为0-1）
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    
    //设置颜色数组
    gradientLayer.colors = @[(__bridge id)firstColor.CGColor,
                             (__bridge id)secondColor.CGColor];
    
    //设置颜色分割点（范围：0-1）
    gradientLayer.locations = @[@(0.0f), @(1.0f)];
}


#pragma mark - 弹窗提示
+ (void)showAlert:(NSString *)msg target:(UIViewController *)target {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:msg preferredStyle:UIAlertControllerStyleAlert];
    [target presentViewController:alert animated:YES completion:nil];
    [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil]];
}

#pragma mark - 时间转换
+ (NSString *)dateConvert:(NSString *)dateadd
{
    NSDate * date = [NSDate date];
    int timeInterval = [date timeIntervalSince1970];
    int dateAdd = [dateadd intValue];
    int differ = timeInterval - dateAdd;
    NSString * dateString = nil;
    
    if (differ > 0 && differ < 60)
    {
        dateString = @"刚刚";
    }
    else if (differ >= 60 && differ < 3600)
    {
        dateString = [NSString stringWithFormat:@"%d分钟前", differ/60];
    }
    else if (differ >= 3600 && differ < 3600*24)
    {
        dateString = [NSString stringWithFormat:@"%d小时前", differ/3600];
    }
    else if(differ >= 3600*24 && differ < 3600*48)
    {
        dateString = @"昨天";
    }
    else
    {
        NSDate * date = [NSDate dateWithTimeIntervalSince1970:[dateadd doubleValue]];
        NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        dateString = [formatter stringFromDate:date];
    }
    return dateString;
}

@end
