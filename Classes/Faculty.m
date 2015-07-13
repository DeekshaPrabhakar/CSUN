//
//  Faculty.m
//  CSUN
//
//  Created by Deeksha Prabhakar on 8/14/11.
//  Copyright 2011 CSUN. All rights reserved.
//

#import "Faculty.h"
#import <sqlite3.h>

static sqlite3 *database = nil;

@implementation Faculty

@synthesize facID,Name, Dept, WebURL, SemSchedule, EmailAddress, OfficeLocation, PhoneExt,LocCoordinate,facOfficeHoursArray,facClassSchArray;


#pragma mark -
#pragma mark Database Methods

+ (void) getInitialDataToDisplay:(NSString *)dbPath {
	
	CSUNAppDelegate *appDelegate = (CSUNAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
		
		const char *sql = "select FacId,Name,Dept,Schedule,Web,Email,Ext,OfficeLoc,LocCod from FacultyInfo";
		
		sqlite3_stmt *selectstmt;
		if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
			
			while(sqlite3_step(selectstmt) == SQLITE_ROW) {
				
				NSInteger primaryKey = sqlite3_column_int(selectstmt, 0);
				Faculty *facultyObj = [[Faculty alloc] initWithPrimaryKey:primaryKey];
				
				facultyObj.Name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 1)];
				facultyObj.Dept = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 2)];
				facultyObj.SemSchedule = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 3)];
				facultyObj.WebURL = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 4)];
				facultyObj.EmailAddress = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 5)];
				facultyObj.PhoneExt = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 6)];
				facultyObj.OfficeLocation = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 7)];
				facultyObj.LocCoordinate = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 8)];
				//facultyObj.isDirty = NO;
				
				[appDelegate.FacultyArray addObject:facultyObj];
				[facultyObj release];
			}
		}
	}
	else
		sqlite3_close(database); //Even though the open call failed, close the database connection to release all the memory.
}

- (id) initWithPrimaryKey:(NSInteger) pk {
	
	[super init];
	facID = pk;
	
	isDetailViewHydrated = NO;
	
	return self;
}

+ (void) finalizeStatements {
	
	if(database) sqlite3_close(database);
}

#pragma mark -
#pragma mark Memory Management
- (void) dealloc {
	[facID release];
	[Name release];
	[Dept release];
	[WebURL release];
	[SemSchedule release];
	[EmailAddress release];
	[OfficeLocation release];
	[PhoneExt release];
	facOfficeHoursArray = nil;
	facClassSchArray = nil;
	[super dealloc];
}


@end
