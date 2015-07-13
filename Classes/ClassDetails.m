//
//  ClassDetails.m
//  CSUN
//
//  Created by Deeksha Prabhakar on 11/19/11.
//  Copyright 2011 CSUN. All rights reserved.
//

#import "ClassDetails.h"
#import <sqlite3.h>

static sqlite3 *database = nil;


@implementation ClassDetails

@synthesize classNumber, Location, Days,Time,Instructor,ClassId,Section;

#pragma mark -
#pragma mark Database Methods


+ (void) finalizeStatements {
	
	if(database) sqlite3_close(database);
}
- (id) initClassDetailPrimaryKey:(NSInteger) pk {
	
	[super init];
	classNumber = pk;
	
	isDetailViewHydrated = NO;
	
	return self;
}
+ (void) getCurrentClassObjectDetails:(NSString *)dbPath:(ClassInfo *)currentClassObj {
	if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
		
		NSString *qryString = [[NSString alloc]initWithString:@"select classNumber, Location, Days,Time,Instructor,ClassId,Section from ClassDetails c where c.ClassId="];
		
		NSString *classId = [[NSString alloc]init];
		classId = [NSString stringWithFormat:@"%d", currentClassObj.classID ];
		qryString = [qryString stringByAppendingString:classId];
		
		const char *sql =[qryString UTF8String] ;
		sqlite3_stmt *selectstmt;
		if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
			currentClassObj.classDetailsArray = [[NSMutableArray alloc]init];
			while(sqlite3_step(selectstmt) == SQLITE_ROW) {
				
				NSInteger primaryKey = sqlite3_column_int(selectstmt, 0);
				ClassDetails *classDetailsObj = [[ClassDetails alloc] initClassDetailPrimaryKey:primaryKey];
				
				classDetailsObj.Location = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 1)];
				classDetailsObj.Days = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 2)];
				classDetailsObj.Time = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 3)];
				classDetailsObj.Instructor = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 4)];
				classDetailsObj.ClassId = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 5)];
				classDetailsObj.Section = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 6)];
				
				//facultyObj.isDirty = NO;
				
				[currentClassObj.classDetailsArray addObject:classDetailsObj];
				[classDetailsObj release];
			}
		}
	}
	else
		sqlite3_close(database); //Even though the open call failed, close the database connection to release all the memory.
}





#pragma mark -
#pragma mark Memory Management
- (void) dealloc {
	classNumber = nil;
	[Location release];
	[Days release];
	[Time release];
	[Instructor release];
	[ClassId release];
	[Section release];
	[super dealloc];
}

@end
