//
//  ContactTableViewController.m
//  ExpressLookup
//
//  Created by Kyon on 15/6/15.
//  Copyright (c) 2015年 Kyon Li. All rights reserved.
//

#import "ContactTableViewController.h"
#import "PhoneNumberSection.h"
#import "PhoneNumber.h"
#import "PhoneTableViewCell.h"

@interface ContactTableViewController ()
@property (nonatomic, retain) NSArray *phoneSections;
@property (nonatomic, retain) NSArray *dataSource;
@property (nonatomic, retain) UIBarButtonItem *leftButton;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation ContactTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[[self navigationItem] setTitle:@"电话簿"];
	NSString *path = [[NSBundle mainBundle] pathForResource:@"phoneNumber" ofType:@"plist"];
	NSArray *array = [NSArray arrayWithContentsOfFile:path];
	NSMutableArray *tmpArray = [NSMutableArray new];
	for (NSDictionary *dic in array) {
		PhoneNumberSection *section = [[PhoneNumberSection alloc] initWithDic:dic];
		[tmpArray addObject:section];
	}
	[self setPhoneSections:[NSArray arrayWithArray:tmpArray]];
	[self setDataSource:self.phoneSections];
	tmpArray = nil;
	
	_leftButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(leftButtonClicked:)];
	
	UINib *nib = [UINib nibWithNibName:@"PhoneTableViewCell" bundle:nil];
	[[self tableView] registerNib:nib forCellReuseIdentifier:@"PhoneCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [[self.dataSource objectAtIndex:section] phoneCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PhoneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PhoneCell"];
	PhoneNumber *phoneNumber = [[[self.dataSource objectAtIndex:indexPath.section] phoneNumbers] objectAtIndex:indexPath.row];
	[cell refreshCell:phoneNumber];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	PhoneNumberSection *phoneSection = [self.dataSource objectAtIndex:section];
	return phoneSection.section;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
	NSMutableArray *mutableArray = [NSMutableArray new];
	for (PhoneNumberSection *phoneSection in self.dataSource) {
		[mutableArray addObject:phoneSection.section];
	}
	return mutableArray;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 25;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	PhoneTableViewCell *cell = (PhoneTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
	[self makeACall:cell.detailLabel.text];
	[cell setSelected:NO animated:YES];
}

// 拨打电话
- (void)makeACall:(NSString *)phoneNum {
	NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", phoneNum]];
	UIWebView *phoneCallWebView = [[UIWebView alloc] init];
	[phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
}

- (void)leftButtonClicked:(UIBarButtonItem *)sender {
	[[self navigationItem] setLeftBarButtonItem:nil animated:YES];
	[self returnToOriginalData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
	[self returnToOriginalData];
	[searchBar setShowsCancelButton:NO animated:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
	NSMutableArray *arr = [NSMutableArray new];
	for (PhoneNumberSection *phoneSection in self.phoneSections) {
		for (PhoneNumber *phoneNum in phoneSection.phoneNumbers) {
			if ([phoneNum.name rangeOfString:searchBar.text].length != 0) {
				[arr addObject:phoneNum];
			}
		}
	}
	NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"", @"section", arr, @"phoneNumbers", nil];
	PhoneNumberSection *phoneSection = [[PhoneNumberSection alloc] initWithDic:dic];
	[self setDataSource:[NSArray arrayWithObject:phoneSection]];
	[[self tableView] reloadData];
	[[self navigationItem] setLeftBarButtonItem:_leftButton animated:YES];
	[_searchBar resignFirstResponder];
	[searchBar setShowsCancelButton:NO animated:YES];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
	[searchBar setShowsCancelButton:YES animated:YES];
}

- (void)returnToOriginalData {
	[self setDataSource:self.phoneSections];
	[[self tableView] reloadData];
	[_searchBar resignFirstResponder];
}

@end
