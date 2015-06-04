//
//  ResultTableViewCell.m
//  ExpressLookup
//
//  Created by Kyon on 15/6/2.
//  Copyright (c) 2015年 Kyon Li. All rights reserved.
//

#import "ResultTableViewCell.h"
#import "ExpressData.h"
#import "Express.h"
#import "UIImageView+WebCache.h"

@implementation ResultTableViewCell

- (void)awakeFromNib {
    // Initialization code
	
}

- (void)refreshCellWithType:(cellType)cellType andData:(ExpressData *)data orExpress:(Express *)express {
	if (cellType == expressData) {
		UILabel *label1 = (UILabel *)[[self contentView] viewWithTag:200];
		UILabel *label2 = (UILabel *)[[self contentView] viewWithTag:201];
		UILabel *label3 = (UILabel *)[[self contentView] viewWithTag:202];
		NSArray *array = [data.time componentsSeparatedByString:@" "];
		[label1 setText:array[0]];
		[label2 setText:array[1]];
		[label3 setText:data.context];
	}
	else if (cellType == expressInfo) {
		UIImageView *imageView = (UIImageView *)[[self contentView] viewWithTag:100];
		[imageView sd_setImageWithURL:[NSURL URLWithString:express.comIcon]];
		UILabel *label = (UILabel *)[[self contentView] viewWithTag:101];
		if ([express.status isEqualToString:@"1"]) {
			[label setText:[NSString stringWithFormat:@"%@ %@", express.companyName, express.nu]];
		} else {
			[label setText:[NSString stringWithFormat:@"%@", express.message]];
		}
	}
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
