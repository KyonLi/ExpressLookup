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

- (id)valueForUndefinedKey:(NSString *)key {
	return nil;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
	
}

#pragma mark --归档时对数据的处理
- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeObject:_time forKey:@"time"];
	[aCoder encodeObject:_location forKey:@"location"];
	[aCoder encodeObject:_context forKey:@"context"];
}

#pragma mark --解档将aDecoder里面的数据取出
- (id)initWithCoder:(NSCoder *)aDecoder {
	
	if (self = [super init]) {
		_time = [aDecoder decodeObjectForKey:@"time"];
		_location = [aDecoder decodeObjectForKey:@"location"];
		_context = [aDecoder decodeObjectForKey:@"context"];
	}
	
	return self;
}

+ (BOOL)supportsSecureCoding {
	return YES;
}

- (NSString *)description {
	return [NSString stringWithFormat:@"%@ %@", _time, _context];
}

@end
