//
//  httpRequest.h
//  CSUN
//
//  Created by Deeksha Prabhakar on 12/4/11.
//  Copyright 2011 CSUN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSUNAppDelegate.h"

@interface httpRequest : NSObject {
	NSMutableData *receivedData;
}

@property (nonatomic, retain) IBOutlet NSMutableData *receivedData;

-(void) getData: (NSString*)url : (NSString*)post;

@end
