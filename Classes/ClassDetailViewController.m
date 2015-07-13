    //
//  ClassDetailViewController.m
//  CSUN
//
//  Created by Deeksha Prabhakar on 11/19/11.
//  Copyright 2011 CSUN. All rights reserved.
//

#import "ClassDetailViewController.h"


@implementation ClassDetailViewController

@synthesize currentClass;
@synthesize data,appDelegate,databasePath;

- (IBAction) saveClassToMySchedule {
	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	NSString *className = [[currentClass.Subject stringByAppendingString:@" "]stringByAppendingString: currentClass.CatlgNbr];	

	self.navigationItem.title = className;
	/*
	UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, 80, 320, 310) style:UITableViewStyleGrouped];
	[table setDataSource:self];
	[table setDelegate:self];
	[self.view addSubview:table];
	[table release];
	*/
	
	
	data = [[NSMutableArray alloc]init];
	data = currentClass.classDetailsArray;
	appDelegate = (CSUNAppDelegate *)[[UIApplication sharedApplication] delegate];
	[appDelegate copyDatabaseIfNeeded];
	databasePath = [appDelegate getDBPath];
	
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
}


- (void)dealloc {
	[currentClass release];
	[databasePath release];
	[appDelegate release];
    [super dealloc];
}


#pragma mark tableview delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [indexPath row] + 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
		return [data count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[[UIView alloc] initWithFrame:CGRectMake(0, 60, 320,40)] autorelease];
	
	CGRect classNumberRect = CGRectMake(5, 5, 55, 20);
	UILabel *classNumberLabel = [[UILabel alloc] initWithFrame:classNumberRect];
	classNumberLabel.textAlignment = UITextAlignmentLeft;	
	classNumberLabel.font = [UIFont systemFontOfSize:12];
	
	CGRect locTextRect = CGRectMake(65, 5, 100, 20);
	UILabel *locText = [[UILabel alloc] initWithFrame:locTextRect];
	locText.textAlignment = UITextAlignmentLeft;
	locText.font = [UIFont systemFontOfSize:12];
	
	CGRect daysTextRect = CGRectMake(125, 5, 60, 20);
	UILabel *daysText = [[UILabel alloc] initWithFrame:daysTextRect];
	daysText.textAlignment = UITextAlignmentLeft;
	daysText.font = [UIFont systemFontOfSize:12];
	
	CGRect timeTextRect = CGRectMake(5, 25, 120, 20);
	UILabel *timeText = [[UILabel alloc] initWithFrame:timeTextRect];
	timeText.textAlignment = UITextAlignmentLeft;
	timeText.font = [UIFont systemFontOfSize:12];
	
	CGRect instrTextRect = CGRectMake(125, 25, 160, 20);
	UILabel *instrText = [[UILabel alloc] initWithFrame:instrTextRect];
	instrText.textAlignment = UITextAlignmentLeft;
	instrText.font = [UIFont systemFontOfSize:12];
	
	classNumberLabel.font = [UIFont boldSystemFontOfSize:12];
	locText.font = [UIFont boldSystemFontOfSize:12];
	daysText.font = [UIFont boldSystemFontOfSize:12];
	timeText.font = [UIFont boldSystemFontOfSize:12];
	instrText.font = [UIFont boldSystemFontOfSize:12];
	classNumberLabel.text = @"Class#: ";
	locText.text = @"Loc";
	daysText.text = @"Days";
	timeText.text = @"Time";
	instrText.text = @"Instructor";
	
	[headerView addSubview:classNumberLabel];
	[classNumberLabel release];
	
	[headerView addSubview:locText];
	[locText release];
	
	[headerView addSubview:daysText];
	[daysText release];
	
	[headerView addSubview:timeText];
	[timeText release];
	
	[headerView addSubview:instrText];
	[instrText release];
	
    return headerView;
	
}

-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	
    return  40.0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	
  	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"Cell %i",indexPath.section]];
	
	if (cell == nil) {
		
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:[NSString stringWithFormat:@"Cell %i",indexPath.section]] autorelease];
	}
	
	UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"UIButtonTypeContactAdd.jpg"]];
	cell.accessoryView = imageView;
	[imageView release];
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
	CGRect classNumberRect = CGRectMake(5, 5, 55, 20);
	UILabel *classNumberLabel = [[UILabel alloc] initWithFrame:classNumberRect];
	classNumberLabel.textAlignment = UITextAlignmentLeft;	
	classNumberLabel.font = [UIFont systemFontOfSize:12];
	
	CGRect locTextRect = CGRectMake(65, 5, 100, 20);
	UILabel *locText = [[UILabel alloc] initWithFrame:locTextRect];
	locText.textAlignment = UITextAlignmentLeft;
	locText.font = [UIFont systemFontOfSize:12];
	
	CGRect daysTextRect = CGRectMake(125, 5, 60, 20);
	UILabel *daysText = [[UILabel alloc] initWithFrame:daysTextRect];
	daysText.textAlignment = UITextAlignmentLeft;
	daysText.font = [UIFont systemFontOfSize:12];
	
	CGRect timeTextRect = CGRectMake(5, 25, 120, 20);
	UILabel *timeText = [[UILabel alloc] initWithFrame:timeTextRect];
	timeText.textAlignment = UITextAlignmentLeft;
	timeText.font = [UIFont systemFontOfSize:12];
	
	CGRect instrTextRect = CGRectMake(125, 25, 160, 20);
	UILabel *instrText = [[UILabel alloc] initWithFrame:instrTextRect];
	instrText.textAlignment = UITextAlignmentLeft;
	instrText.font = [UIFont systemFontOfSize:12];
	
	ClassDetails *cur = [[ClassDetails alloc]init];
	cur = [data objectAtIndex:indexPath.row];

	classNumberLabel.text = [NSString stringWithFormat:@"%d", cur.classNumber];
	locText.text = cur.Location;
	daysText.text = cur.Days;
	timeText.text = cur.Time;
	instrText.text = cur.Instructor;
	
	[cell.contentView addSubview:classNumberLabel];
	[classNumberLabel release];
	
	[cell.contentView addSubview:locText];
	[locText release];
	
	[cell.contentView addSubview:daysText];
	[daysText release];

	[cell.contentView addSubview:timeText];
	[timeText release];

	[cell.contentView addSubview:instrText];
	[instrText release];

	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	ClassInfo *currClass = [[ClassInfo alloc]init];
	currClass = currentClass;
	currClass.currentClassDetails = [data objectAtIndex:indexPath.row];
	[ClassInfo addClass:currClass];
	
}

@end
