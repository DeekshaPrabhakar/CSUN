//
//  myJsonParser.h
//  CSUN
//
//  Created by Deeksha Prabhakar on 12/4/11.
//  Copyright 2011 CSUN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ClassInfo.h"
#import "FacultySchedule.h"

@class ClassInfo,ClassDetails,Parking,Faculty, FacultySchedule,AboutCSUN;

@interface myJsonParser : NSObject {
	NSMutableArray *classInfojObjects;
	NSMutableArray *classDetailsjObjects;
	NSMutableArray *parkingjObjects;
	NSMutableArray *facultyjObjects;
	NSMutableArray *facSchjObjects;
	NSMutableArray *aboutCsunjObjects;
}

@property (nonatomic, retain) NSMutableArray *classInfojObjects;
@property (nonatomic, retain) NSMutableArray *classDetailsjObjects;
@property (nonatomic, retain) NSMutableArray *parkingjObjects;
@property (nonatomic, retain) NSMutableArray *facultyjObjects;
@property (nonatomic, retain) NSMutableArray *facSchjObjects;
@property (nonatomic, retain) NSMutableArray *aboutCsunjObjects;

- (NSMutableArray *) initandParseClassInfo:(NSString *)jsonStr;
- (NSMutableArray *) initandParseClassDetails:(NSString *)jsonStr;
- (NSMutableArray *) initandParseParking:(NSString *)jsonStr;
- (NSMutableArray *) initandParseFaculty:(NSString *)jsonStr;
- (NSMutableArray *) initandParseFacultySchedule:(NSString *)jsonStr;
- (NSMutableArray *) initandParseAboutCSUN:(NSString *)jsonStr;

@end
