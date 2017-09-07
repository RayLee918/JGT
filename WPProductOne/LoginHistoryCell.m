//
//  LoginHistoryCell.m
//  WPProductOne
//
//  Created by ZeroHour on 2017/8/23.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import "LoginHistoryCell.h"

@implementation LoginHistoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.firstLabel = [UILabel new];
        self.firstLabel.frame = CGRectMake(20, 13, kScreentWidth - 20 - 60, 21);
        self.firstLabel.font = [UIFont systemFontOfSize:15];
        self.firstLabel.textColor = kColor(0x1F1F1F);
        [self.contentView addSubview:self.firstLabel];
        
        self.secondLabel = [UILabel new];
        self.secondLabel.frame = CGRectMake(20, CGRectGetMaxY(self.firstLabel.frame) + 5, self.firstLabel.frame.size.width, 20);
        self.secondLabel.font = [UIFont systemFontOfSize:9];
        self.secondLabel.textColor = kColor(0xB0B0B0);
        [self.contentView addSubview:self.secondLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
