//
//  ParkingInfoViewController.h
//  CSUN
//
//  Created by Deeksha Prabhakar on 11/27/11.
//  Copyright 2011 CSUN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSUNAppDelegate.h"
#import "Parking.h"

@class Parking;
@interface ParkingInfoViewController: UITableViewController {
	NSMutableArray *controllers;
}

@property (nonatomic, retain) NSMutableArray *controllers;

@end
