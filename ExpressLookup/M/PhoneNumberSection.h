//
//  PhoneNumberSection.h
//  ExpressLookup
//
//  Created by Kyon on 15/6/15.
//  Copyright (c) 2015年 Kyon Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhoneNumberSection : NSObject
@property (nonatomic, copy, readonly) NSString *section;
@property (nonatomic, assign, readonly) NSInteger phoneCount;
@property (nonatomic, copy, readonly) NSMutableArray *phoneNumbers;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
