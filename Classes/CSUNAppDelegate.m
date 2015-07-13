//
//  CSUNAppDelegate.m
//  CSUN
//
//  Created by Deeksha Prabhakar on 3/29/11.
//  Copyright 2011 CSUN. All rights reserved.
//

#import "CSUNAppDelegate.h"

@implementation CSUNAppDelegate

@synthesize window;
@synthesize navController;
@synthesize FacultyArray;
@synthesize ClassesArray,stdParkArray,facParkArray,visParkArray,parkObj,myClassesArray,webServiceUrl;
@synthesize aboutObj;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
	//Copy database to the user's phone if needed.
	[self copyDatabaseIfNeeded];
	
	//Initialize the coffee array.
	NSMutableArray *tempArray = [[NSMutableArray alloc] init];
	self.FacultyArray = tempArray;
	[tempArray release];
	
	self.ClassesArray = [[NSMutableArray alloc] init];
	[self.ClassesArray release];
	
	self.stdParkArray = [[NSMutableArray alloc] init];
	self.facParkArray = [[NSMutableArray alloc] init];
	self.visParkArray = [[NSMutableArray alloc] init];
	self.myClassesArray = [[NSMutableArray alloc] init];
	[self.myClassesArray release];
	
	self.aboutObj = [[AboutCSUN alloc]init];
	[self.aboutObj release];
	self.parkObj = [[Parking alloc] init];
	[self.parkObj release];
	NSString *databasePath = [self getDBPath];
	
	//Once the db is copied, get the initial data to display on the screen.
	[Faculty getInitialDataToDisplay:databasePath];
	[ClassInfo getDataToDisplay:databasePath];
	
	[AboutCSUN getIntroAddressToDisplay:databasePath];
	
	[History getHistoryToDisplay:databasePath :self.aboutObj];
	[Contacts getContactsToDisplay:databasePath :self.aboutObj];
	
	[ParkingInformation getParkingInfoToDisplay:databasePath: self.parkObj];
	
	//[self updateClassInfo];
	
    // Override point for customization after application launch.
    [window addSubview:navController.view];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}

#pragma mark -
#pragma mark Database Methods

- (void) copyDatabaseIfNeeded {
	
	//Using NSFileManager we can perform many file system operations.
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error;
	NSString *dbPath = [self getDBPath];
	BOOL success = [fileManager fileExistsAtPath:dbPath];
	
	if(!success) {
		
		NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"iCSUNDB.sqlite"];
		success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
		
		if (!success)
			NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
	}
}

- (NSString *) getDBPath {
	
	//Search for standard documents using NSSearchPathForDirectoriesInDomains
	//First Param = Searching the documents directory
	//Second Param = Searching the Users directory and not the System
	//Expand any tildes and identify home directories.
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
	NSString *documentsDir = [paths objectAtIndex:0];
	return [documentsDir stringByAppendingPathComponent:@"iCSUNDB.sqlite"];
}

- (void) updateInfo:(NSString *)url:(NSString *)post {
	httpRequest *h = [[httpRequest alloc] init];
	[h getData:url:post];
}

-(void) didReceiveData:(NSString *)jsonString
{
	NSString *str = [[NSString alloc]init];
	str = jsonString;
	
	NSArray *ObjArr = [[NSArray alloc]init]; 
	ObjArr = [jsonString componentsSeparatedByString:@"|"];
	NSString *type = [ObjArr objectAtIndex:1];
	
	myJsonParser *j = [[myJsonParser alloc]init];
	
	
	if ([type isEqualToString:@"ClassInfo"]) {
		NSMutableArray *classInfoArr = [[NSMutableArray alloc]init];
		classInfoArr = [j initandParseClassInfo:str];
		[ClassInfo deleteClassInfo];
		//[ClassInfo deleteClassInfoSeq];
		ClassInfo *currClass = [[ClassInfo alloc]init];
		[ClassInfo resetPrimaryKey:1];
		
		for(int k = 0; k<classInfoArr.count; k++)
		{
			currClass = [classInfoArr objectAtIndex:k];
			[ClassInfo insertClassInfoData: currClass];
		}
		//[currClass release];
	} 
	else if ([type isEqualToString:@"ClassDetails"]) {
		
	} 
	else if ([type isEqualToString:@"FacultyInfo"]) {
		
	} 
	else if ([type isEqualToString:@"FacOfficeHours"]) {
		
		
	} 
	else if ([type isEqualToString:@"FacClassSchedule"]) {
		NSMutableArray *InfoArr = [[NSMutableArray alloc]init];
		InfoArr = [j initandParseFacultySchedule:str];
		NSString *databasePath = [self getDBPath];
		[FacultySchedule deleteFacSch:databasePath];
		
		FacultySchedule *currObj = [[FacultySchedule alloc]init];
		
		for(int k = 0; k<InfoArr.count; k++)
		{
			currObj = [InfoArr objectAtIndex:k];
			[FacultySchedule insertFacSchData: currObj:databasePath];
		}	
		
	} 
}
#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}

- (void)dealloc {
	[webServiceUrl release];
	[parkObj release];
	[aboutObj release];
	[myClassesArray release];
	[stdParkArray release];
	[visParkArray release];
	[facParkArray release];
	[FacultyArray release];
	[ClassesArray release];
    [window release];
	[navController release];
    [super dealloc];
}


@end
