//
//  TeacherCell.h
//  WPProductOne
//
//  Created by ZeroHour on 2017/8/22.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeacherCell : UITableViewCell

@property (nonatomic, strong) UIView * lineView;
@property (nonatomic, strong) UIView * lineView2;
@property (nonatomic, strong) UIImageView * icon;
@property (nonatomic, strong) UIButton * tagBtn1;
@property (nonatomic, strong) UIButton * tagBtn2;
@property (nonatomic, strong) UILabel * nickNameLbl;
@property (nonatomic, strong) UILabel * descLbl;

@property (nonatomic, strong) UIView * stateView;
@property (nonatomic, strong) UILabel * stateLabel;
@property (nonatomic, strong) UILabel * followLabel;
@property (nonatomic, strong) UILabel * dealLabel;
@property (nonatomic, strong) UILabel * downloadLabel;
@property (nonatomic, strong) UIImageView * followImageView;
@property (nonatomic, strong) UIImageView * dealImageView;
@property (nonatomic, strong) UIImageView * downloadImageView;

@end
