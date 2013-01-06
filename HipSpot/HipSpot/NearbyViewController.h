//
//  NearbyViewController.h
//  HipSpot
//
//  Created by soedar on 5/1/13.
//  Copyright (c) 2013 noc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BZFoursquare.h"

@interface NearbyViewController : UIViewController<BZFoursquareRequestDelegate, BZFoursquareSessionDelegate>

@property (nonatomic, weak) IBOutlet UITableView *nearbyTableView;
@end
