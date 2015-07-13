//
//  ClassDetailViewController.h
//  CSUN
//
//  Created by Deeksha Prabhakar on 11/19/11.
//  Copyright 2011 CSUN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassInfo.h"
#import "ClassDetails.h"
#import "CSUNAppDelegate.h"

@class ClassInfo,ClassDetails;
@interface ClassDetailViewController : UITableViewController{
	ClassInfo *currentClass;
	IBOutlet UIButton *saveClass;
	NSMutableArray *data;
	CSUNAppDelegate *appDelegate;
	NSString *databasePath;
}

@property (nonatomic, retain) ClassInfo *currentClass;
@property (nonatomic, retain) IBOutlet UIButton *saveClass;
@property (nonatomic, retain) NSMutableArray *data;
@property (nonatomic, retain) CSUNAppDelegate *appDelegate;
@property (nonatomic, retain) NSString *databasePath;


- (IBAction) saveClassToMySchedule;

@end
