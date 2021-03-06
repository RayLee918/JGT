//
//  HomeCell.m
//  WPProductOne
//
//  Created by ZeroHour on 2017/8/22.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import "HomeCell.h"

@implementation HomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        
        self.lineView = [[UIView alloc] init];
        self.lineView.frame = CGRectMake(0, 0, kScreentWidth, 5);
        self.lineView.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
        [self.contentView addSubview:self.lineView];
        
        // 头像
        self.icon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 32.5, 32.5)];
        [self.contentView addSubview:self.icon];
        self.icon.image = kImageNamed(@"default_head.png");
        self.icon.layer.cornerRadius = 32.5/2;
        self.icon.layer.masksToBounds = YES;
        
        // 昵称
        self.nickNameLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.icon.frame) + 5, CGRectGetMinY(self.icon.frame), kScreentWidth - CGRectGetMaxX(self.icon.frame) + 10, 16.5)];
        [self.contentView addSubview:self.nickNameLbl];
        self.nickNameLbl.textColor = kColor(0x1F1F1F);
        self.nickNameLbl.font = [UIFont systemFontOfSize:12];
        
        // 发布时间
        self.dateLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.nickNameLbl.frame), CGRectGetMaxY(self.icon.frame) - 12.5, self.nickNameLbl.frame.size.width, 12.5)];
        [self addSubview:self.dateLbl];
        self.dateLbl.font = [UIFont systemFontOfSize:9];
        self.dateLbl.textColor = kColor(0x9B9B9B);
        
        // 标题
        self.contentLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.icon.frame), CGRectGetMaxY(self.icon.frame) + 10, kScreentWidth - CGRectGetMinX(self.icon.frame) * 2, 18.5)];
        [self.contentView addSubview:self.contentLbl];
        self.contentLbl.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:13];
        self.contentLbl.textColor = kColor(0x1F1F1F);
        
        // 内容
        self.customView = [[UIView alloc] init];
        self.customView.frame = CGRectMake(kMargin10, CGRectGetMaxY(self.contentLbl.frame) + 10, kScreentWidth - kMargin20, 55);
        [self.contentView addSubview:self.customView];
        self.customView.backgroundColor = kColor(0xF8F3F0);
        
        // vip
        self.vipImageView = [[UIImageView alloc] init];
        self.vipImageView.frame = CGRectMake(kMargin10, (self.customView.frame.size.height - 19) / 2, 25, 19.5);
        [self.customView addSubview:self.vipImageView];
        self.vipImageView.image = [UIImage imageNamed:@"vip2.png"];
//        self.vipImageView.backgroundColor = kRedColor;
        
        //
        self.firstLabel = [[UILabel alloc] init];
        self.firstLabel.frame = CGRectMake(CGRectGetMaxX(self.vipImageView.frame) + kMargin20, kMargin10, 125, 35 / 2);
        [self.customView addSubview:self.firstLabel];
        self.firstLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12.5];
        self.firstLabel.textColor = kColor(0x252525);
        
        //
        self.secondLabel = [[UILabel alloc] init];
        self.secondLabel.frame = CGRectMake(CGRectGetMaxX(self.vipImageView.frame) + kMargin20, CGRectGetMaxY(self.firstLabel.frame), 125, 35 / 2);
        [self.customView addSubview:self.secondLabel];
        self.secondLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12.5];
        self.secondLabel.textColor = kColor(0x252525);
        
        // 立即定购
//        self.orderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        self.orderBtn.frame = CGRectMake(self.customView.frame.size.width - kMargin10 - 100, (self.customView.frame.size.height - 31) / 2, 100, 31);
//        [self.customView addSubview:self.orderBtn];
//        [self.orderBtn setBackgroundImage:[UIImage imageNamed:@"btn_background.png"] forState:UIControlStateNormal];
//        [self.orderBtn setTitle:@"立即订购" forState:UIControlStateNormal];
//        self.orderBtn.layer.cornerRadius = 15.5;
//        self.orderBtn.layer.masksToBounds = YES;
//        [CLTool gradualBackgroundColor:self.orderBtn];
        
        self.orderLabel = [UILabel new];
        self.orderLabel.frame = CGRectMake(self.customView.frame.size.width - kMargin10 - 100, (self.customView.frame.size.height - 31) / 2, 100, 31);
        [self.customView addSubview:self.orderLabel];
        self.orderLabel.textColor = kWhiteColor;
        self.orderLabel.backgroundColor = [UIColor colorWithPatternImage:kImageNamed(@"background_color.png")];
        self.orderLabel.layer.cornerRadius = 15.5;
        self.orderLabel.layer.masksToBounds = YES;
        self.orderLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
