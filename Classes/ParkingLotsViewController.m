    //
//  ParkingLotsViewController.m
//  CSUN
//
//  Created by Deeksha Prabhakar on 11/27/11.
//  Copyright 2011 CSUN. All rights reserved.
//

#import "ParkingLotsViewController.h"


@implementation ParkingLotsViewController
@synthesize mapView,usertype;

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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

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

-(MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay{
	if([overlay isKindOfClass:[MKPolygon class]]){
		MKPolygonView *view = [[[MKPolygonView alloc] initWithOverlay:overlay] autorelease];
		view.lineWidth=1;
		view.strokeColor=[UIColor blueColor];
		view.fillColor=[[UIColor blueColor] colorWithAlphaComponent:0.5];
		return view;
	}
	return nil;
}

- (void)addomapoverlay:(NSMutableArray *)arr {
	Parking *pObj = [[Parking alloc] init];
	ParkingPoint *ppObj = [[ParkingPoint alloc]init];
	ParkingPoint *pppObj = [[ParkingPoint alloc]init];
	ParkingPoint *pptObj = [[ParkingPoint alloc]init];
	ParkingPoint *ppzObj = [[ParkingPoint alloc]init];
	
	for (int k=0; k<arr.count; k++) {
		pObj = [arr objectAtIndex:k];	
		
		ppObj = [pObj.polygonCoordinates objectAtIndex:0];		
		CLLocationCoordinate2D topLeft;
		topLeft.latitude = [ppObj.latitude doubleValue];
		topLeft.longitude = [ppObj.longitude doubleValue];
		
		
		pppObj = [pObj.polygonCoordinates objectAtIndex:1];		
		CLLocationCoordinate2D topRight;
		topRight.latitude = [pppObj.latitude doubleValue];
		topRight.longitude = [pppObj.longitude doubleValue];
		
		
		pptObj = [pObj.polygonCoordinates objectAtIndex:2];
		
		CLLocationCoordinate2D botRight;
		botRight.latitude = [pptObj.latitude doubleValue];
		botRight.longitude = [pptObj.longitude doubleValue];
		
		
		ppzObj = [pObj.polygonCoordinates objectAtIndex:3];
		
		CLLocationCoordinate2D botLeft;
		botLeft.latitude = [ppzObj.latitude doubleValue];
		botLeft.longitude = [ppzObj.longitude doubleValue];
		
		CLLocationCoordinate2D commuterLotCoords[5]={topLeft,topRight,botLeft,botRight, topLeft};
		
		MKPolygon *commuterPoly1 = [MKPolygon polygonWithCoordinates:commuterLotCoords count:5];
		[self.mapView addOverlay:commuterPoly1];
		[commuterPoly1 release];	
	}
	
	[pObj release];
	[ppObj release];
	[ppzObj release];
	[pptObj release];
	[pppObj release];
	
}


- (void) viewWillAppear:(BOOL)animated {
	CLLocationCoordinate2D zoomLocation;
	zoomLocation.latitude = 34.239588; 
	zoomLocation.longitude = -118.52929;
	double dis = 804.672;
	CLLocationDistance dist = dis;
	
	MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation,dist,dist );
    
	MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:viewRegion];
	[self.mapView setRegion:adjustedRegion animated:YES];
	
	CSUNAppDelegate *delegate = (CSUNAppDelegate *)[UIApplication sharedApplication].delegate;
	
	if(self.usertype == @"Faculty")
	{
		for (int k=0; k<delegate.facParkArray.count; k++) {
			Parking *pObj = [[Parking alloc] init];
			pObj = [delegate.facParkArray objectAtIndex:k];	
			
			ParkingPoint *ppObj = [[ParkingPoint alloc]init];
			ppObj = [pObj.polygonCoordinates objectAtIndex:0];		
			CLLocationCoordinate2D topLeft;
			topLeft.latitude = [ppObj.latitude doubleValue];
			topLeft.longitude = [ppObj.longitude doubleValue];
			
			ParkingPoint *pppObj = [[ParkingPoint alloc]init];
			pppObj = [pObj.polygonCoordinates objectAtIndex:1];		
			CLLocationCoordinate2D topRight;
			topRight.latitude = [pppObj.latitude doubleValue];
			topRight.longitude = [pppObj.longitude doubleValue];
			
			ParkingPoint *pptObj = [[ParkingPoint alloc]init];
			pptObj = [pObj.polygonCoordinates objectAtIndex:2];
			
			CLLocationCoordinate2D botRight;
			botRight.latitude = [pptObj.latitude doubleValue];
			botRight.longitude = [pptObj.longitude doubleValue];
			
			ParkingPoint *ppzObj = [[ParkingPoint alloc]init];
			ppzObj = [pObj.polygonCoordinates objectAtIndex:3];
			
			CLLocationCoordinate2D botLeft;
			botLeft.latitude = [ppzObj.latitude doubleValue];
			botLeft.longitude = [ppzObj.longitude doubleValue];
			
			CLLocationCoordinate2D commuterLotCoords[5]={topLeft,topRight,botLeft,botRight, topLeft};
			
			MKPolygon *commuterPoly1 = [MKPolygon polygonWithCoordinates:commuterLotCoords count:5];
			[self.mapView addOverlay:commuterPoly1];
			[commuterPoly1 release];
			[ppObj release];
			[ppzObj release];
			[pptObj release];
			[pppObj release];
		}
	}
	else
	{
		NSMutableArray *test = [[NSMutableArray alloc]init];
		test = delegate.stdParkArray;
		[self addomapoverlay:test];
		[test release];
	}

		
	/*
	CLLocationCoordinate2D topLeftG3;//34.238734,-118.525572
	topLeftG3.latitude = 34.238734;
	topLeftG3.longitude = -118.525572;
	 //tlFacLotB4 = 34.240449,-118.533533
	 //tr = 34.240476,-118.532499
	 //br = 34.239412,-118.532515
	 //bl = 34.239434,-118.533545
	 
	 //tlfaclotb2 = 34.237219,-118.533596;
	 //tr = 34.237263,-118.532003
	 //br = 34.236487,-118.531949
	 //bl = 34.236487,-118.533617
	 
	 //tlfaclotb5 = 34.242577,-118.53316
	 //tr = 34.242593,-118.532135
	 //br = 34.242049,-118.533248
	 //bl = 34.242027,-118.532012
	 
	 //tlfacd6 = 34.244434,-118.530241
	 //tr = 34.244426,-118.529018
	 //br = 34.242945,-118.528975
	 //bl = 34.242989,-118.529265
	 
	 //tlfacg4 = 34.240952,-118.524842
	 //tr = 34.241036,-118.523684
	 //br = 34.240486,-118.524939
	 //bl = 34.240486,-118.523582
	 
	 //tlStdB1lot = 34.236419,-118.533401
	 //tr = 34.236384,-118.531993
	 //br = 34.23575,-118.533511
	 //bl = 34.235763,-118.532079
	 
	 //tlStdB3ps = 34.238894,-118.53268
	 //tr = 34.238867,-118.531988
	 //br = 34.237581,-118.532787
	 //bl = 34.237493,-118.531966
	 
	 //tlStdB5PS = 34.242043,-118.533511
	 //tr = 34.242083,-118.532031
	 //br = 34.24136,-118.533624
	 //bl = 34.241236,-118.532031
	 
	 //tlStdb6lot = 34.244353,-118.532712
	 tr = 34.244269,-118.531988
	 br = 34.243027,-118.532755
	 bl = 34.24293,-118.532036
	 
	 //tlstdE6Lot = 34.24442,-118.528796
	 tr = 34.244411,-118.528206
	 br = 34.243129,-118.528844
	 bl = 34.243125,-118.528275
	 
	 //tlStdG4Lot = 34.240952,-118.524896
	 tr = 34.241023,-118.523619
	 br = 34.239958,-118.524885
	 bl = 34.239958,-118.523544
	 
	 //tlStdF10Lot = 34.251727,-118.52716
	 tr = 34.251736,-118.525765
	 br = 34.250308,-118.527052
	 bl = 34.250406,-118.525743
	 
	 //tlstdG10 = 34.251528,-118.52404
	 tr = 34.251543,-118.52367
	 br = 34.250785,-118.524193
	 bl = 34.25067,-118.52367
	 
	 //tlstdG9PS = 34.249127,-118.524287
	 tr = 34.249147,-118.52359
	 br = 34.248712,-118.52433
	 bl = 34.248712,-118.52359
	
	CLLocationCoordinate2D topRightG3;//34.238814,-118.524746
	topRightG3.latitude = 34.238814;
	topRightG3.longitude = -118.524746;
	
	CLLocationCoordinate2D botLeftG3;//34.237484,-118.525551
	botLeftG3.latitude = 34.237484;
	botLeftG3.longitude = -118.525551;
	
	CLLocationCoordinate2D botRightG3;//34.23751,-118.524703
	botRightG3.latitude = 34.23751;
	botRightG3.longitude = -118.524703;
	
	CLLocationCoordinate2D commuterLotCoords[5]={topLeftG3,topRightG3,botRightG3,botLeftG3, topLeftG3
	};
	
	MKPolygon *commuterPoly1 = [MKPolygon polygonWithCoordinates:commuterLotCoords count:5];
	[self.mapView addOverlay:commuterPoly1];
	[commuterPoly1 release];
	
	
	CLLocationCoordinate2D topLeftG3PS;//34.238961,-118.524559
	topLeftG3PS.latitude = 34.238961;
	topLeftG3PS.longitude = -118.524559;
	
	CLLocationCoordinate2D topRightG3PS;//34.238978,-118.523411
	topRightG3PS.latitude = 34.238978;
	topRightG3PS.longitude = -118.523411;
	
	CLLocationCoordinate2D botLeftG3PS;//34.237328,-118.52458
	botLeftG3PS.latitude = 34.237328;
	botLeftG3PS.longitude = -118.52458;
	
	CLLocationCoordinate2D botRightG3PS;//34.23732,-118.523346
	botRightG3PS.latitude = 34.23732;
	botRightG3PS.longitude = -118.523346;	
	
	CLLocationCoordinate2D G3PSLotCoords[5]={topLeftG3PS,topRightG3PS,botRightG3PS,botLeftG3PS, topLeftG3PS
	};
	
	MKPolygon *G3PSPoly1 = [MKPolygon polygonWithCoordinates:G3PSLotCoords count:5];
	[self.mapView addOverlay:G3PSPoly1];
	[G3PSPoly1 release];
	
	CLLocationCoordinate2D topLeftE5lot;//34.242367,-118.528603
	topLeftE5lot.latitude = 34.242367;
	topLeftE5lot.longitude = -118.528603;
	
	CLLocationCoordinate2D topRightE5lot;//34.242403,-118.527648
	topRightE5lot.latitude = 34.242403;
	topRightE5lot.longitude = -118.527648;
	
	CLLocationCoordinate2D botLeftE5lot;//34.241099,-118.527626
	botLeftE5lot.latitude = 34.241099;
	botLeftE5lot.longitude = -118.527626;
	
	CLLocationCoordinate2D botRightE5lot;//34.241117,-118.527787
	botRightE5lot.latitude = 34.241117;
	botRightE5lot.longitude = -118.527787;*/
	/*
	CLLocationCoordinate2D midLeftE5lot;//34.242181,-118.528656
	botLeftE5lot.latitude = 34.242367;
	botLeftE5lot.longitude = -118.528656;
	
	CLLocationCoordinate2D midRightE5lot;//34.242092,-118.527798
	botRightE5lot.latitude = 34.242367;
	botRightE5lot.longitude = -118.527798;*/
	
/*	CLLocationCoordinate2D E5LotCoords[5]={topLeftE5lot,topRightE5lot,botLeftE5lot,botRightE5lot, topLeftE5lot
	};
	
	MKPolygon *E5lotPoly1 = [MKPolygon polygonWithCoordinates:E5LotCoords count:5];
	[self.mapView addOverlay:E5lotPoly1];
	[E5lotPoly1 release];*/
	
	
}


- (void)dealloc {
	[mapView release];
	[usertype release];
    [super dealloc];
}


@end
