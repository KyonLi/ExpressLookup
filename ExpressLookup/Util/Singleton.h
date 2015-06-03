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
- (void)addHistoryRecord:(Express *)express;
- (NSArray *)getHistoryRecords;
- (NSString *)translateCompanyNameIntoCompanyID:(NSString *)companyName;
- (NSArray *)getCompanyNameArray;
- (NSArray *)gatHtmlOnlyCompanyNameArray;
- (BOOL)isHtmlOnly:(NSString *)companyName;

@end
