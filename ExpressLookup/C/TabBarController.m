//
//  TabBarController.m
//  ExpressLookup
//
//  Created by Kyon on 15/6/1.
//  Copyright (c) 2015年 Kyon Li. All rights reserved.
//

#import "TabBarController.h"
#import "MyExpressViewController.h"
#import "LookupViewController.h"
#import "SettingsViewController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	MyExpressViewController *myExpressVC = [[MyExpressViewController alloc] init];
	UINavigationController *myExpressNav = [[UINavigationController alloc] initWithRootViewController:myExpressVC];
	[[myExpressNav tabBarItem] setTitle:@"我的"];
	
	LookupViewController *lookupVC = [[LookupViewController alloc] init];
	UINavigationController *lookupNav = [[UINavigationController alloc] initWithRootViewController:lookupVC];
	[[lookupNav tabBarItem] setTitle:@"查询"];
	
	SettingsViewController *settingsVC = [[SettingsViewController alloc] init];
	UINavigationController *settingsNav = [[UINavigationController alloc] initWithRootViewController:settingsVC];
	[[settingsNav tabBarItem] setTitle:@"设置"];
	
	[self setViewControllers:@[myExpressNav, lookupNav, settingsNav] animated:YES];
	
	[self setSelectedIndex:1];
	
	
	
	[[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.176 green:0.510 blue:0.749 alpha:1.000]];
	NSShadow *shadow = [[NSShadow alloc] init];
	shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
	shadow.shadowOffset = CGSizeMake(0, 1);
	[[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], NSForegroundColorAttributeName,shadow, NSShadowAttributeName,[UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:21.0], NSFontAttributeName, nil]];
	[[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
