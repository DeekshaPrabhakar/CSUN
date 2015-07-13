//
//  defaultViewController.m
//  CSUN
//
//  Created by Deeksha Prabhakar on 3/29/11.
//  Copyright 2011 CSUN. All rights reserved.
//

#import "defaultViewController.h"


@implementation defaultViewController
@synthesize controllers;

- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    style = UITableViewStyleGrouped;
    if (self = [super initWithStyle:style]) {
    }
    return self;
}

-(void)viewDidLoad{
	self.title = @"iCSUN";
	NSArray *array = [[NSArray alloc]initWithObjects:@"About CSUN",@"Faculty Search",@"Class Schedule",@"Parking",nil];
	self.controllers = array;
	[array release];
	[super initWithStyle:UITableViewStyleGrouped];
	[super viewDidLoad];
}

-(void)viewDidUnload {
	self.controllers = nil;
	[super viewDidUnload];
}

-(void)dealloc{
	[controllers release];
	[super dealloc];
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
		//Faculty Search
		AboutCSUNViewController *abvc = [[AboutCSUNViewController alloc]initWithNibName:nil bundle:nil];
		[delegate.navController pushViewController:abvc animated:YES];
	}
	else if (row == 1) {
		//Faculty Search
		FacultyViewController *fsvc = [[FacultyViewController alloc]initWithNibName:nil bundle:nil];
		[delegate.navController pushViewController:fsvc animated:YES];
	}
	else if (row == 2){
		//Class Schedule
		ClassScheduleViewController *csvc = [[ClassScheduleViewController alloc]initWithNibName:nil bundle:nil];
		[delegate.navController pushViewController:csvc animated:YES];
	}
	else if (row == 3){
		//Parking
		ParkingViewController *pvc = [[ParkingViewController alloc]initWithNibName:nil bundle:nil];
		[delegate.navController pushViewController:pvc animated:YES];
	}/*
	else if(row == 4){
		GameViewController *gvc = [[GameViewController alloc]initWithNibName:nil bundle:nil];
		[delegate.navController pushViewController:gvc animated:YES];
	}*/
}
  
@end
