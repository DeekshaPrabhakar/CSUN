//
//  defaultViewController.h
//  CSUN
//
//  Created by Deeksha Prabhakar on 3/29/11.
//  Copyright 2011 CSUN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CSUNAppDelegate.h"
#import "AboutCSUNViewController.h"
#import "ClassScheduleViewController.h"
#import "ParkingViewController.h"
#import "FacultyViewController.h"
#import "GameViewController.h"

@interface defaultViewController : UITableViewController {
	NSArray *controllers;
}

@property (nonatomic, retain) NSArray *controllers;

@end
