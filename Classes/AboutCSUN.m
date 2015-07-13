//
//  AboutCSUN.m
//  CSUN
//
//  Created by Deeksha Prabhakar on 11/21/11.
//  Copyright 2011 CSUN. All rights reserved.
//

#import "AboutCSUN.h"
#import <sqlite3.h>

static sqlite3 *database = nil;

@implementation History

@synthesize title,text,historyId;

#pragma mark -
#pragma mark Database Methods

+ (void) getHistoryToDisplay:(NSString *)dbPath:(AboutCSUN *)abtObj {
	
	CSUNAppDelegate *appDelegate = (CSUNAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
		
		const char *sql = "select historyId,title,text from history";
		
		sqlite3_stmt *selectstmt;
		if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
			
			while(sqlite3_step(selectstmt) == SQLITE_ROW) {
				
				NSInteger primaryKey = sqlite3_column_int(selectstmt, 0);
				History *hObj = [[History alloc] initWithPrimaryKey:primaryKey];
				
				hObj.title = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 1)];
				hObj.text = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 2)];
				
				[abtObj.historyArray addObject:hObj];
				[hObj release];
			}
		}
	}
	else
		sqlite3_close(database); //Even though the open call failed, close the database connection to release all the memory.
}

- (id) initWithPrimaryKey:(NSInteger) pk {
	
	[super init];
	historyId = pk;
	
	return self;
}

@end

@implementation Contacts

@synthesize contactName,contactPhone,contactId,contactFax;


#pragma mark -
#pragma mark Database Methods

+ (void) getContactsToDisplay:(NSString *)dbPath:(AboutCSUN *)abtObj {
	
	CSUNAppDelegate *appDelegate = (CSUNAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
		
		const char *sql = "select contactid,Name,Phone,Fax from contacts";
		
		sqlite3_stmt *selectstmt;
		if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
			
			while(sqlite3_step(selectstmt) == SQLITE_ROW) {
				
				NSInteger primaryKey = sqlite3_column_int(selectstmt, 0);
				Contacts *ctObj = [[Contacts alloc] initWithPrimaryKey:primaryKey];
				
				ctObj.contactName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 1)];
				ctObj.contactPhone = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 2)];
				ctObj.contactFax = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 3)];
				
				[abtObj.contactsArray addObject:ctObj];
				
				[ctObj release];
			}
		}
	}
	else
		sqlite3_close(database); //Even though the open call failed, close the database connection to release all the memory.
}

- (id) initWithPrimaryKey:(NSInteger) pk {
	
	[super init];
	contactId = pk;
	
	return self;
}

@end

@implementation AboutCSUN

@synthesize contactsArray,historyArray,IntroText,Address,aboutId;

#pragma mark -
#pragma mark Database Methods

+ (void) getIntroAddressToDisplay:(NSString *)dbPath {
	
	CSUNAppDelegate *appDelegate = (CSUNAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
		
		const char *sql = "select aboutId,IntroText,Address from aboutCSUN";
		
		sqlite3_stmt *selectstmt;
		if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
			
			while(sqlite3_step(selectstmt) == SQLITE_ROW) {
				
				NSInteger primaryKey = sqlite3_column_int(selectstmt, 0);
				AboutCSUN *abObj = [[AboutCSUN alloc] initWithPrimaryKey:primaryKey];
				
				abObj.IntroText = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 1)];
				abObj.Address = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 2)];
				
				abObj.contactsArray = [[NSMutableArray alloc] init];
				abObj.historyArray = [[NSMutableArray alloc] init];
				
				appDelegate.aboutObj = abObj;
				[abObj release];
			}
		}
	}
	else
		sqlite3_close(database); //Even though the open call failed, close the database connection to release all the memory.
}

- (id) initWithPrimaryKey:(NSInteger) pk {
	
	[super init];
	aboutId = pk;

	return self;
}

+ (void) finalizeStatements {
	
	if(database) sqlite3_close(database);
}


@end
