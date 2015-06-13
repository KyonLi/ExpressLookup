//
//  ExpressData.h
//  ExpressLookup
//
//  Created by Kyon on 15/6/1.
//  Copyright (c) 2015年 Kyon Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExpressData : NSObject

@property (nonatomic, copy, readonly) NSString *time;
@property (nonatomic, copy, readonly) NSString *location;
@property (nonatomic, copy, readonly) NSString *context;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
