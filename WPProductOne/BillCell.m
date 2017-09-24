//
//  BillCell.m
//  WPProductOne
//
//  Created by ZeroHour on 2017/8/23.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import "BillCell.h"

@implementation BillCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.dateLabel = [UILabel new];
        self.dateLabel.frame = CGRectMake(0, 0, 88, 55/2);
        self.dateLabel.font = [UIFont systemFontOfSize:13];
        self.dateLabel.textColor = kColor(0xB0B0B0);
        [self.contentView addSubview:self.dateLabel];
        self.dateLabel.textAlignment = NSTextAlignmentCenter;
        
        self.timeLabel = [UILabel new];
        self.timeLabel.frame = CGRectMake(0, 55/2, 88, 55/2);
        self.timeLabel.font = [UIFont systemFontOfSize:13];
        self.timeLabel.textColor = kColor(0xB0B0B0);
        [self.contentView addSubview:self.timeLabel];
        self.timeLabel.textAlignment = NSTextAlignmentCenter;
        
//        self.cardImageView = [[UIImageView alloc] init];
//        self.cardImageView.frame = CGRectMake(CGRectGetMaxX(self.dateLabel.frame), (55-41.5)/2, 41.5, 41.5);
//        [self.contentView addSubview:self.cardImageView];
//        self.cardImageView.image = [UIImage imageNamed:@"card.png"];
//        self.cardImageView.backgroundColor = kRedColor;
        
        self.moneyLabel = [UILabel new];
        self.moneyLabel.frame = CGRectMake(CGRectGetMaxX(self.dateLabel.frame) + 10, CGRectGetMinY(self.cardImageView.frame), kScreentWidth - CGRectGetMaxX(self.dateLabel.frame) - kMargin10, 55/2);
        self.moneyLabel.font = [UIFont systemFontOfSize:15];
        self.moneyLabel.textColor = kColor(0x1F1F1F);
        [self.contentView addSubview:self.moneyLabel];
        self.moneyLabel.textAlignment = NSTextAlignmentLeft;
    
        self.descLabel = [UILabel new];
        self.descLabel.frame = CGRectMake(CGRectGetMinX(self.moneyLabel.frame), CGRectGetMaxY(self.moneyLabel.frame), self.moneyLabel.frame.size.width, self.moneyLabel.frame.size.height);
        self.descLabel.font = [UIFont systemFontOfSize:13];
        self.descLabel.textColor = kColor(0x888C96);
        [self.contentView addSubview:self.descLabel];
        self.descLabel.textAlignment = NSTextAlignmentLeft;
    }

    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
