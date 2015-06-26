//
//  ExpressData.h
//  ExpressLookup
//
//  Created by Kyon on 15/6/1.
//  Copyright (c) 2015年 Kyon Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExpressData : NSObject

@property (nonatomic, readonly) NSString *time;
@property (nonatomic, readonly) NSString *location;
@property (nonatomic, readonly) NSString *context;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
