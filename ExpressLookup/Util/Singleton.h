//
//  Singleton.h
//  ExpressLookup
//
//  Created by Kyon on 15/6/3.
//  Copyright (c) 2015年 Kyon Li. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Express;

@interface Singleton : NSObject

+ (Singleton*)sharedInstance;
// 历史记录
- (void)addHistoryRecord:(Express *)express;
- (void)removeHistoryRecordAtIndex:(NSInteger)index;
- (void)removeAllHistoryRecord;
- (NSArray *)getHistoryRecords;
- (void)archiveHistoryArray;

// 收藏
- (void)addFavoriteRecord:(Express *)express;
- (void)removeFavoriteRecordAtIndex:(NSInteger)index;
- (void)removeFavoriteRecordByExpressNumber:(NSString *)nu andCompanyName:(NSString *)com;
- (void)removeAllFavoriteRecord;
- (NSArray *)getFavoriteRecords;
- (BOOL)isFavorited:(NSString *)nu andCompanyName:(NSString *)com;
- (void)archiveFavoriteArray;


- (NSString *)translateCompanyNameIntoCompanyID:(NSString *)companyName;
- (NSArray *)getCompanyNameArray;
- (NSArray *)gatHtmlOnlyCompanyNameArray;
- (BOOL)isHtmlOnly:(NSString *)companyName;


@end
