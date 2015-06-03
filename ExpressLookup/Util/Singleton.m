//
//  Singleton.m
//  ExpressLookup
//
//  Created by Kyon on 15/6/3.
//  Copyright (c) 2015年 Kyon Li. All rights reserved.
//

#import "Singleton.h"
#import "Express.h"

@implementation Singleton
{
	NSMutableArray *_historyArray;
	NSDictionary *_companyDic;
	NSArray *_companyArray;
	NSArray *_companyArrayHtmlOnly;
}

static Singleton *SINGLETON = nil;

static bool isFirstAccess = YES;

#pragma mark - Public Method

+ (id)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isFirstAccess = NO;
        SINGLETON = [[super allocWithZone:NULL] init];    
    });
    
    return SINGLETON;
}

#pragma mark - Life Cycle

+ (id) allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)copyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

- (id)copy
{
    return [[Singleton alloc] init];
}

- (id)mutableCopy
{
    return [[Singleton alloc] init];
}

- (id) init
{
    if(SINGLETON){
        return SINGLETON;
    }
    if (isFirstAccess) {
        [self doesNotRecognizeSelector:_cmd];
    }
    self = [super init];
	_historyArray = [[NSMutableArray alloc] init];
	
	NSString *dicPath = [[NSBundle mainBundle] pathForResource:@"companyDic" ofType:@"txt"];
	_companyDic = [NSDictionary dictionaryWithContentsOfFile:dicPath];
	NSString *arrayPath = [[NSBundle mainBundle] pathForResource:@"companyArray" ofType:@"txt"];
	_companyArray = [NSArray arrayWithContentsOfFile:arrayPath];
	NSString *arrayHtmlOnlyPath = [[NSBundle mainBundle] pathForResource:@"companyArrayHtmlOnly" ofType:@"txt"];
	_companyArrayHtmlOnly = [NSArray arrayWithContentsOfFile:arrayHtmlOnlyPath];
    return self;
}

- (void)addHistoryRecord:(Express *)express {
	for (NSInteger i = 0; i < _historyArray.count; i++) {
		Express *record = _historyArray[i];
		if ([record.nu isEqualToString:express.nu] && [record.com isEqualToString:express.com]) {
			[_historyArray removeObjectAtIndex:i];
			break;
		}
	}
	[_historyArray addObject:express];
}

- (NSArray *)getHistoryRecords {
	return [NSArray arrayWithArray:_historyArray];
}

- (NSString *)translateCompanyNameIntoCompanyID:(NSString *)companyName {
	return [_companyDic valueForKey:companyName];
}

- (NSArray *)getCompanyNameArray {
	return _companyArray;
}

- (NSArray *)gatHtmlOnlyCompanyNameArray {
	return _companyArrayHtmlOnly;
}

- (BOOL)isHtmlOnly:(NSString *)companyName {
	for (NSString *com in _companyArrayHtmlOnly) {
		if ([com isEqualToString:companyName]) {
			return YES;
			break;
		}
	}
	return NO;
}

@end
