//
//  AboutCSUN.h
//  CSUN
//
//  Created by Deeksha Prabhakar on 11/21/11.
//  Copyright 2011 CSUN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CSUNAppDelegate.h"

@interface History : NSObject
{
	NSString *title;
	NSString *text;
	NSInteger historyId;
}

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *text;
@property (nonatomic, readonly) NSInteger historyId;


//Static methods.
+ (void) getHistoryToDisplay:(NSString *)dbPath : (AboutCSUN *)abtObj;
//Instance methods.
- (id) initWithPrimaryKey:(NSInteger)pk;

@end

@interface Contacts : NSObject
{
	NSString *contactName;
	NSString *contactPhone;
	NSString *contactFax;
	NSInteger contactId;
}

@property (nonatomic, retain) NSString *contactName;
@property (nonatomic, retain) NSString *contactPhone;
@property (nonatomic, retain) NSString *contactFax;
@property (nonatomic, readonly) NSInteger contactId;


//Static methods.
+ (void) getContactsToDisplay:(NSString *)dbPath:(AboutCSUN *)abtObj;
//Instance methods.
- (id) initWithPrimaryKey:(NSInteger)pk;


@end


@class Contacts,History;

@interface AboutCSUN : NSObject {
	NSMutableArray *contactsArray;
	NSString *IntroText;
	NSString *Address;
	NSMutableArray *historyArray;
	NSInteger aboutId;
}

@property (nonatomic, retain) NSMutableArray *contactsArray;
@property (nonatomic, retain) NSString *IntroText;
@property (nonatomic, retain) NSString *Address;
@property (nonatomic, retain) NSMutableArray *historyArray;
@property (nonatomic, readonly) NSInteger aboutId;

//Static methods.
+ (void) getIntroAddressToDisplay:(NSString *)dbPath;
+ (void) finalizeStatements;

//Instance methods.
- (id) initWithPrimaryKey:(NSInteger)pk;

@end
