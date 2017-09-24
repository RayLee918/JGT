//
//  FollowCell.m
//  WPProductOne
//
//  Created by ZeroHour on 2017/8/28.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import "FollowCell.h"

@implementation FollowCell

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
        self.lineView.frame = CGRectMake(0, 59, kScreentWidth, 1);
        self.lineView.backgroundColor = kLineColor;
        [self.contentView addSubview:self.lineView];
        
        // 头像
        self.icon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        [self.contentView addSubview:self.icon];
        self.icon.image = kImageNamed(@"default_head.png");
        
        // 昵称
        self.nickNameLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.icon.frame) + 15, CGRectGetMinY(self.icon.frame), kScreentWidth - 60 - 10, 40)];
        [self.contentView addSubview:self.nickNameLbl];
        self.nickNameLbl.textColor = kColor(0x3B3B3B);
        self.nickNameLbl.font = [UIFont systemFontOfSize:17];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
