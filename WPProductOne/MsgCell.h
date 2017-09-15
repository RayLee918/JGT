//
//  MsgCell.h
//  WPProductOne
//
//  Created by ZeroHour on 2017/9/14.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MsgCell : UITableViewCell

@property (nonatomic, strong) UILabel * datetimeLabel;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * descLabel;
@property (nonatomic, strong) UIView * backgroundView;

@end
