//
//  Parking.m
//  CSUN
//
//  Created by Deeksha Prabhakar on 11/27/11.
//  Copyright 2011 CSUN. All rights reserved.
//

#import "Parking.h"
#import <sqlite3.h>

static sqlite3 *database = nil;

@implementation ParkingInformation

@synthesize title,text,parkInfoId;

#pragma mark -
#pragma mark Database Methods

+ (void) getParkingInfoToDisplay:(NSString *)dbPath : (Parking *)parObj {
	
	if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
		
		const char *sql = "select ParkInfoId,title,text from ParkingInfo";
		
		sqlite3_stmt *selectstmt;
		if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
			parObj.parkInfoArray = [[NSMutableArray alloc]init];
			while(sqlite3_step(selectstmt) == SQLITE_ROW) {
				
				NSInteger primaryKey = sqlite3_column_int(selectstmt, 0);
				ParkingInformation *pObj = [[ParkingInformation alloc] initWithPrimaryKey:primaryKey];
				
				pObj.title = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 1)];
				pObj.text = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 2)];
				
				[parObj.parkInfoArray addObject:pObj];
				[pObj release];
			}
		}
	}
	else
		sqlite3_close(database); //Even though the open call failed, close the database connection to release all the memory.
}

- (id) initWithPrimaryKey:(NSInteger) pk {
	
	[super init];
	parkInfoId = pk;
	
	return self;
}

@end


@implementation ParkingPoint
@synthesize latitude, longitude;

#pragma mark -
#pragma mark Memory Management
- (void) dealloc {
	[latitude release];
	[longitude release];
	[super dealloc];
}
@end


@implementation Parking
@synthesize polygonCoordinates, pID, Name,noOfCo,parkInfoArray;

#pragma mark -
#pragma mark Database Methods

+ (void) getStudentLots:(NSString *)dbPath {
	
	CSUNAppDelegate *appDelegate = (CSUNAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
		
		const char *sql = "select PId, Name, NoofCoordinates,Cod1,Cod2,Cod3,Cod4 from StudentParking";
		sqlite3_stmt *selectstmt;
		if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
			
			while(sqlite3_step(selectstmt) == SQLITE_ROW) {
				
				NSInteger primaryKey = sqlite3_column_int(selectstmt, 0);
				Parking *pObj = [[Parking alloc] initPrimaryKey:primaryKey];
				pObj.polygonCoordinates = [[NSMutableArray alloc] init];				
				pObj.Name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 1)];
				pObj.noOfCo = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 2)];
				
				NSInteger count = [pObj.noOfCo intValue];
				for (int i=3; i<count+3; i++) {
					NSString *coord = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, i)];
					NSArray *chunk = [coord componentsSeparatedByString:@","];
					
					ParkingPoint *pp = [[ParkingPoint alloc]init];
					pp.latitude = [chunk objectAtIndex:0];
					pp.longitude = [chunk objectAtIndex:1];
					
					[pObj.polygonCoordinates addObject:pp];
					pp = nil;
				}
				[appDelegate.stdParkArray addObject:pObj];
			}
		}
	}
	else
		sqlite3_close(database); //Even though the open call failed, close the database connection to release all the memory.
}

+ (void) getFacultyLots:(NSString *)dbPath {
	
	CSUNAppDelegate *appDelegate = (CSUNAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
		
		const char *sql = "select PId, Name, NoofCo,Cod1,Cod2,Cod3,Cod4 from FacultyParking";
		sqlite3_stmt *selectstmt;
		if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
			
			while(sqlite3_step(selectstmt) == SQLITE_ROW) {
				
				NSInteger primaryKey = sqlite3_column_int(selectstmt, 0);
				Parking *pObj = [[Parking alloc] initPrimaryKey:primaryKey];
				pObj.polygonCoordinates = [[NSMutableArray alloc] init];
				
				pObj.Name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 1)];
				pObj.noOfCo = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 2)];
				
				NSInteger count = [pObj.noOfCo intValue];
				for (int i=3; i<count+3; i++) {
					NSString *coord = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, i)];
					NSArray *chunk = [coord componentsSeparatedByString:@","];
					
					ParkingPoint *pp = [[ParkingPoint alloc]init];
					pp.latitude = [chunk objectAtIndex:0];
					pp.longitude = [chunk objectAtIndex:1];
					
					[pObj.polygonCoordinates addObject:pp];
					pp = nil;
				}
				[appDelegate.facParkArray addObject:pObj];
			}
		}
	}
	else
		sqlite3_close(database); //Even though the open call failed, close the database connection to release all the memory.
}

- (id) initPrimaryKey:(NSInteger) pk {
	
	[super init];
	pID = pk;
	
	return self;
}

+ (void) finalizeStatements {
	
	if(database) sqlite3_close(database);
}

-(void) didReceiveData:(NSString *)jsonString
{

}

#pragma mark -
#pragma mark Memory Management
- (void) dealloc {
	pID = nil;
	[polygonCoordinates release];
	[Name release];
	[noOfCo release];
	[super dealloc];
}

@end
