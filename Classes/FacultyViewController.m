//
//  FacultyViewController.m
//  CSUN
//
//  Created by Deeksha Prabhakar on 8/13/11.
//  Copyright 2011 CSUN. All rights reserved.
//

#import "FacultyViewController.h"


@implementation FacultyViewController

@synthesize facultyList;
@synthesize facultyListCopy;

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

-(IBAction)btnUpdateFacultyInfoClicked:(id)sender{
	NSString *type = @"Student";
	NSString *post = [NSString stringWithFormat:@"&type=%@",type];
	NSString *url = [NSString stringWithFormat:@"http://deekshaprabhakar.com/getfacclassSchedule.aspx"];
	[appDelegate updateInfo:url :post];
}


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	
	appDelegate = (CSUNAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	facultyList = [[NSMutableArray alloc] initWithObjects:@"Iceland", @"Greenland", @"Switzerland", @"Norway", @"New Zealand", @"Greece", @"Rome", @"Ireland", nil];
	
	
	//Initialize the copy array.
	facultyListCopy = [[NSMutableArray alloc] init];
	
	//Set the title
	self.navigationItem.title = @"Faculty";
	
	UIBarButtonItem *OfficeHoursBtn = [[UIBarButtonItem alloc]initWithTitle:@"Update Faculty Info"
									   																  style:UIBarButtonSystemItemDone target:self	action:@selector(btnUpdateFacultyInfoClicked: )];
	self.navigationItem.rightBarButtonItem = OfficeHoursBtn;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    //return [facultyList count];
	return [appDelegate.FacultyArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"Cell %i",indexPath.section]];
	
	if (cell == nil) {
		
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:[NSString stringWithFormat:@"Cell %i",indexPath.section]] autorelease];
	}
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

	
	NSInteger row = indexPath.row;
	//Get the object from the array.
	Faculty *facObj = [appDelegate.FacultyArray objectAtIndex:indexPath.row];
	
	cell.textLabel.text = facObj.Name;
	//cell.textLabel.text = [facultyList objectAtIndex: row];
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
	NSUInteger row = [indexPath row];
	Faculty *facObj = [appDelegate.FacultyArray objectAtIndex:row];
	
	//Faculty Search
	FacultyDetailViewController *fsvc = [[FacultyDetailViewController alloc]initWithNibName:@"FacultyDetailView" bundle:nil];
	fsvc.currentFaculty = facObj;
	[appDelegate.navController pushViewController:fsvc animated:YES];
	
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
	[appDelegate release];
	[facultyList release];
	[facultyListCopy release];
    [super dealloc];
}


@end

