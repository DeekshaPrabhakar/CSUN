//
//  ParkingViewController.h
//  CSUN
//
//  Created by Deeksha Prabhakar on 8/7/11.
//  Copyright 2011 CSUN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSUNAppDelegate.h"
#import "ParkingInfoViewController.h"
#import "ParkingLotsViewController.h"

@class Parking;

@interface ParkingViewController : UITableViewController {
	NSArray *controllers;
	Parking *currentParkingObj;
}

@property (nonatomic, retain) Parking *currentParkingObj;;
@property (nonatomic, retain) NSArray *controllers;

@end
