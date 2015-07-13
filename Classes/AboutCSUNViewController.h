//
//  AboutCSUNViewController.h
//  CSUN
//
//  Created by Deeksha Prabhakar on 11/19/11.
//  Copyright 2011 CSUN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSUNAppDelegate.h"
#import "IntroViewController.h"
#import "InfoViewController.h"
#import "HistoryViewController.h"
#import "PhotosViewController.h"


@interface AboutCSUNViewController : UITableViewController {
	NSArray *controllers;
	NSMutableArray *photoNamesArray;
}

@property (nonatomic, retain) NSArray *controllers;
@property (nonatomic, retain) NSMutableArray *photoNamesArray;

@end
