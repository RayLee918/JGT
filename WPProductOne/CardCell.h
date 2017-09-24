//
//  CardCell.h
//  WPProductOne
//
//  Created by ZeroHour on 2017/8/29.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardCell : UITableViewCell

@property (nonatomic, strong) UIImageView * cardImageView;
@property (nonatomic, strong) UILabel * bankLabel;
@property (nonatomic, strong) UILabel * typeLabel;
@property (nonatomic, strong) UILabel * cardNumberLabel;

@end
