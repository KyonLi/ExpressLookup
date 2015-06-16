//
//  Help.h
//  ExpressLookup
//
//  Created by Kyon on 15/6/3.
//  Copyright (c) 2015年 Kyon Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Help : NSObject

+ (NSDictionary *)htmlToDictionary:(NSData *)data Company:(NSString *)com Order:(NSString *)order;
+ (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)aSize;

@end
