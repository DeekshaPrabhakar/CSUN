//
//  httpRequest.m
//  CSUN
//
//  Created by Deeksha Prabhakar on 12/4/11.
//  Copyright 2011 CSUN. All rights reserved.
//

#import "httpRequest.h"


@implementation httpRequest

@synthesize receivedData;

-(void) getData: (NSString*)url : (NSString*)post
{
	NSString *type = @"Student";
	//NSString *post = [NSString stringWithFormat:@"&type=%@",type];
	
	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
	NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];	
	//[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.1.79/getclassinfo.aspx"]]];	
	[request setURL:[NSURL URLWithString:[NSString stringWithString:url]]];
	[request setHTTPMethod:@"POST"];						  
	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
	[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Current-Type"];	
	[request setHTTPBody:postData];
	
	NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	
	if(conn){
		receivedData = [[NSMutableData data] retain];		
	}
	else {
		
	}	
}

//Delegate methods for the NSMutableURLRequest 
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	[receivedData setLength:0];
}

//The delegate is periodically sent connection:didReceiveData: messages as the data is received. The delegate implementation is responsible for storing the 
//newly received data.
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    [connection release];
    [receivedData release];
	
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"Succeeded! Received %d bytes of data",[receivedData length]);
	
	CSUNAppDelegate *delegate = (CSUNAppDelegate *)[UIApplication sharedApplication].delegate;

	NSString *str = [[NSString alloc] initWithData:receivedData encoding:NSASCIIStringEncoding];	
	[delegate didReceiveData:str];
	
    [connection release];
    [receivedData release];
}

- (void)dealloc {
    [super dealloc];
}

@end
