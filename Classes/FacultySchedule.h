//
//  FacultySchedule.h
//  CSUN
//
//  Created by Deeksha Prabhakar on 12/2/11.
//  Copyright 2011 CSUN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSUNAppDelegate.h"
#import "Faculty.h"

@class Faculty;
@interface FacultySchedule : NSObject {
	NSInteger FacClassScheId;
	NSInteger FacId;
	NSString *CatlgNbr;
	NSString *Days;
	NSString *Time;
	NSString *Room;
}

@property (nonatomic, readwrite) NSInteger FacClassScheId;
@property (nonatomic, readwrite) NSInteger FacId;
@property (nonatomic, retain) NSString *CatlgNbr;
@property (nonatomic, retain) NSString *Days;
@property (nonatomic, retain) NSString *Time;
@property (nonatomic, retain) NSString *Room;

//Static methods.
+ (void) getFacSchedule:(NSString *)dbPath:(Faculty *)currentFacObj;
+ (void) finalizeStatements;
+ (void) deleteFacSch:(NSString *)dbPath;
+ (void) insertFacSchData:(FacultySchedule *)currObj:(NSString *)dbPath;

//Instance methods.
- (id) initWithPrimaryKey:(NSInteger)pk;

@end


@interface FacofficeHours : NSObject
{
	NSInteger FacOffId;
	NSInteger FacId;
	NSString *Days;
	NSString *Time;
}

@property (nonatomic, readwrite) NSInteger FacOffId;
@property (nonatomic, readwrite) NSInteger FacId;
@property (nonatomic, retain) NSString *Days;
@property (nonatomic, retain) NSString *Time;

//Static methods.
+ (void) getFacOffHours:(NSString *)dbPath:(Faculty *)currentFacObj;
+ (void) finalizeStatements;

//Instance methods.
- (id) initWithPrimaryKey:(NSInteger)pk;


@end
