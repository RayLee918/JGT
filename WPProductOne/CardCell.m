//
//  CardCell.m
//  WPProductOne
//
//  Created by ZeroHour on 2017/8/29.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import "CardCell.h"

@implementation CardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.cardImageView = [UIImageView new];
        self.cardImageView.frame = CGRectMake(30, 10, kScreentWidth - 30 * 2, 120);
        [self.contentView addSubview:self.cardImageView];
        self.cardImageView.backgroundColor = kBlueColor;
        
        // 银行卡
        self.bankLabel = [UILabel new];
        self.bankLabel.frame = CGRectMake(20, 10, 150, 44);
        [self.cardImageView addSubview:self.bankLabel];
        self.bankLabel.font = [UIFont systemFontOfSize:15];
        self.bankLabel.textColor = kWhiteColor;
        
        // 卡类型
        self.typeLabel = [UILabel new];
        self.typeLabel.frame = CGRectMake(self.cardImageView.frame.size.width - 20 - 150, 20, 150, 44);
        [self.cardImageView addSubview:self.typeLabel];
        self.typeLabel.font = [UIFont systemFontOfSize:13];
        self.typeLabel.textColor = kWhiteColor;
        self.typeLabel.textAlignment = NSTextAlignmentRight;
    
        // 卡号
        self.cardNumberLabel = [UILabel new];
        self.cardNumberLabel.frame = CGRectMake(0, 64, self.cardImageView.frame.size.width, 120 - 64);
        [self.cardImageView addSubview:self.cardNumberLabel];
        self.cardNumberLabel.font = [UIFont systemFontOfSize:23];
        self.cardNumberLabel.textColor = kWhiteColor;
        self.cardNumberLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
