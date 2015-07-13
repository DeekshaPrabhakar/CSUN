    //
//  AboutCSUNViewController.m
//  CSUN
//
//  Created by Deeksha Prabhakar on 11/19/11.
//  Copyright 2011 CSUN. All rights reserved.
//

#import "AboutCSUNViewController.h"


@implementation AboutCSUNViewController
@synthesize controllers,photoNamesArray;

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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"About CSUN";
	NSArray *array = [[NSArray alloc]initWithObjects:@"Intro",@"History",@"Info",@"Photos",nil];
	self.controllers = array;
	[array release];
	
	[super initWithStyle:UITableViewStyleGrouped];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
	self.photoNamesArray = nil;
}


- (void)dealloc {
    [super dealloc];
	[controllers release];
	[photoNamesArray release];
}

#pragma mark -
#pragma mark Table Data Source Methods
-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section{
	return [self.controllers count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView
		cellForRowAtIndexPath:(NSIndexPath *)indexPath {
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
#pragma mark Table View Delegate Methods

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSUInteger row = [indexPath row];
	CSUNAppDelegate *delegate = (CSUNAppDelegate *)[UIApplication sharedApplication].delegate;

	if (row == 0) {
		IntroViewController *introvc = [[IntroViewController alloc]initWithNibName:nil bundle:nil];
		[delegate.navController pushViewController:introvc animated:YES];
	}
	else if (row == 1) {
		HistoryViewController *hvc = [[HistoryViewController alloc]initWithNibName:nil bundle:nil];
		[delegate.navController pushViewController:hvc animated:YES];
	}
	else if (row == 2){
		InfoViewController *infovc = [[InfoViewController alloc]initWithNibName:nil bundle:nil];
		[delegate.navController pushViewController:infovc animated:YES];
	}
	else if (row == 3){
		PhotosViewController *pvc = [[PhotosViewController alloc]initWithNibName:@"Photos" bundle:nil];
		[delegate.navController pushViewController:pvc animated:YES];
	}
}


@end
