    //
//  IntroViewController.m
//  CSUN
//
//  Created by Deeksha Prabhakar on 11/21/11.
//  Copyright 2011 CSUN. All rights reserved.
//

#import "IntroViewController.h"


@implementation IntroViewController


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
	CSUNAppDelegate *delegate = (CSUNAppDelegate *)[UIApplication sharedApplication].delegate;
	AboutCSUN *abtObj = [[AboutCSUN alloc] init];
	abtObj = delegate.aboutObj;
	
	NSString *cellText = abtObj.IntroText;
    UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:17.0];
    CGSize constraintSize = CGSizeMake(280.0f, MAXFLOAT);
    CGSize labelSize = [cellText sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
	
	
	UITextView *Intro = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, 300, labelSize.height)];
	
	Intro.clipsToBounds = YES;
	Intro.layer.cornerRadius = 5.0;
	
	NSString *text = abtObj.IntroText;
	Intro.text = @"";
	Intro.text = [Intro.text stringByAppendingString:text];
	[self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
	[self.view addSubview:Intro];
	[Intro sizeToFit];
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
}


- (void)dealloc {
    [super dealloc];
}


@end
