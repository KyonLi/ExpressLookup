//
//  SettingsTableViewController.m
//  ExpressLookup
//
//  Created by Kyon on 15/6/5.
//  Copyright (c) 2015年 Kyon Li. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "MBProgressHUD.h"

@interface SettingsTableViewController () <UIAlertViewDelegate>
{
	UISwitch *_orderSwitch;
	UITableViewCell *_orderCell;
}
@end

@implementation SettingsTableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style {
	if (self = [super initWithStyle:UITableViewStyleGrouped]) {
		
	}
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationItem] setTitle:@"设置"];
	_orderSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 80, 10, 50, 40)];
	[_orderSwitch addTarget:self action:@selector(orderSwitchValueChanged:) forControlEvents:UIControlEventValueChanged];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingsCell"];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SettingsCell"];
		[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	}
	if (indexPath.section == 0) {
		[[cell detailTextLabel] setNumberOfLines:2];
		_orderCell = cell;
		[cell addSubview:_orderSwitch];
		[[cell textLabel] setText:@"降序排列快递进度"];
		if (_orderSwitch.isOn) {
			[[cell detailTextLabel] setText:@"\n将以由新到旧的顺序显示快递详情"];
		} else {
			[[cell detailTextLabel] setText:@"\n将以由旧到新顺的序显示快递详情"];
		}
	} else {
		[[cell textLabel] setText:@"清空历史记录"];
	}
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 0) {
		return 60;
	} else {
		return 44;
	}
	
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 1) {
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"将会清除所有历史记录，是否继续？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"继续", nil];
		[alertView show];
	}
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 1) {
		MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
		[self.view addSubview:hud];
		hud.labelText = @"清除成功";
		hud.mode = MBProgressHUDModeText;
		[hud showAnimated:YES whileExecutingBlock:^{
			[[Singleton sharedInstance] removeAllHistoryRecord];
			sleep(1);
		} completionBlock:^{
			[hud removeFromSuperview];
		}];
	}
}

- (void)orderSwitchValueChanged:(UISwitch *)sender {
	if (sender.isOn) {
		[[_orderCell detailTextLabel] setText:@"将以由新到旧的顺序显示快递详情"];
	} else {
		[[_orderCell detailTextLabel] setText:@"将以由旧到新顺的序显示快递详情"];
	}
	[[NSUserDefaults standardUserDefaults] setBool:sender.isOn forKey:@"order"];
}

@end
