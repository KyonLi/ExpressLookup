//
//  LookupViewController.m
//  ExpressLookup
//
//  Created by Kyon on 15/6/1.
//  Copyright (c) 2015年 Kyon Li. All rights reserved.
//

#import "LookupViewController.h"
#import "MXPullDownMenu.h"

@interface LookupViewController () <MXPullDownMenuDelegate>
{
	NSArray *_companyArray;
}
@property (weak, nonatomic) IBOutlet UIView *companyView;

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
	
	NSString *path = [[NSBundle mainBundle] pathForResource:@"companyArray" ofType:@"txt"];
	_companyArray = [NSArray arrayWithContentsOfFile:path];
	
}

- (void)PullDownMenu:(MXPullDownMenu *)pullDownMenu didSelectRowAtColumn:(NSInteger)column row:(NSInteger)row {
	NSLog(@"%@", _companyArray[row]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
