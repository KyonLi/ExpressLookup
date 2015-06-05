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
	shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
	shadow.shadowOffset = CGSizeMake(0, 1);
	[[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], NSForegroundColorAttributeName,shadow, NSShadowAttributeName,[UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:21.0], NSFontAttributeName, nil]];
	[[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
	
	// 使用颜色创建UIImage
	CGSize imageSize = CGSizeMake(self.view.frame.size.width, 49);
	UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
	[[UIColor blackColor] set];
	UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
	UIImage *tabBarBackgroundImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	imageSize = CGSizeMake(self.view.frame.size.width / 3 - 20, 49);
	UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
	[[UIColor colorWithRed:0.000 green:0.502 blue:1.000 alpha:1.000] set];
	UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
	UIImage *tabBarSelectionIndicatorImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	[[UITabBar appearance] setBackgroundImage:tabBarBackgroundImage];
	[[UITabBar appearance] setSelectionIndicatorImage:tabBarSelectionIndicatorImage];
	[[UITabBar appearance] setTintColor:[UIColor whiteColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
