    //
//  ClassScheduleViewController.m
//  CSUN
//
//  Created by Deeksha Prabhakar on 8/7/11.
//  Copyright 2011 CSUN. All rights reserved.
//

#import "ClassScheduleViewController.h"


@implementation ClassScheduleViewController

@synthesize controllers,appDelegate;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

-(IBAction)btnUpdateClassInfoClicked:(id)sender{
	NSString *type = @"Student";
	NSString *post = [NSString stringWithFormat:@"&type=%@",type];
	NSString *url = [NSString stringWithFormat:@"http://deekshaprabhakar.com/getclassinfo.aspx"];
	[appDelegate updateInfo:url :post];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	appDelegate = (CSUNAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	
	self.navigationItem.title = @"Class Schedule";
	NSArray *array = [[NSArray alloc]initWithObjects:@"Browse Classes",@"My Class Schedule",nil];
	self.controllers = array;
	[array release];
	[super initWithStyle:UITableViewStyleGrouped];
	
	//UIBarButtonItem *OfficeHoursBtn = [[UIBarButtonItem alloc]initWithTitle:@"Update Class Info"
	//																  style:UIBarButtonSystemItemDone target:self	action:@selector(btnUpdateClassInfoClicked: )];
	//self.navigationItem.rightBarButtonItem = OfficeHoursBtn;
	
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.controllers count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   	static NSString *DefaultMenuCell = @"DefaultMenuCell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DefaultMenuCell];
	
	if(cell == nil){
		cell = [[[UITableViewCell alloc]
				 initWithStyle:UITableViewCellStyleDefault
				 reuseIdentifier:DefaultMenuCell] autorelease];
	}
	
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

	//Configure the cell
	NSUInteger row = [indexPath row];
	cell.textLabel.text = [controllers objectAtIndex:row];
	//push next controller here to create the next view
	return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
	
	if (row == 0) {
		BrowseClassesViewController *bvc = [[BrowseClassesViewController alloc]initWithNibName:nil bundle:nil];
		[appDelegate.navController pushViewController:bvc animated:YES];
	}
	else if (row == 1) {
		MyClassScheduleViewController *myvc = [[MyClassScheduleViewController alloc]initWithNibName:nil bundle:nil];
		[appDelegate copyDatabaseIfNeeded];
		NSString *databasePath = [appDelegate getDBPath];
		[myClass getMyClasses:databasePath];
		[appDelegate.navController pushViewController:myvc animated:YES];
	}
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	self.controllers = nil;
}

- (void)dealloc {
    [super dealloc];
	[appDelegate release];
	[controllers release];
}


@end
