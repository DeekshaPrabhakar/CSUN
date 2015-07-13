//
//  FacultyDetailViewController.h
//  CSUN
//
//  Created by Deeksha Prabhakar on 8/11/11.
//  Copyright 2011 Rinsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Faculty.h"
#import <QuartzCore/QuartzCore.h>
#import "FacultySchedule.h"
#import "CSUNAppDelegate.h"
#import "FacScheduleViewController.h"
#import "MapPin.h"

@class FacultySchedule,FacofficeHours,MapPin;
@interface FacultyDetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
	NSMutableArray *data;
	MKMapView *mapView;
	
	NSMutableArray *cellLabels;
	NSMutableArray *cellValues;
	
	Faculty *currentFaculty;
}

@property (nonatomic, retain) NSMutableArray *data;
@property (nonatomic, retain) Faculty *currentFaculty;

@property (nonatomic, retain) NSMutableArray *cellLabels;
@property (nonatomic, retain) NSMutableArray *cellValues;
@property (nonatomic, retain) MKMapView *mapView;
-(IBAction)btnClicked:(id)sender;

@end
