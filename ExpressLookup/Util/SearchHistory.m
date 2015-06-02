//
//  SearchHistory.m
//  ExpressLookup
//
//  Created by Kyon on 15/6/2.
//  Copyright (c) 2015年 Kyon Li. All rights reserved.
//

#import "SearchHistory.h"
#import "Express.h"

@implementation SearchHistory

static SearchHistory *SINGLETON = nil;

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
    return [[SearchHistory alloc] init];
}

- (id)mutableCopy
{
    return [[SearchHistory alloc] init];
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

- (NSArray *)getHistoryRecord {
	return [NSArray arrayWithArray:_historyArray];
}

@end
