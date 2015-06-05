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

- (void)refreshCellWithType:(cellType)cellType andData:(ExpressData *)data orExpress:(Express *)express index:(NSInteger)index {
	if (cellType == expressData) {
		if (index % 2 == 0) {
			[self setBackgroundColor:[UIColor whiteColor]];
		} else {
			[self setBackgroundColor:[UIColor lightGrayColor]];
		}
		UILabel *label1 = (UILabel *)[[self contentView] viewWithTag:200];
		[label1 setAdjustsFontSizeToFitWidth:YES];
		UILabel *label2 = (UILabel *)[[self contentView] viewWithTag:201];
		[label2 setAdjustsFontSizeToFitWidth:YES];
		UILabel *label3 = (UILabel *)[[self contentView] viewWithTag:202];
		[label3 setAdjustsFontSizeToFitWidth:YES];
		NSArray *array = [data.time componentsSeparatedByString:@" "];
		[label1 setText:array[0]];
		NSString *time = array[1];
		[label2 setText:[time substringToIndex:5]];
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
