//
//  Express.h
//  ExpressLookup
//
//  Created by Kyon on 15/6/1.
//  Copyright (c) 2015年 Kyon Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Express : NSObject <NSSecureCoding>

@property (nonatomic, readonly) NSString *nu;
@property (nonatomic, readonly) NSString *comcontact;
@property (nonatomic, readonly) NSString *companytype;
@property (nonatomic, readonly) NSString *com;
@property (nonatomic, readonly) NSString *signname;
@property (nonatomic, readonly) NSString *condition;
@property (nonatomic, readonly) NSString *status;
@property (nonatomic, readonly) NSString *codenumber;
@property (nonatomic, readonly) NSMutableArray *expressData;
@property (nonatomic, readonly) NSString *signedtime;
@property (nonatomic, readonly) NSString *state;
@property (nonatomic, readonly) NSString *departure;
@property (nonatomic, readonly) NSString *addressee;
@property (nonatomic, readonly) NSString *destination;
@property (nonatomic, readonly) NSString *message;
@property (nonatomic, readonly) NSString *ischeck;
@property (nonatomic, readonly) NSString *pickuptime;
@property (nonatomic, readonly) NSString *comurl;
@property (nonatomic) NSString *companyName;
@property (nonatomic, readonly) NSString *comIcon;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
