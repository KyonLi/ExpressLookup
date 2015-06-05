//
//  ResultTableViewController.m
//  ExpressLookup
//
//  Created by Kyon on 15/6/2.
//  Copyright (c) 2015年 Kyon Li. All rights reserved.
//

#import "ResultTableViewController.h"
#import "MBProgressHUD.h"
#import "DownloadData.h"
#import "Express.h"
#import "ExpressData.h"
#import "ResultTableViewCell.h"

@interface ResultTableViewController ()
{
	NSString *_expressNumber;
	NSString *_company;
	Express *_express;
	NSArray *_dataArray;
	NSInteger _rowNumber;
}
@end

@implementation ResultTableViewController

- (instancetype)initWithExpressNumber:(NSString *)nu andCompany:(NSString *)com {
	if (self = [super init]) {
		_expressNumber = nu;
		_company = com;
	}
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[[self navigationItem] setTitle:@"查询结果"];
	
	MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
	[hud setLabelText:@"查询中，请稍候..."];
	
	static NSString *order = nil;
	if ([[NSUserDefaults standardUserDefaults] boolForKey:@"order"]) {
		order = @"desc";
	} else {
		order = @"asc";
	}
	
	if ([[Singleton sharedInstance] isHtmlOnly:_company]) {
		[DownloadData getHtmlDataWithBlock:^(Express *data, NSError *error) {
			_express = data;
			[_express setCompanyName:_company];
			_dataArray = [data expressData];
//			if (_dataArray.count) {
//				_rowNumber = _dataArray.count + 1;
//			} else {
//				_rowNumber = 0;
//			}
			_rowNumber = _dataArray.count + 1;
			if ([data.status isEqualToString:@"1"]) {
				[[Singleton sharedInstance] addHistoryRecord:_express];
			}
			[[self tableView] reloadData];
			[MBProgressHUD hideHUDForView:self.tableView animated:YES];
		} andExpressNumber:_expressNumber andCompany:[[Singleton sharedInstance] translateCompanyNameIntoCompanyID:_company] andOrder:order];
	} else {
		[DownloadData getJsonDataWithBlock:^(Express *data, NSError *error) {
			_express = data;
			[_express setCompanyName:_company];
			_dataArray = [data expressData];
//			if (_dataArray.count) {
//				_rowNumber = _dataArray.count + 1;
//			} else {
//				_rowNumber = 0;
//			}
			_rowNumber = _dataArray.count + 1;
			if ([data.status isEqualToString:@"1"]) {
				[[Singleton sharedInstance] addHistoryRecord:_express];
			}
			[[self tableView] reloadData];
			[MBProgressHUD hideHUDForView:self.tableView animated:YES];
		} andExpressNumber:_expressNumber andCompany:[[Singleton sharedInstance] translateCompanyNameIntoCompanyID:_company] andOrder:order];
	}
	
	UINib *infoNib = [UINib nibWithNibName:@"ExpressInfoTableViewCell" bundle:nil];
	[[self tableView] registerNib:infoNib forCellReuseIdentifier:@"InfoCell"];
	UINib *dataNib = [UINib nibWithNibName:@"ExpressDataTableViewCell" bundle:nil];
	[[self tableView] registerNib:dataNib forCellReuseIdentifier:@"DataCell"];
	
	[[self tableView] setTableFooterView:[[UIView alloc] init]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _rowNumber;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	ResultTableViewCell *cell = nil;
	if (indexPath.row == 0) {
		cell = [[self tableView] dequeueReusableCellWithIdentifier:@"InfoCell"];
		[cell refreshCellWithType:expressInfo andData:nil orExpress:_express index:indexPath.row];
	} else {
		ExpressData *data = _dataArray[indexPath.row - 1];
		cell = [[self tableView] dequeueReusableCellWithIdentifier:@"DataCell"];
		[cell refreshCellWithType:expressData andData:data orExpress:nil index:indexPath.row];
	}
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 80;
}

@end
