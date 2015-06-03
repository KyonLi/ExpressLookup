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
#import "SearchHistory.h"

@interface ResultTableViewController ()
{
	NSString *_expressNumber;
	NSString *_company;
	NSDictionary *_companyDic;
	NSArray *_companyArray;
	Express *_express;
	NSArray *_dataArray;
	BOOL _isHtmlOnly;
}
@end

@implementation ResultTableViewController

- (instancetype)initWithExpressNumber:(NSString *)nu andCompany:(NSString *)com {
	if (self = [super init]) {
		_expressNumber = nu;
		_company = com;
		_isHtmlOnly = NO;
		NSString *dicPath = [[NSBundle mainBundle] pathForResource:@"companyDic" ofType:@"txt"];
		_companyDic = [NSDictionary dictionaryWithContentsOfFile:dicPath];
		NSString *arrayPath = [[NSBundle mainBundle] pathForResource:@"companyArrayHtmlOnly" ofType:@"txt"];
		_companyArray = [NSArray arrayWithContentsOfFile:arrayPath];
	}
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[[self navigationItem] setTitle:@"查询结果"];
	
	MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
	[hud setLabelText:@"查询中，请稍候..."];
	
	for (NSString *com in _companyArray) {
		if ([com isEqualToString:_company]) {
			[DownloadData getHtmlDataWithBlock:^(Express *data, NSError *error) {
				_express = data;
				[_express setCompanyName:_company];
				_dataArray = [data expressData];
				if ([data.status isEqualToString:@"1"]) {
					[[SearchHistory sharedInstance] addHistoryRecord:_express];
				}
				[[self tableView] reloadData];
				[MBProgressHUD hideHUDForView:self.tableView animated:YES];
			} andExpressNumber:_expressNumber andCompany:_companyDic[_company]];
			_isHtmlOnly = YES;
			break;
		}
	}
	if (!_isHtmlOnly) {
		[DownloadData getJsonDataWithBlock:^(Express *data, NSError *error) {
			_express = data;
			[_express setCompanyName:_company];
			_dataArray = [data expressData];
			if ([data.status isEqualToString:@"1"]) {
				[[SearchHistory sharedInstance] addHistoryRecord:_express];
			}
			[[self tableView] reloadData];
			[MBProgressHUD hideHUDForView:self.tableView animated:YES];
		} andExpressNumber:_expressNumber andCompany:_companyDic[_company]];
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
    return _dataArray.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	ResultTableViewCell *cell = nil;
	if (indexPath.row == 0) {
		cell = [[self tableView] dequeueReusableCellWithIdentifier:@"InfoCell"];
		[cell refreshCellWithType:expressInfo andData:nil orExpress:_express];
	} else {
		ExpressData *data = _dataArray[indexPath.row - 1];
		cell = [[self tableView] dequeueReusableCellWithIdentifier:@"DataCell"];
		[cell refreshCellWithType:expressData andData:data orExpress:nil];
	}
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 80;
}

@end
