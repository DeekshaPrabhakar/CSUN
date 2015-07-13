//
//  ClassInfo.h
//  CSUN
//
//  Created by Deeksha Prabhakar on 11/19/11.
//  Copyright 2011 CSUN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSUNAppDelegate.h"
#import "ClassDetails.h"

@class ClassDetails;
@interface ClassInfo : NSObject {
	NSInteger classID;
	NSString *Title;
	NSString *Subject;
	NSString *CatlgNbr;
	NSString *Units;
	NSMutableArray *classDetailsArray;
	
	ClassDetails *currentClassDetails;
	NSInteger myClassId;
	
	//Intrnal variables to keep track of the state of the object.
	BOOL isDirty;
	BOOL isDetailViewHydrated;
}

@property (nonatomic, readwrite) NSInteger classID;

@property (nonatomic, retain) NSString *Title;
@property (nonatomic, retain) NSString *Subject;
@property (nonatomic, retain) NSString *CatlgNbr;
@property (nonatomic, retain) NSString *Units;

@property (nonatomic, retain) ClassDetails *currentClassDetails;
@property (nonatomic,readonly) NSInteger myClassId;

@property (nonatomic, retain) NSMutableArray *classDetailsArray;

@property (nonatomic, readwrite) BOOL isDetailViewHydrated;
@property (nonatomic, readonly) BOOL isDirty;

//Static methods.
+ (void) getDataToDisplay:(NSString *)dbPath;
+ (void) finalizeStatements;

+ (void) addClass:(ClassInfo *)currClass;
- (id) initmyClassPrimaryKey:(NSInteger) pk;

+ (void) insertClassInfoData:(ClassInfo *)currClass ;
+ (void) resetPrimaryKey:(NSInteger) key;

//Instance methods.
- (id) initPrimaryKey:(NSInteger)pk;

+ (void) deleteClassInfo;
+ (void) deleteClassInfoSeq;

@end