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

@interface ResultTableViewController () <UIAlertViewDelegate>
@property (nonatomic, copy) NSString *expressNumber;
@property (nonatomic, copy) NSString *company;
@property (nonatomic, retain) Express *express;
@property (nonatomic, retain) NSArray *dataArray;
@property (nonatomic, assign) NSInteger infoRowNumber;
@property (nonatomic, retain) UIAlertView *alertView;

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
	
	[[self tableView] setBackgroundColor:[UIColor colorWithRed:0.922 green:0.922 blue:0.945 alpha:1.000]];
	
	MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
	[hud setLabelText:@"查询中，请稍候..."];
	
	static NSString *order = nil;
	if ([[NSUserDefaults standardUserDefaults] boolForKey:@"order"]) {
		order = @"desc";
	} else {
		order = @"asc";
	}
	
	_alertView = [[UIAlertView alloc] initWithTitle:@"哎呀" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
	[[self tableView] addSubview:_alertView];
	
	if ([[Singleton sharedInstance] isHtmlOnly:_company]) {
		[DownloadData getHtmlDataWithBlock:^(Express *data, NSError *error) {
			[self setExpress:data];
			[_express setCompanyName:_company];
			[self setDataArray:data.expressData];
			if ([data.status isEqualToString:@"1"]) {
				[[Singleton sharedInstance] addHistoryRecord:_express];
				_infoRowNumber = 1;
			} else {
				[_alertView setMessage:_express.message];
				[_alertView show];
			}
			[[self tableView] reloadData];
			[MBProgressHUD hideHUDForView:self.tableView animated:YES];
		} andExpressNumber:_expressNumber andCompany:[[Singleton sharedInstance] translateCompanyNameIntoCompanyID:_company] andOrder:order];
	} else {
		[DownloadData getJsonDataWithBlock:^(Express *data, NSError *error) {
			[self setExpress:data];
			[_express setCompanyName:_company];
			[self setDataArray:data.expressData];
			if ([data.status isEqualToString:@"1"]) {
				[[Singleton sharedInstance] addHistoryRecord:_express];
				_infoRowNumber = 1;
			} else {
				[_alertView setMessage:_express.message];
				[_alertView show];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	if (section == 0) {
		return _infoRowNumber;
	} else {
		return _dataArray.count;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	ResultTableViewCell *cell = nil;
	if (indexPath.section == 0) {
		cell = [[self tableView] dequeueReusableCellWithIdentifier:@"InfoCell"];
		[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
		[cell refreshCellWithType:expressInfo Express:_express Index:indexPath.row];
	} else {
		cell = [[self tableView] dequeueReusableCellWithIdentifier:@"DataCell"];
		[cell refreshCellWithType:expressData Express:_express Index:indexPath.row];
	}
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 80;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	[[self navigationController] popViewControllerAnimated:YES];
}

@end
