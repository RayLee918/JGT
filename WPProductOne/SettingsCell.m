//
//  SettingsCell.m
//  WPProductOne
//
//  Created by ZeroHour on 2017/8/23.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import "SettingsCell.h"

@implementation SettingsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentLabel = [UILabel new];
        self.contentLabel.frame = CGRectMake(kScreentWidth - 30 - 70, (48-20)/2, 60, 20);
        self.contentLabel.font = [UIFont systemFontOfSize:14];
        self.contentLabel.textColor = kColor(0xB0B0B0);
        [self.contentView addSubview:self.contentLabel];
        self.contentLabel.textAlignment = NSTextAlignmentRight;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
