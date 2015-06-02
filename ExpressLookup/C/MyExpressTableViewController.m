//
//  MyExpressTableViewController.m
//  ExpressLookup
//
//  Created by Kyon on 15/6/2.
//  Copyright (c) 2015年 Kyon Li. All rights reserved.
//

#import "MyExpressTableViewController.h"
#import "ResultTableViewCell.h"
#import "Express.h"
#import "SearchHistory.h"

@interface MyExpressTableViewController ()
{
	NSArray *_historyArray;
}
@end

@implementation MyExpressTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[[self navigationItem] setTitle:@"历史记录"];
	
	UINib *nib = [UINib nibWithNibName:@"ExpressInfoTableViewCell" bundle:nil];
	[[self tableView] registerNib:nib forCellReuseIdentifier:@"HistoryCell"];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	_historyArray = [[SearchHistory sharedInstance] getHistoryRecord];
	[[self tableView] reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _historyArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	ResultTableViewCell *cell = [[self tableView] dequeueReusableCellWithIdentifier:@"HistoryCell"];
	Express *express = _historyArray[indexPath.row];
	[cell refreshCellWithType:expressInfo andData:nil orExpress:express];
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 80;
}

@end
