//
//  ExpressData.m
//  ExpressLookup
//
//  Created by Kyon on 15/6/1.
//  Copyright (c) 2015年 Kyon Li. All rights reserved.
//

#import "ExpressData.h"

@implementation ExpressData

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (NSString *)description {
	return [NSString stringWithFormat:@"%@ %@", _time, _context];
}

@end
