//
//  CustomViewController.h
//  WPProductOne
//
//  Created by ZeroHour on 2017/8/21.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomViewController : UIViewController

@property (nonatomic, strong) NSMutableArray * moduleBtns;
@property (nonatomic, assign) NSInteger selectedIndex;

- (void)btnClick:(UIButton *)sender;

@end
