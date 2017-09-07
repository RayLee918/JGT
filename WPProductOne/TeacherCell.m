//
//  TeacherCell.m
//  WPProductOne
//
//  Created by ZeroHour on 2017/8/22.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import "TeacherCell.h"

@implementation TeacherCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.lineView = [[UIView alloc] init];
        self.lineView.frame = CGRectMake(0, 0, kScreentWidth, 5);
        self.lineView.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
        [self.contentView addSubview:self.lineView];
        
        // 头像
        self.icon = [[UIImageView alloc] initWithFrame:CGRectMake(24, (102 - 75) / 2, 75, 75)];
        [self addSubview:self.icon];
//        self.icon.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mask.png"]];
        self.icon.image = [UIImage imageNamed:@"mask.png"];
        
        // 昵称
        self.nickNameLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.icon.frame) + 24, CGRectGetMinY(self.icon.frame), kScreentWidth - CGRectGetMaxX(self.icon.frame) - 24, 15)];
        [self.contentView addSubview:self.nickNameLbl];
        self.nickNameLbl.textColor = kColor(0x1F1F1F);
        self.nickNameLbl.font = [UIFont systemFontOfSize:13];
        
        // 标签
        self.tagBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.tagBtn1.frame = CGRectMake(CGRectGetMinX(self.nickNameLbl.frame), CGRectGetMaxY(self.nickNameLbl.frame)+5, 50, 15);
        [self.contentView addSubview:self.tagBtn1];
        self.tagBtn1.layer.cornerRadius = 3.48;
        self.tagBtn1.layer.borderColor = kColor(0x4990E2).CGColor;
        self.tagBtn1.layer.borderWidth = 1;
        [self.tagBtn1 setTitleColor:kColor(0x4990E2) forState:UIControlStateNormal];
        self.tagBtn1.titleLabel.font = [UIFont systemFontOfSize:8.7];
        
        self.tagBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.tagBtn2.frame = CGRectMake(CGRectGetMaxX(self.tagBtn1.frame) + 20, CGRectGetMaxY(self.nickNameLbl.frame)+5, 50, 15);
        [self.contentView addSubview:self.tagBtn2];
        self.tagBtn2.layer.cornerRadius = 3.48;
        self.tagBtn2.layer.borderColor = kColor(0x4990E2).CGColor;
        self.tagBtn2.layer.borderWidth = 1;
        [self.tagBtn2 setTitleColor:kColor(0x4990E2) forState:UIControlStateNormal];
        self.tagBtn2.titleLabel.font = [UIFont systemFontOfSize:8.7];

        
        // 简介
        self.descLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.nickNameLbl.frame), CGRectGetMaxY(self.icon.frame) - 28, self.nickNameLbl.frame.size.width - 24, 28)];
        [self addSubview:self.descLbl];
        self.descLbl.font = [UIFont systemFontOfSize:10];
        self.descLbl.textColor = kColor(0x4A4A4A);
        self.descLbl.numberOfLines = 0;
        
        self.stateView = [UIView new];
        self.stateView.frame = CGRectMake(0, 112, kScreentWidth, 25);
        [self.contentView addSubview:self.stateView];
        
    
        // 状态
        self.lineView2 = [[UIView alloc] init];
        self.lineView2.frame = CGRectMake(0, 107, kScreentWidth, 5);
        self.lineView2.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
        [self.contentView addSubview:self.lineView2];
        
        self.stateLabel = [UILabel new];
        self.stateLabel.frame = CGRectMake(kScreentWidth - 12 - 22, 5, 22, 15);
        [self.stateView addSubview:self.stateLabel];
        self.stateLabel.textColor = kColor(0x4990E2);
        self.stateLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:11];
        
        // 关注
        CGFloat width = (kScreentWidth-12-22-22)/3-12-10-5;
        
        self.followImageView = [[UIImageView alloc] init];
        self.followImageView.frame = CGRectMake(12, (25-10)/2, 10, 11);
        [self.stateView addSubview:self.followImageView];
        self.followImageView.image = [UIImage imageNamed:@"follow.png"];
        
        self.followLabel = [[UILabel alloc] init];
        self.followLabel.frame = CGRectMake(CGRectGetMaxX(self.followImageView.frame) + 5, 0, width, 25);
        [self.stateView addSubview:self.followLabel];
        self.followLabel.textColor = kColor(0x9B9B9B);
        self.followLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:11];
        
        // 交易
        self.dealImageView = [[UIImageView alloc] init];
        self.dealImageView.frame = CGRectMake(CGRectGetMaxX(self.followLabel.frame) + 12, (25-10)/2, 10, 11);
        [self.stateView addSubview:self.dealImageView];
        self.dealImageView.image = [UIImage imageNamed:@"deal.png"];
        
        self.dealLabel = [[UILabel alloc] init];
        self.dealLabel.frame = CGRectMake(CGRectGetMaxX(self.dealImageView.frame) + 5, 0, width, 25);
        [self.stateView addSubview:self.dealLabel];
        self.dealLabel.textColor = kColor(0x9B9B9B);
        self.dealLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:11];
        
        // 下载
        self.downloadImageView = [[UIImageView alloc] init];
        self.downloadImageView.frame = CGRectMake(CGRectGetMaxX(self.dealLabel.frame) + 12, (25-10)/2, 10, 11);
        [self.stateView addSubview:self.downloadImageView];
        self.downloadImageView.image = [UIImage imageNamed:@"download.png"];
        
        self.downloadLabel = [[UILabel alloc] init];
        self.downloadLabel.frame = CGRectMake(CGRectGetMaxX(self.downloadImageView.frame) + 5, 0, width, 25);
        [self.stateView addSubview:self.downloadLabel];
        self.downloadLabel.textColor = kColor(0x9B9B9B);
//        self.downloadLabel.font = [UIFont fontWithName:@".PingFang-SC-Regular" size:11];
        self.downloadLabel.font = [UIFont systemFontOfSize:11];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
