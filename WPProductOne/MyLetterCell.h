//
//  MyLetterCell.h
//  WPProductOne
//
//  Created by ZeroHour on 2017/9/29.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyLetterCell : UITableViewCell

@property (nonatomic, strong) NIMMessage * message;
@property (nonatomic, strong) UILabel * tagLabel;
@property (nonatomic, strong) UIImageView * headPhoto;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * msgLbl;
@property (nonatomic, strong) UIImageView * msgImageView;
@end
