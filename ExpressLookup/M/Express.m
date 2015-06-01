//
//  Express.m
//  ExpressLookup
//
//  Created by Kyon on 15/6/1.
//  Copyright (c) 2015年 Kyon Li. All rights reserved.
//

#import "Express.h"
#import "ExpressData.h"

@implementation Express

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        _expressData = [NSMutableArray new];
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (id)valueForUndefinedKey:(NSString *)key {
    return nil;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"data"]) {
        NSArray *array = value;
        for (NSDictionary *dic in array) {
            ExpressData *expressData = [[ExpressData alloc] initWithDic:dic];
            [_expressData addObject:expressData];
        }
    }
}

- (NSString *)description {
    NSString *str = [NSString stringWithFormat:@"%@ %@ %@ %@", _nu, _comcontact, _companytype, _comurl];
    return str;
}

@end
