//
//  ClassInfo.m
//  CSUN
//
//  Created by Deeksha Prabhakar on 11/19/11.
//  Copyright 2011 CSUN. All rights reserved.
//

#import "ClassInfo.h"
#import <sqlite3.h>
#import "httpRequest.h"

static sqlite3 *database = nil;
static sqlite3_stmt *addStmt = nil;
static sqlite3_stmt *deleteStmt = nil;

@implementation ClassInfo
@synthesize classID, Title, Subject, CatlgNbr,classDetailsArray,currentClassDetails,myClassId,Units;

#pragma mark -
#pragma mark Database Methods

+ (void) deleteClassInfo {
	if(deleteStmt == nil) {
		const char *sql = "delete from ClassInfo;UPDATE sqlite_sequence SET seq=1 WHERE name='ClassInfo';";
		if(sqlite3_prepare_v2(database, sql, -1, &deleteStmt, NULL) != SQLITE_OK)
			NSAssert1(0, @"Error while creating delete statement. '%s'", sqlite3_errmsg(database));
	}
	
	if (SQLITE_DONE != sqlite3_step(deleteStmt))
		NSAssert1(0, @"Error while deleting. '%s'", sqlite3_errmsg(database));
	
	//sqlite3_reset(deleteStmt);
	sqlite3_finalize(deleteStmt);
}

+ (void) deleteClassInfoSeq {
	if(deleteStmt == nil) {
		const char *sql = "delete from sqlite_sequence where name='ClassInfo';UPDATE sqlite_sequence SET seq=1 WHERE name='ClassInfo';";
		if(sqlite3_prepare_v2(database, sql, -1, &deleteStmt, NULL) != SQLITE_OK)
			NSAssert1(0, @"Error while creating delete statement. '%s'", sqlite3_errmsg(database));
	}
	
	if (SQLITE_DONE != sqlite3_step(deleteStmt))
		NSAssert1(0, @"Error while deleting. '%s'", sqlite3_errmsg(database));
	sqlite3_finalize(deleteStmt);
	//sqlite3_reset(deleteStmt);
	
}


+ (void) insertClassInfoData:(ClassInfo *)currClass  {
		if(addStmt == nil) {
			const char *sql = "insert into ClassInfo(Title, Subject, CatlgNbr,Units) Values(?, ?, ?, ?)";
			if(sqlite3_prepare_v2(database, sql, -1, &addStmt, NULL) != SQLITE_OK)
				NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
		}
		sqlite3_bind_text(addStmt, 1, [currClass.Title UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(addStmt, 2, [currClass.Subject UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(addStmt, 3, [currClass.CatlgNbr UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(addStmt, 4, [currClass.Units UTF8String], -1, SQLITE_TRANSIENT);
	
		if(SQLITE_DONE != sqlite3_step(addStmt))	
		{
			NSString *err = [[NSString alloc]initWithFormat:@"%s",sqlite3_errmsg(database)]; 
			NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
		}
		else
			//SQLite provides a method to get the last primary key inserted by using sqlite3_last_insert_rowid
			classID = sqlite3_last_insert_rowid(database);
		
		//Reset the add statement.
		sqlite3_reset(addStmt);
	
}

+ (void) resetPrimaryKey:(NSInteger) key{
	sqlite3_reset(addStmt);
}

+ (void) getDataToDisplay:(NSString *)dbPath {
	
	CSUNAppDelegate *appDelegate = (CSUNAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
		
		const char *sql = "select ClassId, Title, Subject,CatlgNbr,Units from ClassInfo";
		sqlite3_stmt *selectstmt;
		appDelegate.ClassesArray = [[NSMutableArray alloc]init];
		if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
			
			while(sqlite3_step(selectstmt) == SQLITE_ROW) {
				
				NSInteger primaryKey = sqlite3_column_int(selectstmt, 0);
				ClassInfo *classObj = [[ClassInfo alloc] initPrimaryKey:primaryKey];
				
				classObj.Title = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 1)];
				classObj.Subject = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 2)];
				classObj.CatlgNbr = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 3)];
				classObj.Units = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 4)];
				classObj.classDetailsArray = [[NSMutableArray alloc] init];
			    [classObj.classDetailsArray release];
				//facultyObj.isDirty = NO;
				
				[appDelegate.ClassesArray addObject:classObj];
				//[classObj release];
			}
		}
	}
	else
		sqlite3_close(database); //Even though the open call failed, close the database connection to release all the memory.
}

- (id) initPrimaryKey:(NSInteger) pk {
	[super init];
	classID = pk;
//	isDetailViewHydrated = NO;
	return self;
}

+ (void) finalizeStatements {
	if(database) sqlite3_close(database);
	if(deleteStmt) sqlite3_finalize(deleteStmt);
	if(addStmt) sqlite3_finalize(addStmt);
}

+ (void) addClass:(ClassInfo *)currClass  {
	if(addStmt == nil) {
		const char *sql = "insert into MyClassSchedule(Subject, CatlgNbr, ClassNumber, Location, Days, Time, Instructor,Title,ClassId) Values(?, ?, ?, ?, ?, ?, ?,?,?)";
		if(sqlite3_prepare_v2(database, sql, -1, &addStmt, NULL) != SQLITE_OK)
			NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
	}
	
	NSInteger i = currClass.currentClassDetails.classNumber;
	NSString *s = [NSString stringWithFormat:@"%d", i];
	
	NSInteger j = currClass.classID;
	NSString *r = [NSString stringWithFormat:@"%d", j];
	
	//sqlite3_bind_int(addStmt, 1, myClassId);
	sqlite3_bind_text(addStmt, 1, [currClass.Subject UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(addStmt, 2, [currClass.CatlgNbr UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(addStmt, 3, [s UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(addStmt, 4, [currClass.currentClassDetails.Location UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(addStmt, 5, [currClass.currentClassDetails.Days UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(addStmt, 6, [currClass.currentClassDetails.Time UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(addStmt, 7, [currClass.currentClassDetails.Instructor UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(addStmt, 8, [currClass.Title UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(addStmt, 9, [r UTF8String], -1, SQLITE_TRANSIENT);
	
	if(SQLITE_DONE != sqlite3_step(addStmt))
	{
		NSString *err = [[NSString alloc]initWithFormat:@"%s",sqlite3_errmsg(database)]; 
		NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
	}
		else
		//SQLite provides a method to get the last primary key inserted by using sqlite3_last_insert_rowid
		myClassId = sqlite3_last_insert_rowid(database);
	
	//Reset the add statement.
	sqlite3_reset(addStmt);
	//[currClass release];
}

- (id) initmyClassPrimaryKey:(NSInteger) pk {
	
	[super init];
	myClassId = pk;
	
	isDetailViewHydrated = NO;
	
	return self;
}

#pragma mark -
#pragma mark Memory Management
- (void) dealloc {
	classID = nil;
	myClassId = nil;
	[currentClassDetails release];
	[classDetailsArray release];
	[Title release];
	[Subject release];
	[CatlgNbr release];
	[Units release];
	[super dealloc];
}

@end
