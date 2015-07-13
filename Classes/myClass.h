//
//  myClass.h
//  CSUN
//
//  Created by Deeksha Prabhakar on 12/7/11.
//  Copyright 2011 CSUN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSUNAppDelegate.h"

@interface myClass : NSObject {
	NSInteger myClassId;	
	NSString *Subject;
	NSString *CatlgNbr;
	NSString *classNumber;
	NSString *Location;
	NSString *Days;
	NSString *Time;
	NSString *Instructor;
	NSString *ClassId;
	NSString *Title;
}

@property (nonatomic, readwrite) NSInteger myClassId;
@property (nonatomic, retain) NSString *Subject;
@property (nonatomic, retain) NSString *CatlgNbr;
@property (nonatomic, retain) NSString *classNumber;
@property (nonatomic, retain) NSString *Location;
@property (nonatomic, retain) NSString *Days;
@property (nonatomic, retain) NSString *Time;
@property (nonatomic, retain) NSString *Instructor;
@property (nonatomic, retain) NSString *ClassId;
@property (nonatomic, retain) NSString *Title;

- (id) initmyClassPrimaryKey:(NSInteger) pk ;
+ (void) finalizeStatements;
+ (void) getMyClasses:(NSString *)dbPath;



@end
