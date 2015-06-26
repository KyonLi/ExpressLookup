//
//  Company.h
//  ExpressLookup
//
//  Created by Kyon on 15/6/12.
//  Copyright (c) 2015年 Kyon Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Company : NSObject
@property (nonatomic, readonly) NSString *comName;
@property (nonatomic, readonly) NSString *comPinYin;

- (instancetype)initWithCompanyName:(NSString *)comName;

@end
