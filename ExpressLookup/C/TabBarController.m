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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
