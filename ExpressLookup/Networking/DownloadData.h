//
//  DownloadData.h
//  ExpressLookup
//
//  Created by Kyon on 15/6/1.
//  Copyright (c) 2015年 Kyon Li. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Express;

@interface DownloadData : NSObject

+ (NSURLSessionDataTask *)getJsonDataWithBlock:(void (^)(Express *data, NSError *error))block andExpressNumber:(NSString *)nu andCompany:(NSString *)com andOrder:(NSString *)order;
+ (NSURLSessionDataTask *)getHtmlDataWithBlock:(void (^)(Express *data, NSError *error))block andExpressNumber:(NSString *)nu andCompany:(NSString *)com andOrder:(NSString *)order;

@end
