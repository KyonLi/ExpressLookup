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

@interface LookupViewController () <MXPullDownMenuDelegate>
{
	NSArray *_companyArray;
	NSString *_companyName;
}
@property (weak, nonatomic) IBOutlet UIView *companyView;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation LookupViewController

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	NSArray *companyArray = @[_companyArray];
	MXPullDownMenu *menu = [[MXPullDownMenu alloc] initWithArray:companyArray selectedColor:[UIColor blueColor]];
	[menu setDelegate:self];
	[menu setFrame:CGRectMake(0, _companyView.frame.origin.y, self.view.frame.size.width, _companyView.frame.size.height)];
	[self.view addSubview:menu];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	[[self navigationItem] setTitle:@"查询"];
	
	NSString *arrayPath = [[NSBundle mainBundle] pathForResource:@"companyArray" ofType:@"txt"];
	_companyArray = [NSArray arrayWithContentsOfFile:arrayPath];
}

- (void)PullDownMenu:(MXPullDownMenu *)pullDownMenu didSelectRowAtColumn:(NSInteger)column row:(NSInteger)row {
	_companyName = _companyArray[row];
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
