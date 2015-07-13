//
//  MyClassScheduleViewController.h
//  CSUN
//
//  Created by Deeksha Prabhakar on 11/21/11.
//  Copyright 2011 CSUN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSUNAppDelegate.h"
#import "myClass.h"

@class myClass;

@interface MyClassScheduleViewController : UITableViewController<UITableViewDelegate, UITableViewDataSource> {
	myClass *currentClass;
	NSMutableArray *data;
	CSUNAppDelegate *appDelegate;
}

@property (nonatomic, retain) myClass *currentClass;
@property (nonatomic, retain) NSMutableArray *data;

@end
