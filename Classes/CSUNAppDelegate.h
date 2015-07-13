//
//  CSUNAppDelegate.h
//  CSUN
//
//  Created by Deeksha Prabhakar on 3/29/11.
//  Copyright 2011 CSUN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "httpRequest.h"
#import "myJsonParser.h"

@class Faculty, ClassInfo, AboutCSUN, History, Contacts, Parking, ParkingInformation;

@interface CSUNAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UINavigationController *navController;
	
	NSMutableArray *FacultyArray;
	NSMutableArray *ClassesArray;
	NSMutableArray *myClassesArray;
	
	NSMutableArray *stdParkArray;
	NSMutableArray *facParkArray;
	NSMutableArray *visParkArray;
	
	NSString *webServiceUrl;
	
	AboutCSUN *aboutObj;
	Parking *parkObj;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navController;
@property (nonatomic, retain) NSMutableArray *FacultyArray;
@property (nonatomic, retain) NSMutableArray *ClassesArray;
@property (nonatomic, retain) NSMutableArray *myClassesArray;

@property (nonatomic, retain) NSMutableArray *stdParkArray;
@property (nonatomic, retain) NSMutableArray *facParkArray;
@property (nonatomic, retain) NSMutableArray *visParkArray;
@property (nonatomic, retain) NSString *webServiceUrl;

@property (nonatomic, retain) AboutCSUN *aboutObj;
@property (nonatomic, retain) Parking *parkObj;

- (void) copyDatabaseIfNeeded;
- (NSString *) getDBPath;

- (void) updateInfo:(NSString *)url:(NSString *)post ;

-(void) didReceiveData :(NSString *)jsonString;

@end

