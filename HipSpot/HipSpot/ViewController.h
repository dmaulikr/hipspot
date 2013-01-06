//
//  ViewController.h
//  HipSpot
//
//  Created by soedar on 5/1/13.
//  Copyright (c) 2013 noc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BZFoursquare.h"

@interface ViewController : UIViewController

@property (nonatomic, strong) BZFoursquare *fourSquare;

- (IBAction)showNearby:(id)sender;
- (IBAction)showAchievements:(id)sender;

@end
