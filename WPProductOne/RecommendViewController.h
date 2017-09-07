//
//  RecommendViewController.h
//  WPProductOne
//
//  Created by ZeroHour on 2017/8/21.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
#import "CustomViewController.h"

@interface RecommendViewController : UIViewController

// 列表展示
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UITableView * teacherTableView;
@property (nonatomic, weak) RootViewController * rootVC;
@property (nonatomic, weak) CustomViewController * customVC;


@end
