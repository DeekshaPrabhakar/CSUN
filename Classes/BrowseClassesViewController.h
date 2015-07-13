//
//  BrowseClassesViewController.h
//  CSUN
//
//  Created by Deeksha Prabhakar on 11/21/11.
//  Copyright 2011 CSUN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSUNAppDelegate.h"
#import "ClassDetails.h"
#import "ClassInfo.h"
#import "ClassDetailViewController.h"

@class ClassDetails;

@interface BrowseClassesViewController : UITableViewController {
	CSUNAppDelegate *appDelegate;
	ClassDetails *currentClassDetailsObj;
}

@property (nonatomic, retain) ClassDetails *currentClassDetailsObj;
@end