//
//  DownloadData.m
//  ExpressLookup
//
//  Created by Kyon on 15/6/1.
//  Copyright (c) 2015年 Kyon Li. All rights reserved.
//

#import "DownloadData.h"
#import "AFAppDotNetAPIClient.h"
#import "Express.h"
#import "Macro.h"
#import "Help.h"

@implementation DownloadData

+ (NSURLSessionDataTask *)getJsonDataWithBlock:(void (^)(Express *data, NSError *error))block andExpressNumber:(NSString *)nu andCompany:(NSString *)com andOrder:(NSString *)order {
    return [[AFAppDotNetAPIClient sharedClient] GET:[NSString stringWithFormat:@"http://api.kuaidi100.com/api?id=%@&com=%@&nu=%@&valicode=&show=0&muti=1&order=%@", KUAIDI_KEY, com, nu, order] parameters:nil success:^(NSURLSessionDataTask *task, NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        Express *express = [[Express alloc] initWithDic:dic];
        if (block) {
            block (express, nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"failed");
		NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"2", @"status", @"数据获取失败，请检查网络连接并稍后再试", @"message", nil];
		Express *express = [[Express alloc] initWithDic:dic];
        if (block) {
            block (express, error);
        }
    }];
}

+ (NSURLSessionDataTask *)getHtmlDataWithBlock:(void (^)(Express *data, NSError *error))block andExpressNumber:(NSString *)nu andCompany:(NSString *)com andOrder:(NSString *)order {
	return [[AFAppDotNetAPIClient sharedClient] GET:[NSString stringWithFormat:@"http://wap.kuaidi100.com/wap_result.jsp?rand=20120517&id=%@&fromWeb=null&&postid=%@", com, nu] parameters:nil success:^(NSURLSessionDataTask *task, NSData *data) {
		NSDictionary *dic = [Help htmlToDictionary:data Company:com Order:order];
		Express *express = [[Express alloc] initWithDic:dic];
		if (block) {
			block (express, nil);
		}
	} failure:^(NSURLSessionDataTask *task, NSError *error) {
		NSLog(@"failed");
		NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"2", @"status", @"数据获取失败，请检查网络连接并稍后再试", @"message", nil];
		Express *express = [[Express alloc] initWithDic:dic];
		if (block) {
			block (express, error);
		}
	}];
}

@end
