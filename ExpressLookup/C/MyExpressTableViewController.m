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
#import "ResultTableViewController.h"

@interface MyExpressTableViewController ()
{
	UIBarButtonItem *_rightButtonBegin;
	UIBarButtonItem *_rightButtonFinish;
	UIBarButtonItem *_leftButton;
}
@property (nonatomic, retain) NSArray *historyArray;
@end

@implementation MyExpressTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[[self navigationItem] setTitle:@"历史记录"];
	_rightButtonBegin = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(switchEditMode:)];
	_rightButtonFinish = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(switchEditMode:)];
	_leftButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteSelectedCells:)];
	[[self navigationItem] setRightBarButtonItem:_rightButtonBegin animated:YES];
	
	UINib *nib = [UINib nibWithNibName:@"ExpressInfoTableViewCell" bundle:nil];
	[[self tableView] registerNib:nib forCellReuseIdentifier:@"HistoryCell"];
	
	[[self tableView] setTableFooterView:[UIView new]];
	[[self view] setBackgroundColor:[UIColor redColor]];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self setHistoryArray:[[Singleton sharedInstance] getHistoryRecords]];
	[[self tableView] reloadData];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
	[[self tableView] setEditing:NO];
	[[self navigationItem] setRightBarButtonItem:_rightButtonBegin];
	[[self navigationItem] setLeftBarButtonItem:nil];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if ([tableView isEditing]) {
		[[self navigationItem] setLeftBarButtonItem:_leftButton animated:YES];
	} else {
		Express *express = [_historyArray objectAtIndex:indexPath.row];
		ResultTableViewController *resultVC = [[ResultTableViewController alloc] initWithExpressNumber:express.nu andCompany:express.companyName];
		[[self navigationController] pushViewController:resultVC animated:YES];
	}
}

// 没有选中时移除删除按钮
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSArray *selectedCells = [tableView indexPathsForSelectedRows];
	if (selectedCells.count == 0) {
		[[self navigationItem] setLeftBarButtonItem:nil animated:YES];
	}
}

// 切换编辑模式按钮
- (void)switchEditMode:(UIBarButtonItem *)sender {
	if ([[self tableView] isEditing]) {
		[[self tableView] setEditing:NO animated:YES];
		[[self navigationItem] setRightBarButtonItem:_rightButtonBegin animated:YES];
		[[self navigationItem] setLeftBarButtonItem:nil animated:YES];
	} else {
		[[self tableView] setEditing:YES animated:YES];
		[[self navigationItem] setRightBarButtonItem:_rightButtonFinish animated:YES];
	}
}

// 删除选中项
- (void) deleteSelectedCells:(UIBarButtonItem *)sender {
	NSArray *selectedCells = [[self tableView] indexPathsForSelectedRows];
	for (NSInteger i = 0; i < selectedCells.count; i++) {
		NSIndexPath *path = [selectedCells objectAtIndex:i];
		NSInteger index = path.row;
		[[Singleton sharedInstance] removeHistoryRecordAtIndex:index - i];
	}
	[self setHistoryArray:[[Singleton sharedInstance] getHistoryRecords]];
	[[self tableView] deleteRowsAtIndexPaths:selectedCells withRowAnimation:UITableViewRowAnimationLeft];
	[[self navigationItem] setLeftBarButtonItem:nil animated:YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
	return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}

@end
