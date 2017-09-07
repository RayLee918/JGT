//
//  DealCell.m
//  WPProductOne
//
//  Created by ZeroHour on 2017/8/25.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import "DealCell.h"

@implementation DealCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.shutiaoView = [UIView new];
        self.shutiaoView.frame = CGRectMake(15, 15, 1.5, 15);
        [self.contentView addSubview:self.shutiaoView];
        self.shutiaoView.backgroundColor = kGlobalColor;
        
        self.hengtiaoView = [UIView new];
        self.hengtiaoView.frame = CGRectMake(0, 0, kScreentWidth, 2);
        [self.contentView addSubview:self.hengtiaoView];
        self.hengtiaoView.backgroundColor = kColor(0xEFEFEF);
        
        // 标题
        self.tittleDescLabel = [UILabel new];
        self.tittleDescLabel.frame = CGRectMake(20, 0, kScreentWidth - 20, 44);
        [self.contentView addSubview:self.tittleDescLabel];
        self.tittleDescLabel.font = [UIFont systemFontOfSize:12];
        self.tittleDescLabel.textColor = kColor(0x1F1F1F);
        
        // 页面1
        self.view1 = [UIView new];
        self.view1.frame = CGRectMake(20, CGRectGetMaxY(self.tittleDescLabel.frame), kScreentWidth - 40, 65);
        [self.contentView addSubview:self.view1];
        self.view1.backgroundColor = kColor(0xF8F3F0);
        
        // A计划
        self.label1 = [UILabel new];
        self.label1.frame = CGRectMake(10, 0, 100, 65/3);
        [self.view1 addSubview:self.label1];
        self.label1.font = [UIFont systemFontOfSize:10];
        self.label1.textColor = kColor(0x1F1F1F);
        
        // 产品介绍
        self.label2 = [UILabel new];
        self.label2.frame = CGRectMake(10, CGRectGetMaxY(self.label1.frame), 100, 65/3);
        [self.view1 addSubview:self.label2];
        self.label2.font = [UIFont systemFontOfSize:10];
        self.label2.textColor = kColor(0x1F1F1F);
        
        // 股币
        self.label3 = [UILabel new];
        self.label3.frame = CGRectMake(200, CGRectGetMaxY(self.label1.frame), 100, 65/3);
        [self.view1 addSubview:self.label3];
        self.label3.font = [UIFont systemFontOfSize:10];
        self.label3.textColor = kColor(0x1F1F1F);
        
        // 描述
        self.label4 = [UILabel new];
        self.label4.frame = CGRectMake(20, CGRectGetMaxY(self.label2.frame), kScreentWidth - 40 * 2, 65/3);
        [self.view1 addSubview:self.label4];
        self.label4.font = [UIFont systemFontOfSize:10];
        self.label4.textColor = kColor(0x9B9B9B);
        
        // 页面2
        self.view2 = [UIView new];
        self.view2.frame = CGRectMake(20, CGRectGetMaxY(self.self.view1.frame) + 10, kScreentWidth - 40, 65);
        [self.contentView addSubview:self.view2];
        self.view2.backgroundColor = kColor(0xF8F3F0);
        
        // A计划
        self.label5 = [UILabel new];
        self.label5.frame = CGRectMake(10, 0, 100, 65/3);
        [self.view2 addSubview:self.label5];
        self.label5.font = [UIFont systemFontOfSize:10];
        self.label5.textColor = kColor(0x1F1F1F);
        
        // 产品介绍
        self.label6 = [UILabel new];
        self.label6.frame = CGRectMake(10, CGRectGetMaxY(self.label1.frame), 100, 65/3);
        [self.view2 addSubview:self.label6];
        self.label6.font = [UIFont systemFontOfSize:10];
        self.label6.textColor = kColor(0x1F1F1F);
        
        // 股币
        self.label7 = [UILabel new];
        self.label7.frame = CGRectMake(200, CGRectGetMaxY(self.label5.frame), 100, 65/3);
        [self.view2 addSubview:self.label7];
        self.label7.font = [UIFont systemFontOfSize:10];
        self.label7.textColor = kColor(0x1F1F1F);
        
        // 描述
        self.label8 = [UILabel new];
        self.label8.frame = CGRectMake(20, CGRectGetMaxY(self.label6.frame), kScreentWidth - 40 * 2, 65/3);
        [self.view2 addSubview:self.label8];
        self.label8.font = [UIFont systemFontOfSize:10];
        self.label8.textColor = kColor(0x9B9B9B);
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
