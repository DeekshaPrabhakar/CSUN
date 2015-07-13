//
//  ClassScheduleViewController.h
//  CSUN
//
//  Created by Deeksha Prabhakar on 8/7/11.
//  Copyright 2011 CSUN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSUNAppDelegate.h"
#import "BrowseClassesViewController.h"
#import "MyClassScheduleViewController.h"
#import "ClassInfo.h"
#import "ClassDetails.h"
#import "myClass.h"

@class ClassInfo,ClassDetails,myClass;

@interface ClassScheduleViewController : UITableViewController {
	CSUNAppDelegate *appDelegate;
	NSArray *controllers;
}

@property (nonatomic, retain) NSArray *controllers;
@property (nonatomic, retain) CSUNAppDelegate *appDelegate;
-(IBAction)btnUpdateClassInfoClicked:(id)sender;


@end
