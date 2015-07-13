//
//  MapPin.m
//  CSUN
//
//  Created by Deeksha Prabhakar on 12/2/11.
//  Copyright 2011 CSUN. All rights reserved.
//

#import "MapPin.h"


@implementation MapPin
@synthesize coordinate, title;

- (id) initWithCoordinate:(CLLocationCoordinate2D)coord :(NSString*) tit{
	self = [super init];
	if(self){
		self.coordinate = coord;
		self.title = tit;
	}	
	return self;
}

- (NSString *) title {
	return @"Jacaranda";
}

-(void)dealloc{
	[title release];
	[super dealloc];
}

@end
