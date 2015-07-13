//
//  Parking.h
//  CSUN
//
//  Created by Deeksha Prabhakar on 11/27/11.
//  Copyright 2011 CSUN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "CSUNAppDelegate.h"
#import "httpRequest.h"

@interface ParkingInformation : NSObject
{
	NSString *title;
	NSString *text;
	NSInteger parkInfoId;
}

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *text;
@property (nonatomic, readonly) NSInteger parkInfoId;


//Static methods.
+ (void) getParkingInfoToDisplay:(NSString *)dbPath : (Parking *)parObj;
//Instance methods.
- (id) initWithPrimaryKey:(NSInteger)pk;

@end

@interface ParkingPoint : NSObject
{
	NSString *latitude;
	NSString *longitude;
}

@property (nonatomic, retain) NSString *latitude;
@property (nonatomic, retain) NSString *longitude;

@end

@class ParkingPoint,ParkingInformation;

@interface Parking : NSObject {	
	NSInteger pID;
	NSString *Name;
	NSString *noOfCo;
	NSMutableArray *polygonCoordinates;
	NSMutableArray *parkInfoArray;
}

@property (nonatomic, readonly) NSInteger pID;
@property (nonatomic, retain) NSString *Name;
@property (nonatomic, retain) NSString *noOfCo;
@property (nonatomic, retain) NSMutableArray *polygonCoordinates;
@property (nonatomic, retain) NSMutableArray *parkInfoArray;

//Static methods.
+ (void) getStudentLots:(NSString *)dbPath;
+ (void) getFacultyLots:(NSString *)dbPath;
+ (void) finalizeStatements;

-(void) didReceiveData :(NSString *)jsonString;
//Instance methods.
- (id) initPrimaryKey:(NSInteger)pk;

@end
