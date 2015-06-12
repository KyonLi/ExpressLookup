//
//  CompanyGroup.h
//  ExpressLookup
//
//  Created by Kyon on 15/6/12.
//  Copyright (c) 2015年 Kyon Li. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Company;

@interface CompanyGroup : NSObject
@property (nonatomic, retain, readonly) NSMutableArray *companyArray;
@property (nonatomic, retain, readonly) NSString *groupName;

@end
