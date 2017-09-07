//
//  BillCell.h
//  WPProductOne
//
//  Created by ZeroHour on 2017/8/23.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BillCell : UITableViewCell

@property (nonatomic, strong) UILabel * dateLabel;
@property (nonatomic, strong) UILabel * timeLabel;
@property (nonatomic, strong) UIImageView * cardImageView;
@property (nonatomic, strong) UILabel * moneyLabel;
@property (nonatomic, strong) UILabel * descLabel;

@end
