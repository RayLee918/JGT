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
        
        // 背景
        self.cardImageView = [UIImageView new];
        self.cardImageView.frame = CGRectMake(30, 10, kScreentWidth - 30 * 2, 120);
        [self.contentView addSubview:self.cardImageView];
        self.cardImageView.backgroundColor = kBlueColor;
        
        // 指定圆角
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.cardImageView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10,10)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.cardImageView.bounds;
        maskLayer.path = maskPath.CGPath;
        self.cardImageView.layer.mask = maskLayer;
        
        // 通用银行图标
        UIImageView * bankImageView = [UIImageView new];
        bankImageView.frame = CGRectMake(10, 10, 40, 40);
        [self.cardImageView addSubview:bankImageView];
        bankImageView.image = kImageNamed(@"card.png");
        
        // 银行卡
        self.bankLabel = [UILabel new];
        self.bankLabel.frame = CGRectMake(CGRectGetMaxX(bankImageView.frame) + 10, 10, 150, 44);
        [self.cardImageView addSubview:self.bankLabel];
        self.bankLabel.font = [UIFont systemFontOfSize:15];
        self.bankLabel.textColor = kWhiteColor;
        
        // 卡类型
        self.typeLabel = [UILabel new];
        self.typeLabel.frame = CGRectMake(self.cardImageView.frame.size.width - 20 - 88, 10, 88, 44);
        [self.cardImageView addSubview:self.typeLabel];
        self.typeLabel.font = [UIFont systemFontOfSize:13];
        self.typeLabel.textColor = kWhiteColor;
        self.typeLabel.textAlignment = NSTextAlignmentRight;
    
        // 卡号
        self.cardNumberLabel = [UILabel new];
        self.cardNumberLabel.frame = CGRectMake(10, 64, self.cardImageView.frame.size.width - 20, 120 - 64);
        [self.cardImageView addSubview:self.cardNumberLabel];
        self.cardNumberLabel.font = [UIFont systemFontOfSize:23];
        self.cardNumberLabel.textColor = kWhiteColor;
        self.cardNumberLabel.textAlignment = NSTextAlignmentLeft;
        
        // 发卡组织
        self.issueImageView = [UIImageView new];
        self.issueImageView.frame = CGRectMake(self.cardImageView.frame.size.width - 20 - 46, self.cardImageView.frame.size.height - 15 - 14, 46, 14);
        [self.cardImageView addSubview:self.issueImageView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
