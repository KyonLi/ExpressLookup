//
//  PhoneTableViewCell.m
//  ExpressLookup
//
//  Created by Kyon on 15/6/15.
//  Copyright (c) 2015年 Kyon Li. All rights reserved.
//

#import "PhoneTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "PhoneNumber.h"

@interface PhoneTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end

@implementation PhoneTableViewCell

- (void)awakeFromNib {
    // Initialization code
	
}

- (void)refreshCell:(PhoneNumber *)phoneNum {
	[_iconImageView sd_setImageWithURL:phoneNum.iconUrl placeholderImage:[UIImage imageNamed:@"56-truck"]];
	[_titleLabel setText:phoneNum.name];
	[_detailLabel setText:phoneNum.phoneNumber];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
