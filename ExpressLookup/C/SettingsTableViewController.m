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
@property (nonatomic) UISwitch *orderSwitch;
@property (nonatomic) UITableViewCell *orderCell;
@property (nonatomic) UIAlertView *clearHistoryAlertView;

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
	_clearHistoryAlertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"将会清除所有历史记录，是否继续？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"继续", nil];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	// On:降序  Off:升序
	BOOL order = [[NSUserDefaults standardUserDefaults] boolForKey:@"order"];
	[_orderSwitch setOn:order];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[[self tableView] reloadData];
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
	if (section == 0) {
		return 1;
	} else {
		return 2;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = nil;
	if (indexPath.section == 0) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SettingsCell"];
		_orderCell = cell;
		[cell addSubview:_orderSwitch];
		[[cell textLabel] setText:@"降序排列快递进度"];
		if (_orderSwitch.isOn) {
			[[cell detailTextLabel] setText:@"将以由新到旧的顺序显示快递详情"];
		} else {
			[[cell detailTextLabel] setText:@"将以由旧到新顺的序显示快递详情"];
		}
		[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	}
	else if (indexPath.section == 1) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"SettingsCell"];
		if (indexPath.row == 0) {
			[[cell textLabel] setText:@"清空历史记录"];
		}
		else if (indexPath.row == 1) {
			[[cell textLabel] setText:@"清除缓存"];
			[[cell detailTextLabel] setText:[NSString stringWithFormat:@"当前缓存大小：%@ MB", [self getCacheSize]]];
			[[cell detailTextLabel] setFont:[UIFont systemFontOfSize:14.0]];
		}
		[cell setSelectionStyle:UITableViewCellSelectionStyleDefault];
	}
	[[cell detailTextLabel] setTextColor:[UIColor darkGrayColor]];
	
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
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	[cell setSelected:NO animated:YES];
	if (indexPath.section == 1) {
		if (indexPath.row == 0) {
			[_clearHistoryAlertView show];
		}
		else if (indexPath.row == 1) {
			[self cleanCache];
			[self showToast];
			[tableView reloadData];
		}
	}
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 1) {
		[[Singleton sharedInstance] removeAllHistoryRecord];
		[self showToast];
	}
}

- (void)showToast {
	MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
	[self.view addSubview:hud];
	hud.labelText = @"清除成功";
	hud.mode = MBProgressHUDModeText;
	[hud showAnimated:YES whileExecutingBlock:^{
		sleep(1);
	} completionBlock:^{
		[hud removeFromSuperview];
	}];
}

- (void)orderSwitchValueChanged:(UISwitch *)sender {
	if (sender.isOn) {
		[[_orderCell detailTextLabel] setText:@"将以由新到旧的顺序显示快递详情"];
	} else {
		[[_orderCell detailTextLabel] setText:@"将以由旧到新顺的序显示快递详情"];
	}
	[[NSUserDefaults standardUserDefaults] setBool:sender.isOn forKey:@"order"];
}

- (NSString *)getCacheSize {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask,YES);
	NSString *cachesDir = [paths firstObject];
	return [NSString stringWithFormat:@"%.2lf", [self folderSizeAtPath:cachesDir]];
}

- (void)cleanCache {
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask,YES);
	NSString *cachesDir = [paths firstObject];
 
	NSArray *contents = [fileManager contentsOfDirectoryAtPath:cachesDir error:nil];
	NSEnumerator *enumerator = [contents objectEnumerator];
	NSString *filename;
	while ((filename = [enumerator nextObject])) {
		[fileManager removeItemAtPath:[cachesDir stringByAppendingPathComponent:filename] error:nil];
	}
}

- (long long)fileSizeAtPath:(NSString*)filePath{
	NSFileManager* manager = [NSFileManager defaultManager];
	if ([manager fileExistsAtPath:filePath]){
		return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
	}
	return 0;
}

- (float )folderSizeAtPath:(NSString*)folderPath{
	NSFileManager* manager = [NSFileManager defaultManager];
	if (![manager fileExistsAtPath:folderPath]) {
		return 0;
	}
	NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath]objectEnumerator];//从前向后枚举器／／／／//
	NSString* fileName;
	long long folderSize = 0;
	while ((fileName = [childFilesEnumerator nextObject]) != nil){
		NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
		folderSize += [self fileSizeAtPath:fileAbsolutePath];
	}
	return folderSize/(1024.0*1024.0);
}

@end
