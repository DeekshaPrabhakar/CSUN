//
//  FacScheduleViewController.h
//  CSUN
//
//  Created by Deeksha Prabhakar on 12/2/11.
//  Copyright 2011 CSUN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Faculty.h"
#import "FacultySchedule.h"

@interface FacScheduleViewController : UITableViewController {
	Faculty *curFacultyObj;
	NSMutableArray *classSchArray;
	NSMutableArray *offHoursArray;
}

@property (nonatomic,retain) Faculty *curFacultyObj;
@property (nonatomic, retain) NSMutableArray *classSchArray;
@property (nonatomic, retain) NSMutableArray *offHoursArray;

@end
