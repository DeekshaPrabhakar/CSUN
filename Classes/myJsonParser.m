//
//  myJsonParser.m
//  CSUN
//
//  Created by Deeksha Prabhakar on 12/4/11.
//  Copyright 2011 CSUN. All rights reserved.
//

#import "myJsonParser.h"


@implementation myJsonParser
@synthesize classInfojObjects,classDetailsjObjects,parkingjObjects,facultyjObjects,facSchjObjects,aboutCsunjObjects;

- (NSMutableArray *) initandParseClassInfo:(NSString *)jsonStr {
	classInfojObjects = [[NSMutableArray alloc]init];
	NSArray *jsonClassObj = [jsonStr componentsSeparatedByString:@"},"];
	
	for (int j=0; j < jsonClassObj.count; j++) {
		NSString *jsStr = [jsonClassObj objectAtIndex:j];
		NSRange openBracket = [jsStr rangeOfString:@"{"];
		NSRange numberRange = NSMakeRange(openBracket.location + 1, [[jsonClassObj objectAtIndex:j] length] - openBracket.location - 1);
		NSString *numberString = [jsStr substringWithRange:numberRange];// full one object
		
		NSArray *classObjArr = [[NSArray alloc]init]; 
		classObjArr = [numberString componentsSeparatedByString:@","];//each property separated by , in one string
		ClassInfo *c = [[ClassInfo alloc]init];
		
		NSArray *cidArr =  [[NSArray alloc] init];
		cidArr = [[classObjArr objectAtIndex:0] componentsSeparatedByString:@":"];
		NSString *cid = [[cidArr objectAtIndex:1] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
		c.classID = [cid integerValue];
		
		NSArray *ctitArr =  [[NSArray alloc] init];
		ctitArr = [[classObjArr objectAtIndex:1] componentsSeparatedByString:@":"];
		c.Title = [[[ctitArr objectAtIndex:1] stringByReplacingOccurrencesOfString:@"\"" withString:@""] stringByReplacingOccurrencesOfString: @"\\" withString: @""] ;
		
		NSArray *csubArr = [[NSArray alloc] init];
		csubArr = [[classObjArr objectAtIndex:2] componentsSeparatedByString:@":"];
		c.Subject = [[[csubArr objectAtIndex:1] stringByReplacingOccurrencesOfString:@"\"" withString:@""] stringByReplacingOccurrencesOfString: @"\\" withString: @""] ;
		
		NSArray *catlgArr =  [[NSArray alloc] init];
		catlgArr = [[classObjArr objectAtIndex:3] componentsSeparatedByString:@":"];
		c.CatlgNbr = [[[catlgArr objectAtIndex:1] stringByReplacingOccurrencesOfString:@"\"" withString:@""] stringByReplacingOccurrencesOfString: @"\\" withString: @""];
		
		NSArray *cunitArr =  [[NSArray alloc] init];
		cunitArr = [[classObjArr objectAtIndex:4] componentsSeparatedByString:@":"];
		c.Units = [[[cunitArr objectAtIndex:1] stringByReplacingOccurrencesOfString:@"\"" withString:@""] stringByReplacingOccurrencesOfString: @"\\" withString: @""];
		
		[classInfojObjects addObject:c];
		[c release];
	}
	return classInfojObjects;
}

- (NSMutableArray *) initandParseClassDetails:(NSString *)jsonStr {
	NSArray *jsonClassObj = [jsonStr componentsSeparatedByString:@"},"];
	
	for (int j=0; j < jsonClassObj.count; j++) {
		NSString *jsStr = [jsonClassObj objectAtIndex:j];
		NSRange openBracket = [jsStr rangeOfString:@"{"];
		NSRange numberRange = NSMakeRange(openBracket.location + 1, [[jsonClassObj objectAtIndex:j] length] - openBracket.location - 1);
		NSString *numberString = [jsStr substringWithRange:numberRange];// full one object
		
		NSArray *classObjArr = [[NSArray alloc]init]; 
		classObjArr = [numberString componentsSeparatedByString:@","];//each property separated by , in one string
		ClassDetails *c = [[ClassDetails alloc]init];
		
		NSArray *cnbArr =  [[NSArray alloc] init];
		cnbArr = [[classObjArr objectAtIndex:0] componentsSeparatedByString:@":"];
		NSString *cnb = [[cnbArr objectAtIndex:1] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
		c.classNumber = [cnb integerValue];
		
		NSArray *ctitArr =  [[NSArray alloc] init];
		ctitArr = [[classObjArr objectAtIndex:1] componentsSeparatedByString:@":"];
		c.Location = [[[ctitArr objectAtIndex:1] stringByReplacingOccurrencesOfString:@"\"" withString:@""] stringByReplacingOccurrencesOfString: @"\\" withString: @""] ;
		
		NSArray *csubArr = [[NSArray alloc] init];
		csubArr = [[classObjArr objectAtIndex:2] componentsSeparatedByString:@":"];
		c.Days = [[[csubArr objectAtIndex:1] stringByReplacingOccurrencesOfString:@"\"" withString:@""] stringByReplacingOccurrencesOfString: @"\\" withString: @""] ;
		
		NSArray *catlgArr =  [[NSArray alloc] init];
		catlgArr = [[classObjArr objectAtIndex:3] componentsSeparatedByString:@":"];
		c.Time = [[[catlgArr objectAtIndex:1] stringByReplacingOccurrencesOfString:@"\"" withString:@""] stringByReplacingOccurrencesOfString: @"\\" withString: @""];
		
		NSArray *cinsArr =  [[NSArray alloc] init];
		cinsArr = [[classObjArr objectAtIndex:4] componentsSeparatedByString:@":"];
		c.Instructor = [[[cinsArr objectAtIndex:1] stringByReplacingOccurrencesOfString:@"\"" withString:@""] stringByReplacingOccurrencesOfString: @"\\" withString: @""];
		
		NSArray *clidArr =  [[NSArray alloc] init];
		clidArr = [[classObjArr objectAtIndex:5] componentsSeparatedByString:@":"];
		c.ClassId = [[clidArr objectAtIndex:1] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
		
		NSArray *csecArr =  [[NSArray alloc] init];
		csecArr = [[classObjArr objectAtIndex:6] componentsSeparatedByString:@":"];
		c.Section = [[[csecArr objectAtIndex:1] stringByReplacingOccurrencesOfString:@"\"" withString:@""] stringByReplacingOccurrencesOfString: @"\\" withString: @""] ;
				
		[classDetailsjObjects addObject:c];
		
		[c release];
	}
	return classDetailsjObjects;
}

- (NSMutableArray *) initandParseParking:(NSString *)jsonStr {
	NSArray *jsonClassObj = [jsonStr componentsSeparatedByString:@"},"];
	
	for (int j=0; j < jsonClassObj.count; j++) {
		NSString *jsStr = [jsonClassObj objectAtIndex:j];
		NSRange openBracket = [jsStr rangeOfString:@"{"];
		NSRange numberRange = NSMakeRange(openBracket.location + 1, [[jsonClassObj objectAtIndex:j] length] - openBracket.location - 1);
		NSString *numberString = [jsStr substringWithRange:numberRange];// full one object
		
		NSArray *classObjArr = [[NSArray alloc]init]; 
		classObjArr = [numberString componentsSeparatedByString:@","];//each property separated by , in one string
		ClassInfo *c = [[ClassInfo alloc]init];
		
		NSArray *cidArr =  [[NSArray alloc] init];
		cidArr = [[classObjArr objectAtIndex:0] componentsSeparatedByString:@":"];
		NSString *cid = [[cidArr objectAtIndex:1] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
		c.classID = [cid integerValue];
		
		NSArray *ctitArr =  [[NSArray alloc] init];
		ctitArr = [[classObjArr objectAtIndex:1] componentsSeparatedByString:@":"];
		c.Title = [[[ctitArr objectAtIndex:1] stringByReplacingOccurrencesOfString:@"\"" withString:@""] stringByReplacingOccurrencesOfString: @"\\" withString: @""] ;
		
		NSArray *csubArr = [[NSArray alloc] init];
		csubArr = [[classObjArr objectAtIndex:2] componentsSeparatedByString:@":"];
		c.Subject = [[[csubArr objectAtIndex:1] stringByReplacingOccurrencesOfString:@"\"" withString:@""] stringByReplacingOccurrencesOfString: @"\\" withString: @""] ;
		
		NSArray *catlgArr =  [[NSArray alloc] init];
		catlgArr = [[classObjArr objectAtIndex:3] componentsSeparatedByString:@":"];
		c.CatlgNbr = [[[catlgArr objectAtIndex:1] stringByReplacingOccurrencesOfString:@"\"" withString:@""] stringByReplacingOccurrencesOfString: @"\\" withString: @""];
		
		[parkingjObjects addObject:c];
		[c release];
	}
	return parkingjObjects;
}

- (NSMutableArray *) initandParseFaculty:(NSString *)jsonStr {
	NSArray *jsonClassObj = [jsonStr componentsSeparatedByString:@"},"];
	
	for (int j=0; j < jsonClassObj.count; j++) {
		NSString *jsStr = [jsonClassObj objectAtIndex:j];
		NSRange openBracket = [jsStr rangeOfString:@"{"];
		NSRange numberRange = NSMakeRange(openBracket.location + 1, [[jsonClassObj objectAtIndex:j] length] - openBracket.location - 1);
		NSString *numberString = [jsStr substringWithRange:numberRange];// full one object
		
		NSArray *classObjArr = [[NSArray alloc]init]; 
		classObjArr = [numberString componentsSeparatedByString:@","];//each property separated by , in one string
		ClassInfo *c = [[ClassInfo alloc]init];
		
		NSArray *cidArr =  [[NSArray alloc] init];
		cidArr = [[classObjArr objectAtIndex:0] componentsSeparatedByString:@":"];
		NSString *cid = [[cidArr objectAtIndex:1] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
		c.classID = [cid integerValue];
		
		NSArray *ctitArr =  [[NSArray alloc] init];
		ctitArr = [[classObjArr objectAtIndex:1] componentsSeparatedByString:@":"];
		c.Title = [[[ctitArr objectAtIndex:1] stringByReplacingOccurrencesOfString:@"\"" withString:@""] stringByReplacingOccurrencesOfString: @"\\" withString: @""] ;
		
		NSArray *csubArr = [[NSArray alloc] init];
		csubArr = [[classObjArr objectAtIndex:2] componentsSeparatedByString:@":"];
		c.Subject = [[[csubArr objectAtIndex:1] stringByReplacingOccurrencesOfString:@"\"" withString:@""] stringByReplacingOccurrencesOfString: @"\\" withString: @""] ;
		
		NSArray *catlgArr =  [[NSArray alloc] init];
		catlgArr = [[classObjArr objectAtIndex:3] componentsSeparatedByString:@":"];
		c.CatlgNbr = [[[catlgArr objectAtIndex:1] stringByReplacingOccurrencesOfString:@"\"" withString:@""] stringByReplacingOccurrencesOfString: @"\\" withString: @""];
		
		[facultyjObjects addObject:c];
		[c release];
	}
	return facultyjObjects;
}

- (NSMutableArray *) initandParseFacultySchedule:(NSString *)jsonStr {
	NSArray *jsonClassObj = [jsonStr componentsSeparatedByString:@"},"];
	facSchjObjects = [[NSMutableArray alloc]init];
	for (int j=0; j < jsonClassObj.count; j++) {
		NSString *jsStr = [jsonClassObj objectAtIndex:j];
		NSRange openBracket = [jsStr rangeOfString:@"{"];
		NSRange numberRange = NSMakeRange(openBracket.location + 1, [[jsonClassObj objectAtIndex:j] length] - openBracket.location - 1);
		NSString *numberString = [jsStr substringWithRange:numberRange];// full one object
		
		NSArray *classObjArr = [[NSArray alloc]init]; 
		classObjArr = [numberString componentsSeparatedByString:@","];//each property separated by , in one string
		FacultySchedule *c = [[FacultySchedule alloc]init];
		
		NSArray *cidArr =  [[NSArray alloc] init];
		cidArr = [[classObjArr objectAtIndex:0] componentsSeparatedByString:@":"];
		NSString *cid = [[cidArr objectAtIndex:1] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
		c.FacClassScheId = [cid integerValue];
		
		NSArray *ctitArr =  [[NSArray alloc] init];
		ctitArr = [[classObjArr objectAtIndex:1] componentsSeparatedByString:@":"];
		NSString *cfid = [[ctitArr objectAtIndex:1] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
		c.FacId = [cfid integerValue];
		
		NSArray *csubArr = [[NSArray alloc] init];
		csubArr = [[classObjArr objectAtIndex:2] componentsSeparatedByString:@":"];
		c.CatlgNbr = [[[csubArr objectAtIndex:1] stringByReplacingOccurrencesOfString:@"\"" withString:@""] stringByReplacingOccurrencesOfString: @"\\" withString: @""] ;
		
		NSArray *catlgArr =  [[NSArray alloc] init];
		catlgArr = [[classObjArr objectAtIndex:3] componentsSeparatedByString:@":"];
		c.Days = [[[catlgArr objectAtIndex:1] stringByReplacingOccurrencesOfString:@"\"" withString:@""] stringByReplacingOccurrencesOfString: @"\\" withString: @""];
		
		NSArray *ctimeArr =  [[NSArray alloc] init];
		ctimeArr = [[classObjArr objectAtIndex:4] componentsSeparatedByString:@":"];
		c.Time = [[[ctimeArr objectAtIndex:1] stringByReplacingOccurrencesOfString:@"\"" withString:@""] stringByReplacingOccurrencesOfString: @"\\" withString: @""];
		
		NSArray *croomArr =  [[NSArray alloc] init];
		croomArr = [[classObjArr objectAtIndex:5] componentsSeparatedByString:@":"];
		c.Room = [[[croomArr objectAtIndex:1] stringByReplacingOccurrencesOfString:@"\"" withString:@""] stringByReplacingOccurrencesOfString: @"\\" withString: @""];
		
		[facSchjObjects addObject:c];
		[c release];
	}
	return facSchjObjects;
}

- (NSMutableArray *) initandParseAboutCSUN:(NSString *)jsonStr {
	NSArray *jsonClassObj = [jsonStr componentsSeparatedByString:@"},"];
	
	for (int j=0; j < jsonClassObj.count; j++) {
		NSString *jsStr = [jsonClassObj objectAtIndex:j];
		NSRange openBracket = [jsStr rangeOfString:@"{"];
		NSRange numberRange = NSMakeRange(openBracket.location + 1, [[jsonClassObj objectAtIndex:j] length] - openBracket.location - 1);
		NSString *numberString = [jsStr substringWithRange:numberRange];// full one object
		
		NSArray *classObjArr = [[NSArray alloc]init]; 
		classObjArr = [numberString componentsSeparatedByString:@","];//each property separated by , in one string
		ClassInfo *c = [[ClassInfo alloc]init];
		
		NSArray *cidArr =  [[NSArray alloc] init];
		cidArr = [[classObjArr objectAtIndex:0] componentsSeparatedByString:@":"];
		NSString *cid = [[cidArr objectAtIndex:1] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
		c.classID = [cid integerValue];
		
		NSArray *ctitArr =  [[NSArray alloc] init];
		ctitArr = [[classObjArr objectAtIndex:1] componentsSeparatedByString:@":"];
		c.Title = [[[ctitArr objectAtIndex:1] stringByReplacingOccurrencesOfString:@"\"" withString:@""] stringByReplacingOccurrencesOfString: @"\\" withString: @""] ;
		
		NSArray *csubArr = [[NSArray alloc] init];
		csubArr = [[classObjArr objectAtIndex:2] componentsSeparatedByString:@":"];
		c.Subject = [[[csubArr objectAtIndex:1] stringByReplacingOccurrencesOfString:@"\"" withString:@""] stringByReplacingOccurrencesOfString: @"\\" withString: @""] ;
		
		NSArray *catlgArr =  [[NSArray alloc] init];
		catlgArr = [[classObjArr objectAtIndex:3] componentsSeparatedByString:@":"];
		c.CatlgNbr = [[[catlgArr objectAtIndex:1] stringByReplacingOccurrencesOfString:@"\"" withString:@""] stringByReplacingOccurrencesOfString: @"\\" withString: @""];
		
		[aboutCsunjObjects addObject:c];
		[c release];
	}
	return aboutCsunjObjects;
}


- (void) dealloc {
	classInfojObjects = nil;
	classDetailsjObjects = nil;
	parkingjObjects = nil;
	facultyjObjects = nil;
	facSchjObjects = nil;
	aboutCsunjObjects = nil;
	[super dealloc];
}

@end
