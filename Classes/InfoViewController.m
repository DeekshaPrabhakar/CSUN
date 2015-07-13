//
//  InfoViewController.m
//  CSUN
//
//  Created by Deeksha Prabhakar on 11/21/11.
//  Copyright 2011 CSUN. All rights reserved.
//

#import "InfoViewController.h"


@implementation InfoViewController

@synthesize contacts;

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


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

    CSUNAppDelegate *delegate = (CSUNAppDelegate *)[UIApplication sharedApplication].delegate;
	AboutCSUN *abtObj = [[AboutCSUN alloc] init];
	abtObj = delegate.aboutObj;
	contacts = abtObj.contactsArray;
	
	//[self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
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
		return 1;
	}
	else {
		return [self.contacts count];
	}
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	//Configure the cell
	NSUInteger section = [indexPath section];
	CGRect labelRect = CGRectMake(5, 5, 320, 20);
	UILabel *titleLabel = [[UILabel alloc] initWithFrame:labelRect];
	titleLabel.textAlignment = UITextAlignmentLeft;	
	titleLabel.font = [UIFont systemFontOfSize:12];
	
	CGRect TextRect = CGRectMake(5, 25, 320, 20);
	UILabel *Text = [[UILabel alloc] initWithFrame:TextRect];
	Text.textAlignment = UITextAlignmentLeft;
	Text.font = [UIFont systemFontOfSize:12];
	
	if(section == 0)
	{
		CSUNAppDelegate *delegate = (CSUNAppDelegate *)[UIApplication sharedApplication].delegate;
		AboutCSUN *abtObj = [[AboutCSUN alloc] init];
		abtObj = delegate.aboutObj;
		
		titleLabel.text = @"Address";
		Text.text = abtObj.Address;
	}
	else 
	{
		Contacts *cObj = [contacts objectAtIndex:indexPath.row];
		titleLabel.text = cObj.contactName;
		Text.text = cObj.contactPhone;
	}
	
	[cell.contentView addSubview:titleLabel];
	[titleLabel release];
	
	[cell.contentView addSubview:Text];
	[Text release];
	

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
	[contacts release];
}


@end

