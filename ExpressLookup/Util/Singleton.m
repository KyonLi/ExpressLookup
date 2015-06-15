//
//  Singleton.m
//  ExpressLookup
//
//  Created by Kyon on 15/6/3.
//  Copyright (c) 2015年 Kyon Li. All rights reserved.
//

#import "Singleton.h"
#import "Express.h"
#import "Company.h"

@implementation Singleton
{
	NSMutableArray *_historyArray;
	NSMutableArray *_favoriteArray;
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
	NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docPath = [paths objectAtIndex:0];
	NSString *historyArchivePath = [docPath stringByAppendingPathComponent:@"history.dat"];
	_historyArray = [NSKeyedUnarchiver unarchiveObjectWithFile:historyArchivePath];
	if (_historyArray) {
		NSLog(@"%s", __func__);
		NSLog(@"历史记录回档成功");
	} else {
		_historyArray = [NSMutableArray new];
		NSLog(@"%s", __func__);
		NSLog(@"历史记录初始化成功");
	}
	
	NSString *favoriteArchivePath = [docPath stringByAppendingPathComponent:@"favorite.dat"];
	_favoriteArray = [NSKeyedUnarchiver unarchiveObjectWithFile:favoriteArchivePath];
	if (_favoriteArray) {
		NSLog(@"%s", __func__);
		NSLog(@"收藏回档成功");
	} else {
		_favoriteArray = [NSMutableArray new];
		NSLog(@"%s", __func__);
		NSLog(@"收藏初始化成功");
	}
	
	NSString *dicPath = [[NSBundle mainBundle] pathForResource:@"companyDic" ofType:@"txt"];
	_companyDic = [NSDictionary dictionaryWithContentsOfFile:dicPath];
	NSString *arrayHtmlOnlyPath = [[NSBundle mainBundle] pathForResource:@"companyArrayHtmlOnly" ofType:@"txt"];
	_companyArrayHtmlOnly = [NSArray arrayWithContentsOfFile:arrayHtmlOnlyPath];
	NSString *arrayPath = [[NSBundle mainBundle] pathForResource:@"companyArray" ofType:@"txt"];
	NSArray *tmpArray = [NSArray arrayWithContentsOfFile:arrayPath];
	
	NSMutableArray *comObjTmp = [NSMutableArray new];
	for (NSString *str in tmpArray) {
		Company *com = [[Company alloc] initWithCompanyName:str];
		[comObjTmp addObject:com];
	}
	_companyArray = [comObjTmp sortedArrayUsingComparator:^NSComparisonResult(Company *obj1, Company *obj2) {
		return [obj1.comPinYin caseInsensitiveCompare:obj2.comPinYin];
	}];
	comObjTmp = nil;
    return self;
}

- (void)addHistoryRecord:(Express *)express {
	if (_historyArray.count == 0) {
		[_historyArray addObject:express];
	} else {
		for (NSInteger i = 0; i < _historyArray.count; i++) {
			Express *record = _historyArray[i];
			if ([record.nu isEqualToString:express.nu] && [record.com isEqualToString:express.com]) {
				[_historyArray removeObjectAtIndex:i];
				break;
			}
		}
		[_historyArray insertObject:express atIndex:0];
	}
}

- (void)removeHistoryRecordAtIndex:(NSInteger)index {
	[_historyArray removeObjectAtIndex:index];
}

- (void)removeAllHistoryRecord {
	[_historyArray removeAllObjects];
}

- (NSArray *)getHistoryRecords {
	return [NSArray arrayWithArray:_historyArray];
}

- (void)archiveHistoryArray {
	NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docPath = [paths firstObject];
	NSString *historyArchivePath = [docPath stringByAppendingPathComponent:@"history.dat"];
	if ([NSKeyedArchiver archiveRootObject:_historyArray toFile:historyArchivePath]) {
		NSLog(@"%s", __func__);
		NSLog(@"历史记录归档成功");
	}
}

- (void)addFavoriteRecord:(Express *)express {
	if (_favoriteArray.count == 0) {
		[_favoriteArray addObject:express];
	} else {
		for (NSInteger i = 0; i < _favoriteArray.count; i++) {
			Express *record = _favoriteArray[i];
			if ([record.nu isEqualToString:express.nu] && [record.com isEqualToString:express.com]) {
				[_favoriteArray removeObjectAtIndex:i];
				break;
			}
		}
		[_favoriteArray insertObject:express atIndex:0];
	}
}

- (void)removeFavoriteRecordAtIndex:(NSInteger)index {
	[_favoriteArray removeObjectAtIndex:index];
}

- (void)removeFavoriteRecordByExpressNumber:(NSString *)nu andCompanyName:(NSString *)com {
	for (NSInteger i = 0; i < _favoriteArray.count; i++) {
		Express *express = [_favoriteArray objectAtIndex:i];
		if ([express.nu isEqualToString:nu] && [express.companyName isEqualToString:com]) {
			[_favoriteArray removeObjectAtIndex:i];
			break;
		}
	}
}

- (BOOL)isFavorited:(NSString *)nu andCompanyName:(NSString *)com {
	for (NSInteger i = 0; i < _favoriteArray.count; i++) {
		Express *express = [_favoriteArray objectAtIndex:i];
		if ([express.nu isEqualToString:nu] && [express.companyName isEqualToString:com]) {
			return YES;
		}
	}
	return NO;
}

- (void)removeAllFavoriteRecord {
	[_favoriteArray removeAllObjects];
}

- (NSArray *)getFavoriteRecords {
	return [NSArray arrayWithArray:_favoriteArray];
}

- (void)archiveFavoriteArray {
	NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docPath = [paths firstObject];
	NSString *historyArchivePath = [docPath stringByAppendingPathComponent:@"favorite.dat"];
	if ([NSKeyedArchiver archiveRootObject:_favoriteArray toFile:historyArchivePath]) {
		NSLog(@"%s", __func__);
		NSLog(@"收藏归档成功");
	}
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
		}
	}
	return NO;
}



@end
