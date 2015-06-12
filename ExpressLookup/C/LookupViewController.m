//
//  LookupViewController.m
//  ExpressLookup
//
//  Created by Kyon on 15/6/1.
//  Copyright (c) 2015年 Kyon Li. All rights reserved.
//

#import "LookupViewController.h"
#import "MXPullDownMenu.h"
#import "ResultTableViewController.h"
#import "DownloadData.h"
#import "UIButton+Bootstrap.h"
#import "Company.h"

@interface LookupViewController () <MXPullDownMenuDelegate>
@property (weak, nonatomic) IBOutlet UIView *companyView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (retain, nonatomic) UIAlertView *alertView;
@property (retain, nonatomic) NSString *companyName;

@end

@implementation LookupViewController

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	CGFloat height = self.view.frame.size.height - _companyView.frame.origin.y - 49 - 8 - _companyView.frame.size.height;
	NSInteger cellNumber = height / 40;
	if ([self.view viewWithTag:500] == nil) {
		MXPullDownMenu *menu = [[MXPullDownMenu alloc] initWithArray:@[[[Singleton sharedInstance] getCompanyNameArray]] selectedColor:[UIColor blackColor] frame:_companyView.frame cellNumber:cellNumber];
		[menu setTag:500];
		[menu setDelegate:self];
		[self.view addSubview:menu];
	}
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	[[self navigationItem] setTitle:@"查询"];
//	[_searchButton bootstrapStyle];
	[_searchButton addAwesomeIcon:FAIconSearch beforeTitle:YES];
	
	_alertView = [[UIAlertView alloc] initWithTitle:@"请选择快递公司" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
}

- (void)PullDownMenu:(MXPullDownMenu *)pullDownMenu didSelectRowAtColumn:(NSInteger)column row:(NSInteger)row {
	Company *com = [[Singleton sharedInstance] getCompanyNameArray][row];
	[self setCompanyName:com.comName];
}

- (IBAction)buttonClicked:(UIButton *)sender {
	NSString *nu = _textField.text;
	if (_companyName == nil) {
		[_alertView show];
	} else {
		ResultTableViewController *resultVC = [[ResultTableViewController alloc] initWithExpressNumber:nu andCompany:_companyName];
		[[self navigationController] pushViewController:resultVC animated:YES];
	}
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	[_textField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
