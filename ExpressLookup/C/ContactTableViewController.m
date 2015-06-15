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
@property (nonatomic) NSMutableArray *phoneSections;

@end

@implementation ContactTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[[self navigationItem] setTitle:@"电话簿"];
	NSString *path = [[NSBundle mainBundle] pathForResource:@"phoneNumber" ofType:@"plist"];
	NSArray *array = [NSArray arrayWithContentsOfFile:path];
	_phoneSections = [NSMutableArray new];
	for (NSDictionary *dic in array) {
		PhoneNumberSection *section = [[PhoneNumberSection alloc] initWithDic:dic];
		[_phoneSections addObject:section];
	}
	
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
    return _phoneSections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [[_phoneSections objectAtIndex:section] phoneCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PhoneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PhoneCell"];
	PhoneNumber *phoneNumber = [[[_phoneSections objectAtIndex:indexPath.section] phoneNumbers] objectAtIndex:indexPath.row];
	[cell refreshCell:phoneNumber];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	PhoneNumberSection *phoneSection = [_phoneSections objectAtIndex:section];
	return phoneSection.section;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
	NSMutableArray *mutableArray = [NSMutableArray new];
	for (PhoneNumberSection *phoneSection in _phoneSections) {
		[mutableArray addObject:phoneSection.section];
	}
	return mutableArray;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 25;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	[self makeACall:cell.detailTextLabel.text];
	[cell setSelected:NO animated:YES];
}

// 拨打电话
- (void)makeACall:(NSString *)phoneNum {
	NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", phoneNum]];
	UIWebView *phoneCallWebView = [[UIWebView alloc] init];
	[phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
}

@end
