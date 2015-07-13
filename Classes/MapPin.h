//
//  MapPin.h
//  CSUN
//
//  Created by Deeksha Prabhakar on 12/2/11.
//  Copyright 2011 CSUN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapPin : NSObject<MKAnnotation> {
	CLLocationCoordinate2D coordinate;
	NSString *title;
}

@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) NSString *title;

- (id) initWithCoordinate:(CLLocationCoordinate2D)coord :(NSString*) tit;

- (NSString *) title;
@end

