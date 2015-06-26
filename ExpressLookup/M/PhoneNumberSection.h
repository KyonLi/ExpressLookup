//
//  PhoneNumberSection.h
//  ExpressLookup
//
//  Created by Kyon on 15/6/15.
//  Copyright (c) 2015年 Kyon Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhoneNumberSection : NSObject
@property (nonatomic, readonly) NSString *section;
@property (nonatomic, readonly) NSInteger phoneCount;
@property (nonatomic, readonly) NSMutableArray *phoneNumbers;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
