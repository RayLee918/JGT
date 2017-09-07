//
//  RootViewController.h
//  WPProductOne
//
//  Created by ZeroHour on 2017/8/21.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UITabBarController

// 自定义标签视图
@property (nonatomic, strong) UIView * tabbarView;
@property (nonatomic, strong) NSMutableArray * tabbarBtns;

- (void)tagBtnClick:(UIButton *)sender;

@end
