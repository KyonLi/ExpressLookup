//
//  PhoneTableViewCell.h
//  ExpressLookup
//
//  Created by Kyon on 15/6/15.
//  Copyright (c) 2015年 Kyon Li. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PhoneNumber;

@interface PhoneTableViewCell : UITableViewCell
- (void)refreshCell:(PhoneNumber *)phoneNum;

@end
