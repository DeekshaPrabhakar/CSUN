//
//  myClass.m
//  CSUN
//
//  Created by Deeksha Prabhakar on 12/7/11.
//  Copyright 2011 CSUN. All rights reserved.
//

#import "myClass.h"
#import <sqlite3.h>

static sqlite3 *database = nil;

@implementation myClass

@synthesize myClassId, Subject, CatlgNbr, classNumber, Location, Days, Time, Instructor, ClassId, Title;


#pragma mark -
#pragma mark Database Methods

+ (void) finalizeStatements {
	
	if(database) sqlite3_close(database);
}

- (id) initmyClassPrimaryKey:(NSInteger) pk {
	[super init];
	myClassId = pk;
	return self;
}

+ (void) getMyClasses:(NSString *)dbPath {
	
	CSUNAppDelegate *appDelegate = (CSUNAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
		
		const char *sql = "select MyClassId,Title, Subject, CatlgNbr, ClassNumber, Location, Days, Time, Instructor,ClassId from MyClassSchedule";
		sqlite3_stmt *selectstmt;
		appDelegate.myClassesArray = [[NSMutableArray alloc]init];
		if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {			
			while(sqlite3_step(selectstmt) == SQLITE_ROW) {
				
				NSInteger primaryKey = sqlite3_column_int(selectstmt, 0);
				myClass *classObj = [[myClass alloc] initmyClassPrimaryKey:primaryKey];
				
				classObj.Title = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 1)];
				classObj.Subject = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 2)];
				classObj.CatlgNbr = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 3)];
				classObj.classNumber = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 4)];
				classObj.Location = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 5)];
				classObj.Days = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 6)];
				classObj.Time = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 7)];
				classObj.Instructor = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 8)];
				classObj.ClassId = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 9)];
				
				[appDelegate.myClassesArray addObject:classObj];
				[classObj release];
			}
		}
	}
	else
		sqlite3_close(database); //Even though the open call failed, close the database connection to release all the memory.
}

#pragma mark -
#pragma mark Memory Management
- (void) dealloc {
	myClassId = nil;
	[Subject release];
	[CatlgNbr release];
	[classNumber release];
	[Location release];
	[Days release];
	[Time release];
	[Instructor release];
	[ClassId release];
	[Title release];
	[super dealloc];
}


@end
