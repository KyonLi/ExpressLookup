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
		_comIcon = [NSString stringWithFormat:@"http://cdn.kuaidi100.com/images/all/56/%@.png", _com];
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

#pragma mark --归档时对数据的处理
- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeObject:_nu forKey:@"nu"];
	[aCoder encodeObject:_comcontact forKey:@"comcontact"];
	[aCoder encodeObject:_companytype forKey:@"companytype"];
	[aCoder encodeObject:_com forKey:@"com"];
	[aCoder encodeObject:_signname forKey:@"signname"];
	[aCoder encodeObject:_condition forKey:@"condition"];
	[aCoder encodeObject:_status forKey:@"status"];
	[aCoder encodeObject:_codenumber forKey:@"codenumber"];
	[aCoder encodeObject:_expressData forKey:@"expressData"];
	[aCoder encodeObject:_signedtime forKey:@"signedtime"];
	[aCoder encodeObject:_state forKey:@"state"];
	[aCoder encodeObject:_departure forKey:@"departure"];
	[aCoder encodeObject:_addressee forKey:@"addressee"];
	[aCoder encodeObject:_destination forKey:@"destination"];
	[aCoder encodeObject:_message forKey:@"message"];
	[aCoder encodeObject:_ischeck forKey:@"ischeck"];
	[aCoder encodeObject:_pickuptime forKey:@"pickuptime"];
	[aCoder encodeObject:_comurl forKey:@"comurl"];
	[aCoder encodeObject:_comIcon forKey:@"comIcon"];
	[aCoder encodeObject:_companyName forKey:@"companyName"];
}

#pragma mark --解档将aDecoder里面的数据取出
- (id)initWithCoder:(NSCoder *)aDecoder {
	if (self = [super init]) {
		_nu = [aDecoder decodeObjectForKey:@"nu"];
		_comcontact = [aDecoder decodeObjectForKey:@"comcontact"];
		_companytype = [aDecoder decodeObjectForKey:@"companytype"];
		_com = [aDecoder decodeObjectForKey:@"com"];
		_signname = [aDecoder decodeObjectForKey:@"signname"];
		_condition = [aDecoder decodeObjectForKey:@"condition"];
		_status = [aDecoder decodeObjectForKey:@"status"];
		_codenumber = [aDecoder decodeObjectForKey:@"codenumber"];
		_expressData = [aDecoder decodeObjectForKey:@"expressData"];
		_signedtime = [aDecoder decodeObjectForKey:@"signedtime"];
		_state = [aDecoder decodeObjectForKey:@"state"];
		_departure = [aDecoder decodeObjectForKey:@"departure"];
		_addressee = [aDecoder decodeObjectForKey:@"addressee"];
		_destination = [aDecoder decodeObjectForKey:@"destination"];
		_message = [aDecoder decodeObjectForKey:@"message"];
		_ischeck = [aDecoder decodeObjectForKey:@"ischeck"];
		_pickuptime = [aDecoder decodeObjectForKey:@"pickuptime"];
		_comurl = [aDecoder decodeObjectForKey:@"comurl"];
		_comIcon = [aDecoder decodeObjectForKey:@"comIcon"];
		_companyName = [aDecoder decodeObjectForKey:@"companyName"];
	}
	return self;
}

+ (BOOL)supportsSecureCoding {
	return YES;
}

- (NSString *)description {
    NSString *str = [NSString stringWithFormat:@"%@ %@ %@ %@", _nu, _comcontact, _companytype, _comurl];
    return str;
}

@end
