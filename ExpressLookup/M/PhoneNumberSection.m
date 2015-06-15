//
//  PhoneNumberSection.m
//  ExpressLookup
//
//  Created by Kyon on 15/6/15.
//  Copyright (c) 2015年 Kyon Li. All rights reserved.
//

#import "PhoneNumberSection.h"
#import "PhoneNumber.h"

@implementation PhoneNumberSection

- (instancetype)initWithDic:(NSDictionary *)dic {
	if (self = [super init]) {
		_phoneNumbers = [NSMutableArray new];
		[self setValuesForKeysWithDictionary:dic];
	}
	return self;
}

- (id)valueForUndefinedKey:(NSString *)key {
	return nil;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
	NSArray *array = value;
	_phoneCount = array.count;
	for (NSDictionary *dic in array) {
		PhoneNumber *phoneNumber = [[PhoneNumber alloc] initWithDic:dic];
		[_phoneNumbers addObject:phoneNumber];
		phoneNumber = nil;
	}
}

@end
