//
//  CommentCell.m
//  WPProductOne
//
//  Created by ZeroHour on 2017/8/26.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import "CommentCell.h"

@implementation CommentCell

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
        self.icon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 25, 25)];
        [self.contentView addSubview:self.icon];
        self.icon.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon.png"]];
        
        // 昵称
        self.nickNameLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.icon.frame) + 5, CGRectGetMinY(self.icon.frame), 40, 15)];
        [self.contentView addSubview:self.nickNameLbl];
        self.nickNameLbl.textColor = kColor(0xB0B0B0);
        self.nickNameLbl.font = [UIFont systemFontOfSize:10];
        
        // 等级
        self.levelLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.nickNameLbl.frame) + 5, CGRectGetMinY(self.nickNameLbl.frame), 28, 15)];
        [self.contentView addSubview:self.levelLabel];
        self.levelLabel.textColor = kWhiteColor;
        self.levelLabel.backgroundColor = kColor(0xFF615E);
        self.levelLabel.font = [UIFont systemFontOfSize:8];

        
        // 发布时间
        self.dateLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.nickNameLbl.frame), CGRectGetMaxY(self.nickNameLbl.frame), 200, 10)];
        [self addSubview:self.dateLbl];
        self.dateLbl.font = [UIFont systemFontOfSize:9];
        self.dateLbl.textColor = kColor(0xB0B0B0);
        
        // 标题
        self.contentLbl = [[UILabel alloc] initWithFrame:CGRectMake(45, CGRectGetMaxY(self.dateLbl.frame) + 10, kScreentWidth - 45 * 2, 33)];
        [self.contentView addSubview:self.contentLbl];
        self.contentLbl.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:13];
        self.contentLbl.textColor = kColor(0x1F1F1F);
        self.contentLbl.font = [UIFont systemFontOfSize:12];
        self.contentLbl.numberOfLines = 0;
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
