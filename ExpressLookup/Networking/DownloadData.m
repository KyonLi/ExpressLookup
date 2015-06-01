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

@implementation DownloadData

+ (NSURLSessionDataTask *)getJsonDataWithBlock:(void (^)(Express *data, NSError *error))block andExpressNumber:(NSString *)nu andCompany:(NSString *)com {
    return [[AFAppDotNetAPIClient sharedClient] GET:[NSString stringWithFormat:@"http://api.kuaidi100.com/api?id=%@&com=%@&nu=%@&valicode=&show=0&muti=1&order=desc", KUAIDI_KEY, com, nu] parameters:nil success:^(NSURLSessionDataTask *task, NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        Express *express = [[Express alloc] initWithDic:dic];
        if (block) {
            block (express, nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"failed");
        Express *express = [Express new];
        if (block) {
            block (express, error);
        }
    }];
}

@end
