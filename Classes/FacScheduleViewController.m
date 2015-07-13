//
//  FacScheduleViewController.m
//  CSUN
//
//  Created by Deeksha Prabhakar on 12/2/11.
//  Copyright 2011 CSUN. All rights reserved.
//

#import "FacScheduleViewController.h"


@implementation FacScheduleViewController
@synthesize curFacultyObj,classSchArray,offHoursArray;

#pragma mark -
#pragma mark Initialization

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithStyle:UITableViewStyleGrouped];
	
    return self;
}

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	classSchArray = [[NSMutableArray alloc]init];
	classSchArray = curFacultyObj.facClassSchArray;
	
	offHoursArray = [[NSMutableArray alloc]init];
	offHoursArray = curFacultyObj.facOfficeHoursArray;
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
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
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	if (section == 0) {
		return offHoursArray.count;	
	}
	else {
		return classSchArray.count;
	}

    return 0;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if (section == 0) {
		NSString *title = @"Office Hours";
		return title;	
	}
	else {
		NSString *title = @"Class Schedule";
		return title;	

	}
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
	if (indexPath.section == 0) {
		CGRect offDaysNumberRect = CGRectMake(5, 5, 155, 20);
		UILabel *offDaysLabel = [[UILabel alloc] initWithFrame:offDaysNumberRect];
		offDaysLabel.textAlignment = UITextAlignmentLeft;	
		offDaysLabel.font = [UIFont systemFontOfSize:12];
		
		CGRect offTimeTextRect = CGRectMake(160, 5, 105, 20);
		UILabel *offTimeText = [[UILabel alloc] initWithFrame:offTimeTextRect];
		offTimeText.textAlignment = UITextAlignmentLeft;
		offTimeText.font = [UIFont systemFontOfSize:12];
		
		FacofficeHours *fac = [[FacofficeHours alloc]init];
		fac = [offHoursArray objectAtIndex:indexPath.row];
		
		offDaysLabel.text = fac.Days;
		
		offTimeText.text = fac.Time;
		
		[cell.contentView addSubview:offDaysLabel];
		[offDaysLabel release];
		
		[cell.contentView addSubview:offTimeText];
		[offTimeText release];
		offDaysLabel.lineBreakMode = UILineBreakModeWordWrap;
	}
	else 
	{
		CGRect catlgNumberRect = CGRectMake(5, 5, 55, 20);
		UILabel *catlNumberLabel = [[UILabel alloc] initWithFrame:catlgNumberRect];
		catlNumberLabel.textAlignment = UITextAlignmentLeft;	
		catlNumberLabel.font = [UIFont systemFontOfSize:12];
		
		CGRect daysTextRect = CGRectMake(60, 5, 55, 20);
		UILabel *daysText = [[UILabel alloc] initWithFrame:daysTextRect];
		daysText.textAlignment = UITextAlignmentLeft;
		daysText.font = [UIFont systemFontOfSize:12];
		
		CGRect timeTextRect = CGRectMake(115, 5, 120, 20);
		UILabel *timeText = [[UILabel alloc] initWithFrame:timeTextRect];
		timeText.textAlignment = UITextAlignmentLeft;
		timeText.font = [UIFont systemFontOfSize:12];
		
		CGRect locTextRect = CGRectMake(235, 5, 55, 20);
		UILabel *locText = [[UILabel alloc] initWithFrame:locTextRect];
		locText.textAlignment = UITextAlignmentLeft;
		locText.font = [UIFont systemFontOfSize:12];
		FacultySchedule *fac = [[FacultySchedule alloc]init];
		fac = [classSchArray objectAtIndex:indexPath.row];
	
		catlNumberLabel.text = fac.CatlgNbr;
		daysText.text = fac.Days;
		timeText.text = fac.Time;
		locText.text = fac.Room;
		
		[cell.contentView addSubview:catlNumberLabel];
		[catlNumberLabel release];
		
		[cell.contentView addSubview:daysText];
		[daysText release];
		
		[cell.contentView addSubview:timeText];
		[timeText release];
		
		[cell.contentView addSubview:locText];
		[locText release];
	}
	
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    /*
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    */
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
	[curFacultyObj release];
	classSchArray = nil;
	offHoursArray = nil;
}


@end

