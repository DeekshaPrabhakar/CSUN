//
//  PhotosViewController.h
//  CSUN
//
//  Created by Deeksha Prabhakar on 11/21/11.
//  Copyright 2011 CSUN. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PhotosViewController : UIViewController {
	NSMutableArray *photos;
	IBOutlet UIImageView *imageView;
}

@property (nonatomic, retain) NSMutableArray *photos;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;

@end
