//
//  PhoneNumber.m
//  ExpressLookup
//
//  Created by Kyon on 15/6/15.
//  Copyright (c) 2015年 Kyon Li. All rights reserved.
//

#import "PhoneNumber.h"

@implementation PhoneNumber

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
	NSString *urlStr = [NSString stringWithFormat:@"http://cdn.kuaidi100.com/images/all/56/%@.png", value];
	_iconUrl = [NSURL URLWithString:urlStr];
}

@end
