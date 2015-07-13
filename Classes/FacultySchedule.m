//
//  FacultySchedule.m
//  CSUN
//
//  Created by Deeksha Prabhakar on 12/2/11.
//  Copyright 2011 CSUN. All rights reserved.
//

#import "FacultySchedule.h"
#import <sqlite3.h>

static sqlite3 *database = nil;

static sqlite3_stmt *addStmt = nil;
static sqlite3_stmt *deleteStmt = nil;

@implementation FacultySchedule
@synthesize FacClassScheId,FacId,CatlgNbr,Days,Time,Room;

#pragma mark -
#pragma mark Database Methods

+ (void) deleteFacSch:(NSString *)dbPath {
	if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
	if(deleteStmt == nil) {
		const char *sql = "delete from FacClassSchedule;delete from sqlite_sequence where name='FacClassSchedule';";
		if(sqlite3_prepare_v2(database, sql, -1, &deleteStmt, NULL) != SQLITE_OK)
			NSAssert1(0, @"Error while creating delete statement. '%s'", sqlite3_errmsg(database));
	}
	
	if (SQLITE_DONE != sqlite3_step(deleteStmt))
		NSAssert1(0, @"Error while deleting. '%s'", sqlite3_errmsg(database));
	//sqlite3_finalize(deleteStmt);
	sqlite3_reset(deleteStmt);
	}
	
}


+ (void) insertFacSchData:(FacultySchedule *)currObj:(NSString *)dbPath {
	if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
	if(addStmt == nil) {
		const char *sql = "insert into FacClassSchedule(FacId, CatlgNbr,Days,Time,Room) Values(?, ?, ?,?,?)";
		if(sqlite3_prepare_v2(database, sql, -1, &addStmt, NULL) != SQLITE_OK)
			NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
	}
	sqlite3_bind_int(addStmt, 1, currObj.FacId);
	sqlite3_bind_text(addStmt, 2, [currObj.CatlgNbr UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(addStmt, 3, [currObj.Days UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(addStmt, 4, [currObj.Time UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(addStmt, 5, [currObj.Room UTF8String], -1, SQLITE_TRANSIENT);
	
	if(SQLITE_DONE != sqlite3_step(addStmt))	
	{
		NSString *err = [[NSString alloc]initWithFormat:@"%s",sqlite3_errmsg(database)]; 
		NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
	}
	else
		//SQLite provides a method to get the last primary key inserted by using sqlite3_last_insert_rowid
		FacClassScheId = sqlite3_last_insert_rowid(database);
	
	//Reset the add statement.
	sqlite3_reset(addStmt);
	}
}


+ (void) getFacSchedule:(NSString *)dbPath:(Faculty *)currentFacObj {
	
	CSUNAppDelegate *appDelegate = (CSUNAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
		
		NSString *qryString = [[NSString alloc]initWithString:@"select FcsId, FacId, CatlgNbr,Days,Time,Room from FacClassSchedule c where c.FacId="];
		
		NSString *classId = [[NSString alloc]init];
		classId = [NSString stringWithFormat:@"%d", currentFacObj.facID ];
		qryString = [qryString stringByAppendingString:classId];
		
		const char *sql =[qryString UTF8String] ;
		
		sqlite3_stmt *selectstmt;
		if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
			currentFacObj.facClassSchArray = [[NSMutableArray alloc]init];
			while(sqlite3_step(selectstmt) == SQLITE_ROW) {
				
				NSInteger primaryKey = sqlite3_column_int(selectstmt, 0);
				FacultySchedule *facultySch = [[FacultySchedule alloc] init];//WithPrimaryKey:primaryKey];
				
				facultySch.CatlgNbr = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 2)];
				facultySch.Days = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 3)];
				facultySch.Time = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 4)];
				facultySch.Room = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 5)];
				
				[currentFacObj.facClassSchArray addObject:facultySch];
				[facultySch release];
			}
		}
	}
	else
		sqlite3_close(database); //Even though the open call failed, close the database connection to release all the memory.
}

- (id) initWithPrimaryKey:(NSInteger) pk {
	
	[super init];
	FacClassScheId = pk;
	return self;
}

+ (void) finalizeStatements {
	
	if(database) sqlite3_close(database);
	if(deleteStmt) sqlite3_finalize(deleteStmt);
	if(addStmt) sqlite3_finalize(addStmt);
}

#pragma mark -
#pragma mark Memory Management
- (void) dealloc {
	FacClassScheId = nil;
	FacId = nil;
	[CatlgNbr release];
	[Days release];
	[Time release];
	[Room release];
	[super dealloc];
}

@end

@implementation FacofficeHours
@synthesize FacOffId,FacId,Days,Time;


#pragma mark -
#pragma mark Database Methods


+ (void) getFacOffHours:(NSString *)dbPath:(Faculty *)currentFacObj {
	
	CSUNAppDelegate *appDelegate = (CSUNAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
		
		NSString *qryString = [[NSString alloc]initWithString:@"select FacOffId, FacId,Days,Time from FacOfficeHours c where c.FacId="];
		
		NSString *classId = [[NSString alloc]init];
		classId = [NSString stringWithFormat:@"%d", currentFacObj.facID ];
		qryString = [qryString stringByAppendingString:classId];
		
		const char *sql =[qryString UTF8String] ;
		
		sqlite3_stmt *selectstmt;
		if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
			currentFacObj.facOfficeHoursArray = [[NSMutableArray alloc]init];
			while(sqlite3_step(selectstmt) == SQLITE_ROW) {
				
				NSInteger primaryKey = sqlite3_column_int(selectstmt, 0);
				FacofficeHours *facultyOff = [[FacofficeHours alloc] initWithPrimaryKey:primaryKey];
				
				facultyOff.Days = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 2)];
				facultyOff.Time = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 3)];
				
				[currentFacObj.facOfficeHoursArray addObject:facultyOff];
				[facultyOff release];
			}
		}
	}
	else
		sqlite3_close(database); //Even though the open call failed, close the database connection to release all the memory.
}

- (id) initWithPrimaryKey:(NSInteger) pk {
	
	[super init];
	FacOffId = pk;
	return self;
}

+ (void) finalizeStatements {
	
	if(database) sqlite3_close(database);
}

#pragma mark -
#pragma mark Memory Management
- (void) dealloc {
	FacOffId = nil;
	FacId = nil;
	[Days release];
	[Time release];
	[super dealloc];
}
@end
