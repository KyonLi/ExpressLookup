//
//  ResultTableViewCell.h
//  ExpressLookup
//
//  Created by Kyon on 15/6/2.
//  Copyright (c) 2015年 Kyon Li. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ExpressData;

@interface ResultTableViewCell : UITableViewCell

@property (nonatomic, retain) NSString *type;

- (void)refreshCellWithType:(cellType)cellType andData:(ExpressData *)data orInfo:(NSString *)info;

@end