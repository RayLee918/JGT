//
//  CustomCell.m
//  WPProductOne
//
//  Created by ZeroHour on 2017/8/24.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    self.icon.layer.cornerRadius = 25;
//    self.icon.layer.masksToBounds = YES;
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
        self.icon = [[UIImageView alloc] initWithFrame:CGRectMake(25, 10, 50, 50)];
        [self addSubview:self.icon];
        self.icon.layer.cornerRadius = 25;
        self.icon.image = kImageNamed(@"default_head.png");
        
        
        // 昵称
        self.nickNameLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.icon.frame) + 25, CGRectGetMinY(self.icon.frame), 50, 10)];
        [self.contentView addSubview:self.nickNameLbl];
        self.nickNameLbl.textColor = kColor(0x1F1F1F);
        self.nickNameLbl.font = [UIFont systemFontOfSize:8.5];
        
        // 状态
        self.stateLabel = [UILabel new];
        self.stateLabel.frame = CGRectMake(CGRectGetMaxX(self.nickNameLbl.frame), CGRectGetMaxY(self.nickNameLbl.frame) - 10, 15, 10);
        [self.contentView addSubview:self.stateLabel];
        self.stateLabel.textColor = kColor(0xFF4F53);
        self.stateLabel.font = [UIFont systemFontOfSize:6.5];

        
        // 标签
        self.tagBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.tagBtn1.frame = CGRectMake(CGRectGetMinX(self.nickNameLbl.frame), CGRectGetMaxY(self.nickNameLbl.frame) + 7.5, 35, 10);
        [self.contentView addSubview:self.tagBtn1];
        self.tagBtn1.layer.cornerRadius = 2.32;
        self.tagBtn1.layer.borderColor = kColor(0xFF4F53).CGColor;
        self.tagBtn1.layer.borderWidth = 1;
        [self.tagBtn1 setTitleColor:kColor(0xFF4F53) forState:UIControlStateNormal];
        self.tagBtn1.titleLabel.font = [UIFont systemFontOfSize:6];
        
        self.tagBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.tagBtn2.frame = CGRectMake(CGRectGetMaxX(self.tagBtn1.frame) + 10, CGRectGetMaxY(self.nickNameLbl.frame) + 7.5, 35, 10);
        [self.contentView addSubview:self.tagBtn2];
        self.tagBtn2.layer.cornerRadius = 2.32;
        self.tagBtn2.layer.borderColor = kColor(0xFF4F53).CGColor;
        self.tagBtn2.layer.borderWidth = 1;
        [self.tagBtn2 setTitleColor:kColor(0xFF4F53) forState:UIControlStateNormal];
        self.tagBtn2.titleLabel.font = [UIFont systemFontOfSize:6];
        
        
        // 简介
        self.descLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.nickNameLbl.frame), CGRectGetMaxY(self.tagBtn1.frame) + 5,kScreentWidth - 93 - 100 - 25, 28)];
        [self addSubview:self.descLbl];
        self.descLbl.font = [UIFont systemFontOfSize:7.5];
        self.descLbl.textColor = kColor(0x4A4A4A);
        self.descLbl.numberOfLines = 0;
        
        
        // 状态
        self.lineView2 = [[UIView alloc] init];
        self.lineView2.frame = CGRectMake(0, 75, kScreentWidth, 5);
        self.lineView2.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
        [self.contentView addSubview:self.lineView2];
        
        self.stateView = [UIView new];
        self.stateView.frame = CGRectMake(0, 80, kScreentWidth, 20);
        [self.contentView addSubview:self.stateView];
        
        // 关注
        CGFloat width = (kScreentWidth - 93)/3 - 25;
        
        self.followImageView = [[UIImageView alloc] init];
        self.followImageView.frame = CGRectMake(12, (16 - 7.5)/2, 7.5, 7.5);
        [self.stateView addSubview:self.followImageView];
        self.followImageView.image = [UIImage imageNamed:@"follow.png"];
        
        self.followLabel = [[UILabel alloc] init];
        self.followLabel.frame = CGRectMake(25, 0, width, self.stateView.frame.size.height);
        [self.stateView addSubview:self.followLabel];
        self.followLabel.textColor = kColor(0x9B9B9B);
        self.followLabel.font = [UIFont systemFontOfSize:7.5];
        
        // 交易
        self.dealImageView = [[UIImageView alloc] init];
        self.dealImageView.frame = CGRectMake((kScreentWidth-93) / 3 + 12, CGRectGetMinY(self.followImageView.frame), 7.5, 7.5);
        [self.stateView addSubview:self.dealImageView];
        self.dealImageView.image = [UIImage imageNamed:@"deal.png"];
        
        self.dealLabel = [[UILabel alloc] init];
        self.dealLabel.frame = CGRectMake((kScreentWidth-93) / 3 + 25, 0, width, self.stateView.frame.size.height);
        [self.stateView addSubview:self.dealLabel];
        self.dealLabel.textColor = kColor(0x9B9B9B);
        self.dealLabel.font = [UIFont systemFontOfSize:7.5];
        
        // 下载
        self.downloadImageView = [[UIImageView alloc] init];
        self.downloadImageView.frame = CGRectMake((kScreentWidth-93) / 3 * 2 + 12, CGRectGetMinY(self.followImageView.frame), 7.5, 7.5);
        [self.stateView addSubview:self.downloadImageView];
        self.downloadImageView.image = [UIImage imageNamed:@"download.png"];
        
        self.downloadLabel = [[UILabel alloc] init];
        self.downloadLabel.frame = CGRectMake((kScreentWidth-93) / 3 * 2 + 25, 0, width, self.stateView.frame.size.height);
        [self.stateView addSubview:self.downloadLabel];
        self.downloadLabel.textColor = kColor(0x9B9B9B);
        self.downloadLabel.font = [UIFont systemFontOfSize:7.5];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
