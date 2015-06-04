//
//  Express.h
//  ExpressLookup
//
//  Created by Kyon on 15/6/1.
//  Copyright (c) 2015年 Kyon Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Express : NSObject <NSSecureCoding>

@property (nonatomic, retain, readonly) NSString *nu;
@property (nonatomic, retain, readonly) NSString *comcontact;
@property (nonatomic, retain, readonly) NSString *companytype;
@property (nonatomic, retain, readonly) NSString *com;
@property (nonatomic, retain, readonly) NSString *signname;
@property (nonatomic, retain, readonly) NSString *condition;
@property (nonatomic, retain, readonly) NSString *status;
@property (nonatomic, retain, readonly) NSString *codenumber;
@property (nonatomic, retain, readonly) NSMutableArray *expressData;
@property (nonatomic, retain, readonly) NSString *signedtime;
@property (nonatomic, retain, readonly) NSString *state;
@property (nonatomic, retain, readonly) NSString *departure;
@property (nonatomic, retain, readonly) NSString *addressee;
@property (nonatomic, retain, readonly) NSString *destination;
@property (nonatomic, retain, readonly) NSString *message;
@property (nonatomic, retain, readonly) NSString *ischeck;
@property (nonatomic, retain, readonly) NSString *pickuptime;
@property (nonatomic, retain, readonly) NSString *comurl;
@property (nonatomic, retain) NSString *companyName;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
