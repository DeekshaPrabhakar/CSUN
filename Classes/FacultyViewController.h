//
//  FacultyViewController.h
//  CSUN
//
//  Created by Deeksha Prabhakar on 8/13/11.
//  Copyright 2011 CSUN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSUNAppDelegate.h"
#import "FacultyDetailViewController.h"
#import "Faculty.h"

@interface FacultyViewController : UITableViewController {
	NSMutableArray *facultyList;
	NSMutableArray *facultyListCopy;
	
	CSUNAppDelegate *appDelegate;
}

@property (nonatomic, retain) NSMutableArray *facultyList;
@property (nonatomic, retain) NSMutableArray *facultyListCopy;

@end
