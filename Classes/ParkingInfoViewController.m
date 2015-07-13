    //
//  ParkingInfoViewController.m
//  CSUN
//
//  Created by Deeksha Prabhakar on 11/27/11.
//  Copyright 2011 CSUN. All rights reserved.
//

#import "ParkingInfoViewController.h"


@implementation ParkingInfoViewController

@synthesize controllers;

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
	CSUNAppDelegate *appDelegate = (CSUNAppDelegate *)[[UIApplication sharedApplication] delegate];
	self.navigationItem.title = @"Parking Info";
	controllers = [[NSMutableArray alloc]init];
	Parking *parkObj = appDelegate.parkObj;
	//[self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
	controllers = parkObj.parkInfoArray;
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
    return [self.controllers count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 1;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	ParkingInformation *pObj = [[ParkingInformation alloc]init];
	pObj = [self.controllers objectAtIndex:section];
	return pObj.title;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	ParkingInformation *pObj = [[ParkingInformation alloc]init];
	pObj = [self.controllers objectAtIndex:indexPath.section];
	
	NSString *cellText = pObj.text;
    UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:17.0];
    CGSize constraintSize = CGSizeMake(280.0f, MAXFLOAT);
    CGSize labelSize = [cellText sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
	
    return labelSize.height + 20;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   	static NSString *DefaultMenuCell = @"DefaultMenuCell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DefaultMenuCell];
	
	if(cell == nil){
		cell = [[[UITableViewCell alloc]
				 initWithStyle:UITableViewCellStyleDefault
				 reuseIdentifier:DefaultMenuCell] autorelease];
		cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
		cell.textLabel.numberOfLines = 0;
		cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0];
	}
	
	
	//Configure the cell
	NSUInteger row = [indexPath section];
	ParkingInformation *pObj = [controllers objectAtIndex:row];
	cell.textLabel.text = pObj.text;
	//push next controller here to create the next view
	return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
	[controllers release];
}


@end
