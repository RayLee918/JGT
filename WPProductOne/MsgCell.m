//
//  MsgCell.m
//  WPProductOne
//
//  Created by ZeroHour on 2017/9/14.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import "MsgCell.h"

@implementation MsgCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.datetimeLabel = [UILabel new];
        self.datetimeLabel.frame = CGRectMake((kScreentWidth - 150) / 2, 0, 150, 20);
        [self.contentView addSubview:self.datetimeLabel];
        self.datetimeLabel.font = [UIFont systemFontOfSize:13];
        self.datetimeLabel.textAlignment = NSTextAlignmentCenter;
        self.datetimeLabel.layer.cornerRadius = 10;
        self.datetimeLabel.layer.masksToBounds = YES;
        self.datetimeLabel.backgroundColor = [UIColor colorWithRed:206/255.0 green:206/255.0 blue:206/255.0 alpha:1];
        
        self.backgroundView = [UIView new];
        self.backgroundView.frame = CGRectMake(20, 30, kScreentWidth - 40, 74);
        [self.contentView addSubview:self.backgroundView];
        self.backgroundView.backgroundColor = kWhiteColor;
        
        self.nameLabel = [UILabel new];
        self.nameLabel.frame = CGRectMake(10, 0, kScreentWidth - 60, 30);
        [self.backgroundView addSubview:self.nameLabel];
        self.nameLabel.font = [UIFont systemFontOfSize:17];
//        self.nameLabel.backgroundColor = kWhiteColor;
        
        self.descLabel = [UILabel new];
        self.descLabel.frame = CGRectMake(10, 30, kScreentWidth - 60, 44);
        [self.backgroundView addSubview:self.descLabel];
        self.descLabel.font = [UIFont systemFontOfSize:15];
        self.descLabel.textColor = [UIColor colorWithRed:70/255.0 green:70/255.0 blue:70/255.0 alpha:1];
        self.descLabel.numberOfLines = 0;
//        self.descLabel.backgroundColor = kWhiteColor;
    }
    return self;
}

- (void)layoutSubviews {
    CGSize size = [self.descLabel sizeThatFits:CGSizeMake(self.descLabel.frame.size.width, MAXFLOAT)];
    self.descLabel.frame = CGRectMake(10, 30, kScreentWidth - 60, size.height);
    self.backgroundView.frame = CGRectMake(20, 30, kScreentWidth - 40, size.height + 30 + 10);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
