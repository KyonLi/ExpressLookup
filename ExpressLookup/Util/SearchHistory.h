//
//  SearchHistory.h
//  ExpressLookup
//
//  Created by Kyon on 15/6/2.
//  Copyright (c) 2015年 Kyon Li. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Express;

@interface SearchHistory : NSObject
@property (nonatomic, retain) NSMutableArray *historyArray;

/**
 * gets singleton object.
 * @return singleton
 */
+ (SearchHistory*)sharedInstance;
- (void)addHistoryRecord:(Express *)express;
- (NSArray *)getHistoryRecord;

@end
