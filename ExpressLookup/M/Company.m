//
//  Company.m
//  ExpressLookup
//
//  Created by Kyon on 15/6/12.
//  Copyright (c) 2015年 Kyon Li. All rights reserved.
//

#import "Company.h"
#import "PinYin4Objc.h"

@implementation Company

- (instancetype)initWithCompanyName:(NSString *)comName {
	if (self = [super init]) {
		_comName = comName;
		
		HanyuPinyinOutputFormat *outputFormat=[[HanyuPinyinOutputFormat alloc] init];
		[outputFormat setToneType:ToneTypeWithoutTone];
		[outputFormat setVCharType:VCharTypeWithV];
		[outputFormat setCaseType:CaseTypeLowercase];
		_comPinYin = [PinyinHelper toHanyuPinyinStringWithNSString:comName withHanyuPinyinOutputFormat:outputFormat withNSString:@""];
	}
	return self;
}

- (NSString *)description {
	return [NSString stringWithFormat:@"%@--->%@", _comName, _comPinYin];
}

@end
