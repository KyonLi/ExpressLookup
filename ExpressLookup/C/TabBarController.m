//
//  TabBarController.m
//  ExpressLookup
//
//  Created by Kyon on 15/6/1.
//  Copyright (c) 2015年 Kyon Li. All rights reserved.
//

#import "TabBarController.h"
#import "MyExpressTableViewController.h"
#import "LookupViewController.h"
#import "SettingsTableViewController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	MyExpressTableViewController *myExpressVC = [[MyExpressTableViewController alloc] init];
	UINavigationController *myExpressNav = [[UINavigationController alloc] initWithRootViewController:myExpressVC];
	[[myExpressNav tabBarItem] setTitle:@"我的"];
	[[myExpressNav tabBarItem] setImage:[UIImage imageNamed:@"253-person"]];
	[[myExpressNav tabBarItem] setSelectedImage:[UIImage imageNamed:@"253-person"]];
	
	LookupViewController *lookupVC = [[LookupViewController alloc] init];
	UINavigationController *lookupNav = [[UINavigationController alloc] initWithRootViewController:lookupVC];
	[[lookupNav tabBarItem] setTitle:@"查询"];
	[[lookupNav tabBarItem] setImage:[UIImage imageNamed:@"195-barcode"]];
	[[lookupNav tabBarItem] setSelectedImage:[UIImage imageNamed:@"195-barcode"]];
	
	SettingsTableViewController *settingsVC = [[SettingsTableViewController alloc] init];
	UINavigationController *settingsNav = [[UINavigationController alloc] initWithRootViewController:settingsVC];
	[[settingsNav tabBarItem] setTitle:@"设置"];
	[[settingsNav tabBarItem] setImage:[UIImage imageNamed:@"20-gear-2"]];
	[[settingsNav tabBarItem] setSelectedImage:[UIImage imageNamed:@"20-gear-2"]];
	
	[self setViewControllers:@[myExpressNav, lookupNav, settingsNav] animated:YES];
	
	[self setSelectedIndex:1];
	
	
	
	[[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.176 green:0.510 blue:0.749 alpha:1.000]];
	NSShadow *shadow = [[NSShadow alloc] init];
	shadow.shadowColor = [UIColor clearColor];
	shadow.shadowOffset = CGSizeMake(0, 0);
	[[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,shadow, NSShadowAttributeName,[UIFont boldSystemFontOfSize:23.0], NSFontAttributeName, nil]];
	[[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
	
	[[UITabBar appearance] setBarTintColor:[UIColor blackColor]];
	[[UITabBar appearance] setSelectionIndicatorImage:[self imageWithColor:[UIColor colorWithRed:0.000 green:0.502 blue:1.000 alpha:1.000] andSize:CGSizeMake(self.view.frame.size.width / 3 - 20, 49)]];
	[[UITabBar appearance] setTintColor:[UIColor colorWithWhite:1.000 alpha:0.850]];
}

// 使用颜色创建UIImage
- (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size {
	UIGraphicsBeginImageContextWithOptions(size, 0, [UIScreen mainScreen].scale);
	[color set];
	UIRectFill(CGRectMake(0, 0, size.width, size.height));
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
