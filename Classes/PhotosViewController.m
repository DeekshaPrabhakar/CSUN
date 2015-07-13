    //
//  PhotosViewController.m
//  CSUN
//
//  Created by Deeksha Prabhakar on 11/21/11.
//  Copyright 2011 CSUN. All rights reserved.
//

#import "PhotosViewController.h"


@implementation PhotosViewController
@synthesize photos,imageView;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	NSString *bundleRoot = [[NSBundle mainBundle] bundlePath];
	NSArray *dirContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:bundleRoot error:nil];
	
	photos = [[NSMutableArray alloc]init];
	NSArray *arr = [[NSArray alloc]initWithArray:[dirContents filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self ENDSWITH '.jpg' OR self ENDSWITH '.jpeg'"]]];
	
	for (int j=0; j<arr.count-1; j++) {
		[photos addObject:[UIImage imageNamed:[arr objectAtIndex:j]]];
	}
	
	
	//imageView.animationImages = arr;
imageView.animationImages = [NSArray arrayWithObjects:
                                 [UIImage imageNamed:@"csun30.jpg"],
                                 [UIImage imageNamed:@"oviatt2.jpeg"],
                                 [UIImage imageNamed:@"library.jpeg"],
								 [UIImage imageNamed:@"oviatt_entrance.jpg"],
								 [UIImage imageNamed:@"noski.jpeg"],
								 [UIImage imageNamed:@"juniperhall.jpeg"],
								 [UIImage imageNamed:@"csunlib2.jpeg"],
							     [UIImage imageNamed:@"artscenter.jpeg"],
							     [UIImage imageNamed:@"ManzanitaHall1.jpg"],
								 [UIImage imageNamed:@"manzanitahall2.jpeg"],
							     [UIImage imageNamed:@"artgallery-stamp.jpg"],
								 [UIImage imageNamed:@"chapparalHall.jpeg"],nil];
    imageView.animationDuration = 30.00; //1 second
    imageView.animationRepeatCount = 0; //infinite
	
    [imageView startAnimating]; //start the animation
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	self.photos = nil;
}


- (void)dealloc {
	[imageView release];
	[self.photos release];
    [super dealloc];
}


@end
