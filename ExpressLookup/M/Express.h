//
//  Express.h
//  ExpressLookup
//
//  Created by Kyon on 15/6/1.
//  Copyright (c) 2015年 Kyon Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Express : NSObject <NSSecureCoding>

@property (nonatomic, copy, readonly) NSString *nu;
@property (nonatomic, copy, readonly) NSString *comcontact;
@property (nonatomic, copy, readonly) NSString *companytype;
@property (nonatomic, copy, readonly) NSString *com;
@property (nonatomic, copy, readonly) NSString *signname;
@property (nonatomic, copy, readonly) NSString *condition;
@property (nonatomic, copy, readonly) NSString *status;
@property (nonatomic, copy, readonly) NSString *codenumber;
@property (nonatomic, readonly) NSMutableArray *expressData;
@property (nonatomic, copy, readonly) NSString *signedtime;
@property (nonatomic, copy, readonly) NSString *state;
@property (nonatomic, copy, readonly) NSString *departure;
@property (nonatomic, copy, readonly) NSString *addressee;
@property (nonatomic, copy, readonly) NSString *destination;
@property (nonatomic, copy, readonly) NSString *message;
@property (nonatomic, copy, readonly) NSString *ischeck;
@property (nonatomic, copy, readonly) NSString *pickuptime;
@property (nonatomic, copy, readonly) NSString *comurl;
@property (nonatomic, copy) NSString *companyName;
@property (nonatomic, copy, readonly) NSString *comIcon;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
