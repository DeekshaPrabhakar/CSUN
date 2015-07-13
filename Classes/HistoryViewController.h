//
//  HistoryViewController.h
//  CSUN
//
//  Created by Deeksha Prabhakar on 11/21/11.
//  Copyright 2011 CSUN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSUNAppDelegate.h"
#import "AboutCSUN.h"

@interface HistoryViewController : UITableViewController {
	NSMutableArray *controllers;
}

@property (nonatomic, retain) NSMutableArray *controllers;

@end
