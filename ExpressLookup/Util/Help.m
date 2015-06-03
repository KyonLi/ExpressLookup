//
//  Help.m
//  ExpressLookup
//
//  Created by Kyon on 15/6/3.
//  Copyright (c) 2015年 Kyon Li. All rights reserved.
//

#import "Help.h"
#import "TFHpple.h"

@implementation Help

+ (NSDictionary *)htmlToDictionary:(NSData *)data Company:(NSString *)com Order:(NSString *)order {
	NSMutableDictionary *dic = [NSMutableDictionary new];
	[dic setValue:com forKey:@"com"];
	
	TFHpple *doc = [[TFHpple alloc] initWithHTMLData:data];
	NSArray *divs = [doc searchWithXPathQuery:@"//div[@class='w-query']"];
	TFHppleElement *div = [divs objectAtIndex:0];
	NSArray *forms = [div searchWithXPathQuery:@"//form"];
	TFHppleElement *form = [forms objectAtIndex:0];
	NSArray *ps = [form searchWithXPathQuery:@"//p"];
	
	/*
	 0:PhoneNumber
	 2:Info
	 4~last:ExpressData
	 */
	
	TFHppleElement *phoneNumber = [ps objectAtIndex:0];
	NSString *comcontact = [phoneNumber text];
	comcontact = [comcontact substringFromIndex:5];
	[dic setValue:comcontact forKey:@"comcontact"];
	
	TFHppleElement *info = [ps objectAtIndex:2];
//	NSString *companyName = [info text];
//	companyName = [companyName substringToIndex:companyName.length - 3];
//	[dic setValue:companyName forKey:@"companyName"];
	NSArray *strongs = [info childrenWithTagName:@"strong"];
	NSString *nu = [[strongs firstObject] text];
	[dic setValue:nu forKey:@"nu"];
	
	if ([form searchWithXPathQuery:@"//div[@id='errordiv']"].count) {
		[dic setValue:@"0" forKey:@"status"];
		NSArray *errorDivs = [form searchWithXPathQuery:@"//div[@id='errordiv']"];
		TFHppleElement *errorDiv = [errorDivs firstObject];
		NSArray *errorPs = [errorDiv searchWithXPathQuery:@"//p"];
		TFHppleElement *errorP = [errorPs firstObject];
		NSString *message = [errorP text];
		[dic setValue:message forKey:@"message"];
	} else {
		[dic setValue:@"1" forKey:@"status"];
		NSMutableArray *expressData = [NSMutableArray new];
		if ([order isEqualToString:@"desc"]) {
			for (NSInteger i = ps.count - 1; i >= 4; i--) {
				TFHppleElement *element = [ps objectAtIndex:i];
				NSString *time = [element text];
				time = [time substringFromIndex:1];
				
				NSString *rawStr = [element raw];
				NSRange startRange = [rawStr rangeOfString:@"<br/> "];
				NSRange endRange = [rawStr rangeOfString:@"</p>"];
				NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
				NSString *context = [rawStr substringWithRange:range];
				
				NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:time, @"time", context, @"context", nil];
				[expressData addObject:data];
			}
		} else {
			for (NSInteger i = 4; i < ps.count; i++) {
				TFHppleElement *element = [ps objectAtIndex:i];
				NSString *time = [element text];
				time = [time substringFromIndex:1];
				
				NSString *rawStr = [element raw];
				NSRange startRange = [rawStr rangeOfString:@"<br/> "];
				NSRange endRange = [rawStr rangeOfString:@"</p>"];
				NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
				NSString *context = [rawStr substringWithRange:range];
				
				NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:time, @"time", context, @"context", nil];
				[expressData addObject:data];
			}
		}
		[dic setValue:expressData forKey:@"data"];
	}
	return dic;
}

@end
