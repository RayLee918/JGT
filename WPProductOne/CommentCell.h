//
//  CommentCell.h
//  WPProductOne
//
//  Created by ZeroHour on 2017/8/26.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentCell : UITableViewCell

@property (nonatomic, strong) UIView * lineView;
@property (nonatomic, strong) UIImageView * icon;
@property (nonatomic, strong) UILabel * nickNameLbl;
@property (nonatomic, strong) UILabel * dateLbl;
@property (nonatomic, strong) UILabel * contentLbl;
@property (nonatomic, strong) UILabel * levelLabel;

@end
