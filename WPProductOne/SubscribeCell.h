//
//  SubscribeCell.h
//  WPProductOne
//
//  Created by ZeroHour on 2017/8/24.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubscribeCell : UITableViewCell

@property (nonatomic, strong) UIView * lineView;
@property (nonatomic, strong) UIImageView * icon;
@property (nonatomic, strong) UILabel * nickNameLbl;
@property (nonatomic, strong) UILabel * dateLbl;
@property (nonatomic, strong) UILabel * contentLbl;
@property (nonatomic, strong) UIView * customView;

//
@property (nonatomic, strong) UIImageView * vipImageView;
@property (nonatomic, strong) UILabel * firstLabel;
@property (nonatomic, strong) UILabel * secondLabel;
@property (nonatomic, strong) UIButton * orderBtn;
@property (nonatomic, strong) UILabel * orderLabel;

@end
