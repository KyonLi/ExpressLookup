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

@interface LookupViewController () <MXPullDownMenuDelegate>
{
	NSString *_companyName;
}
@property (weak, nonatomic) IBOutlet UIView *companyView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;

@end

@implementation LookupViewController

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	CGFloat height = self.view.frame.size.height - _companyView.frame.origin.y - 49 - 8 - _companyView.frame.size.height;
	NSInteger cellNumber = height / 40;
	MXPullDownMenu *menu = [[MXPullDownMenu alloc] initWithArray:@[[[Singleton sharedInstance] getCompanyNameArray]] selectedColor:[UIColor blackColor] frame:_companyView.frame cellNumber:cellNumber];
	[menu setDelegate:self];
	[self.view addSubview:menu];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	[[self navigationItem] setTitle:@"查询"];
//	[_searchButton bootstrapStyle];
	[_searchButton addAwesomeIcon:FAIconSearch beforeTitle:YES];
}

- (void)PullDownMenu:(MXPullDownMenu *)pullDownMenu didSelectRowAtColumn:(NSInteger)column row:(NSInteger)row {
	_companyName = [[Singleton sharedInstance] getCompanyNameArray][row];
}

- (IBAction)buttonClicked:(UIButton *)sender {
	NSString *nu = _textField.text;
	ResultTableViewController *resultVC = [[ResultTableViewController alloc] initWithExpressNumber:nu andCompany:_companyName];
	[[self navigationController] pushViewController:resultVC animated:YES];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	[_textField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
