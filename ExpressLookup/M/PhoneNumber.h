//
//  PhoneNumber.h
//  ExpressLookup
//
//  Created by Kyon on 15/6/15.
//  Copyright (c) 2015年 Kyon Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhoneNumber : NSObject
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSURL *iconUrl;
@property (nonatomic, copy, readonly) NSString *phoneNumber;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
