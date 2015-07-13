//
//  ParkingLotsViewController.h
//  CSUN
//
//  Created by Deeksha Prabhakar on 11/27/11.
//  Copyright 2011 CSUN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Parking.h"
#import "CSUNAppDelegate.h"


#define METERS_PER_MILE = 1609.344

@class ParkingPoint;

@interface ParkingLotsViewController : UIViewController<MKMapViewDelegate> {

	MKMapView *mapView;
	BOOL doneInitialZoom;
	Parking *currParkingObj;
	NSString *usertype;
}

@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) NSString *usertype;

@end
