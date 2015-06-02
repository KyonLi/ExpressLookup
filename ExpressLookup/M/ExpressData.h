//
//  ExpressData.h
//  ExpressLookup
//
//  Created by Kyon on 15/6/1.
//  Copyright (c) 2015年 Kyon Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExpressData : NSObject

@property (nonatomic, retain, readonly) NSString *time;
@property (nonatomic, retain, readonly) NSString *location;
@property (nonatomic, retain) NSString *context;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
