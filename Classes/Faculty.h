//
//  Faculty.h
//  CSUN
//
//  Created by Deeksha Prabhakar on 8/14/11.
//  Copyright 2011 CSUN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSUNAppDelegate.h"

@interface Faculty : NSObject {
	NSInteger facID;
	NSString *Name;
	NSString *Dept;
	NSString *WebURL;
	NSString *SemSchedule;
	NSString *EmailAddress;
	NSString *OfficeLocation;
	NSString *PhoneExt;
	NSString *LocCoordinate;
	
	NSMutableArray *facOfficeHoursArray;
	NSMutableArray *facClassSchArray;
	
	//Intrnal variables to keep track of the state of the object.
	BOOL isDirty;
	BOOL isDetailViewHydrated;
}

@property (nonatomic, readonly) NSInteger facID;
@property (nonatomic, retain) NSString *Name;
@property (nonatomic, retain) NSString *Dept;
@property (nonatomic, retain) NSString *WebURL;
@property (nonatomic, retain) NSString *SemSchedule;
@property (nonatomic, retain) NSString *EmailAddress;
@property (nonatomic, retain) NSString *OfficeLocation;
@property (nonatomic, retain) NSString *PhoneExt;
@property (nonatomic, retain) NSString *LocCoordinate;

@property (nonatomic, retain) NSMutableArray *facOfficeHoursArray;
@property (nonatomic, retain) NSMutableArray *facClassSchArray;

@property (nonatomic, readwrite) BOOL isDetailViewHydrated;
@property (nonatomic, readonly) BOOL isDirty;
//Static methods.
+ (void) getInitialDataToDisplay:(NSString *)dbPath;
+ (void) finalizeStatements;

//Instance methods.
- (id) initWithPrimaryKey:(NSInteger)pk;

@end
