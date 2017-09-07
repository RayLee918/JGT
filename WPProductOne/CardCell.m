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
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
