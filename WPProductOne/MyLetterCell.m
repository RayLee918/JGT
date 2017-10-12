//
//  MyLetterCell.m
//  WPProductOne
//
//  Created by ZeroHour on 2017/9/29.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import "MyLetterCell.h"

@implementation MyLetterCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.backgroundColor = kClearColor;
        
        self.headPhoto = [[UIImageView alloc] initWithFrame:CGRectMake(kScreentWidth - 15 - 34, 5, 34, 34)];
        [self.contentView addSubview:self.headPhoto];
        
        self.tagLabel = [UILabel new];
        self.tagLabel.frame = CGRectMake(kScreentWidth - 15 - 34 - 30 - 5, CGRectGetMinY(self.headPhoto.frame), 30, 15);
        self.tagLabel.textAlignment = NSTextAlignmentCenter;
        self.tagLabel.font = [UIFont systemFontOfSize:10];
        self.tagLabel.textColor = kWhiteColor;
        [self.contentView addSubview:self.tagLabel];
        
        self.nameLabel = [UILabel new];
        self.nameLabel.frame = CGRectMake(kScreentWidth - 30 - 34 - 150 - 30 - 5, CGRectGetMinY(self.headPhoto.frame), 150, 15);
        self.nameLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.nameLabel];
        
        self.msgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30 + 34, 25, kScreentWidth - 60 - 68, 44)];
        self.msgImageView.image = kImageNamed(@"msg_background_red.png");
        [self.contentView addSubview:self.msgImageView];
        
        self.msgLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, self.msgImageView.frame.size.width - 35, self.msgImageView.frame.size.height - 20)];
        [self.msgImageView addSubview:self.msgLbl];
        self.msgLbl.textAlignment = NSTextAlignmentRight;
        self.msgLbl.numberOfLines = 0;
        self.msgLbl.textColor = kWhiteColor;
    }
    return self;
}

- (void)setMessage:(NIMMessage *)message {
    _message = message;
    NSLog(@"remoteExt - %@", message.remoteExt);
    NSDictionary * dic = message.remoteExt;
//    self.headPhoto.image = kImageNamed(@"default_head.png");
    [self.headPhoto setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kJGTGetImage, dic[@"headPic"]]] placeholderImage:kImageNamed(@"default_head.png")];
    if ([dic[kIsLecturer] isEqualToString:@"1"]) {
        self.tagLabel.backgroundColor = kLecturerColor;
        self.tagLabel.text = @"讲师";
    } else {
        self.tagLabel.backgroundColor = kStudentColor;
        self.tagLabel.text = @"群众";
    }
    
//    self.nameLabel.text = message.from;
    self.nameLabel.text = dic[kNickName];
    self.msgLbl.text = message.text;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 自适应高度
    CGRect frame = CGRectMake(30 + 34, 25, kScreentWidth - 60 - 68 - 35, 44);
    CGSize size = [self.msgLbl sizeThatFits:CGSizeMake(frame.size.width, MAXFLOAT)];
    
    self.msgImageView.frame = CGRectMake(kScreentWidth - 30 - 34 - (size.width + 35), 25, size.width + 35, size.height + 20);
    UIImage* img=[UIImage imageNamed:@"msg_background_red.png"];//原图
    UIEdgeInsets edge=UIEdgeInsetsMake(10, 15, 10, 20);
    img = [img resizableImageWithCapInsets:edge resizingMode:UIImageResizingModeStretch];
    self.msgImageView.image=img;
    
    self.msgLbl.frame = CGRectMake(15, 10, size.width, size.height);
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
