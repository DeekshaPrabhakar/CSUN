    //
//  FacultyDetailViewController.m
//  CSUN
//
//  Created by Deeksha Prabhakar on 8/11/11.
//  Copyright 2011 Rinsoft. All rights reserved.
//

#import "FacultyDetailViewController.h"


@implementation FacultyDetailViewController

@synthesize data;
@synthesize currentFaculty;
@synthesize cellLabels;
@synthesize cellValues,mapView;

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

-(IBAction) btnClicked:(id)sender {
	FacScheduleViewController *fsvc = [[FacScheduleViewController alloc]initWithNibName:nil bundle:nil];
	fsvc.curFacultyObj = currentFaculty;
	
	CSUNAppDelegate *appDelegate = (CSUNAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[appDelegate.navController pushViewController:fsvc animated:YES];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 210) style:UITableViewStyleGrouped];
	[table setDataSource:self];
	[table setDelegate:self];
	[self.view addSubview:table];
	[table release];
	data = [[NSMutableArray alloc]init];
	//[data addObjectsFromArray:[NSArray arrayWithObjects:@"canada",@"US",@"Australia",@"UK", nil]];
	
	cellLabels = [[NSMutableArray alloc]init];
	cellValues = [[NSMutableArray alloc]init];
	
	[cellLabels addObjectsFromArray:[NSArray arrayWithObjects:@"Dept", @"Web",@"Email",@"Ext",@"Office",nil]];
	[cellValues addObjectsFromArray:[NSArray arrayWithObjects: currentFaculty.Dept, currentFaculty.WebURL, currentFaculty.EmailAddress, currentFaculty.PhoneExt, currentFaculty.OfficeLocation, nil]];
	
	mapView = [[MKMapView alloc]initWithFrame:CGRectMake(0, 210, 320, 245)];
	[self.view insertSubview:mapView atIndex:0];
	[mapView setMapType:MKMapTypeStandard];
	[mapView setZoomEnabled:YES];
	[mapView setScrollEnabled:YES];
	
	CLLocationCoordinate2D zoomLocation;
	zoomLocation.latitude = 34.239588; 
	zoomLocation.longitude = -118.52929;
	double dis = 804.672;
	CLLocationDistance dist = dis;
	
	MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation,dist,dist );
    
	MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:viewRegion];
	[self.mapView setRegion:adjustedRegion animated:YES];
	NSString *cood = currentFaculty.LocCoordinate;
	
	NSArray *arr = [cood componentsSeparatedByString:@";"];
	NSString *lat = [arr objectAtIndex:0];
	NSString *lon = [arr objectAtIndex:1];
	
	MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } }; 
	region.center.latitude = [lat doubleValue]; //34.239588 ;
	region.center.longitude = [lon doubleValue];//-118.52929;
	region.span.longitudeDelta = 0.004f;
	region.span.latitudeDelta = 0.004f;
	[mapView setRegion:region animated:YES]; 
	
	
	MapPin *ann = [[MapPin alloc]init];
	[ann initWithCoordinate:region.center :@"JD"];
	[mapView addAnnotation:ann];
	
	CSUNAppDelegate *appDelegate = (CSUNAppDelegate *)[[UIApplication sharedApplication] delegate];
	[appDelegate copyDatabaseIfNeeded];
	
	NSString *databasePath = [appDelegate getDBPath];
	[FacultySchedule getFacSchedule:databasePath :currentFaculty];
	[FacofficeHours getFacOffHours:databasePath :currentFaculty];
	
	self.navigationItem.title = currentFaculty.Name;
	
	UIBarButtonItem *OfficeHoursBtn = [[UIBarButtonItem alloc]initWithTitle:@"Office Hours"
																	  style:UIBarButtonSystemItemDone target:self	action:@selector(btnClicked: )];
	self.navigationItem.rightBarButtonItem = OfficeHoursBtn;
	[OfficeHoursBtn release];
}

#pragma mark tableview delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
		
		//return [data count];
	return [cellValues count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	
  	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"Cell %i",indexPath.section]];
	
	if (cell == nil) {
		
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:[NSString stringWithFormat:@"Cell %i",indexPath.section]] autorelease];
	}
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
	NSInteger row = indexPath.row;
	//NSInteger sec = indexPath.section;
	
	//cell.textLabel.text = [data objectAtIndex: indexPath.row];
	
	CGRect cellLabelRect = CGRectMake(5, 5, 50, 20);	
	UILabel *cellLabel = [[UILabel alloc] initWithFrame:cellLabelRect];
	cellLabel.textAlignment = UITextAlignmentLeft;
	cellLabel.font = [UIFont boldSystemFontOfSize:14];
	NSString *cellLblStr = [cellLabels objectAtIndex:row];
	cellLblStr = [cellLblStr stringByAppendingFormat:@": "];
	cellLabel.text = cellLblStr;
	
	CGRect cellValRect = CGRectMake(55, 5, 245, 20);	
	UILabel *cellVal = [[UILabel alloc] initWithFrame:cellValRect];
	cellVal.textAlignment = UITextAlignmentLeft;
	cellVal.font = [UIFont systemFontOfSize:12];
	NSString *cellValStr = [cellValues objectAtIndex:row];
	cellVal.text = cellValStr;
		
	[cell.contentView addSubview:cellLabel];
	[cellLabel release];
	
	[cell.contentView addSubview:cellVal];
	[cellVal release];
	
	return cell;
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
	[cellValues release];
	[cellLabels release];
	[mapView release];
	[currentFaculty release];
	[data release];
    [super dealloc];
}


@end
