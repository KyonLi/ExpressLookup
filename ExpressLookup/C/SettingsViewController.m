//
//  SettingsViewController.m
//  ExpressLookup
//
//  Created by Kyon on 15/6/1.
//  Copyright (c) 2015年 Kyon Li. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *orderSwitch;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	[[self navigationItem] setTitle:@"设置"];
	
}

- (IBAction)orderSwitchValueChanged:(UISwitch *)sender {
	[[NSUserDefaults standardUserDefaults] setBool:sender.isOn forKey:@"order"];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	// On:降序  Off:升序
	BOOL order = [[NSUserDefaults standardUserDefaults] boolForKey:@"order"];
	[_orderSwitch setOn:order];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
