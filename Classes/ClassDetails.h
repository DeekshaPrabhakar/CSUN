//
//  ClassDetails.h
//  CSUN
//
//  Created by Deeksha Prabhakar on 11/19/11.
//  Copyright 2011 CSUN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSUNAppDelegate.h"
#import "ClassInfo.h"

@class ClassInfo;
@interface ClassDetails : NSObject {
	NSInteger classNumber;
	NSString *Location;
	NSString *Days;
	NSString *Time;
	NSString *Instructor;
	NSString *ClassId;
	NSString *Section;
	ClassInfo *currentClass;
	
	//Intrnal variables to keep track of the state of the object.
	BOOL isDirty;
	BOOL isDetailViewHydrated;
	

}

@property (nonatomic, readwrite) NSInteger classNumber;
@property (nonatomic, retain) NSString *Location;
@property (nonatomic, retain) NSString *Days;
@property (nonatomic, retain) NSString *Time;
@property (nonatomic, retain) NSString *Instructor;
@property (nonatomic, retain) NSString *ClassId;
@property (nonatomic, retain) NSString *Section;
@property (nonatomic, retain) ClassInfo *currentClass;


@property (nonatomic, readwrite) BOOL isDetailViewHydrated;
@property (nonatomic, readonly) BOOL isDirty;

//Static methods.
+ (void) getCurrentClassObjectDetails:(NSString *)dbPath:(ClassInfo *)currentClassObj;//Instance methods.

- (id) initClassDetailPrimaryKey:(NSInteger)pk;

+ (void) finalizeStatements;


@end
