//
//  ViewController.m
//  HipSpot
//
//  Created by soedar on 5/1/13.
//  Copyright (c) 2013 noc. All rights reserved.
//

#import "ViewController.h"
#import "NearbyViewController.h"

#define FS_CLIENTID @"0NNXENMTYWXF2LBOVWYFT2ZUA3YTPOMTNCGTIULFN4PNZ5SK"
#define FS_CALLBACK @"hipspot://foursquare"

@interface ViewController () {
    IBOutlet UIImageView *logo;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    logo.transform = CGAffineTransformMakeScale(0.1, 0.1);
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [UIView animateWithDuration:0.7f animations:^{
        logo.transform = CGAffineTransformMakeScale(1.15, 1.15);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15f animations:^{
            logo.transform = CGAffineTransformMakeScale(1, 1);
        } completion:^(BOOL finished) {
            
        }];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showNearby:(id)sender
{
    NearbyViewController *nearbyController = [[NearbyViewController alloc] initWithNibName:@"NearbyViewController" bundle:[NSBundle mainBundle]];
    self.fourSquare = [[BZFoursquare alloc] initWithClientID:FS_CLIENTID callbackURL:FS_CALLBACK];
    self.fourSquare.sessionDelegate = nearbyController;
    self.fourSquare.version = @"20130105";
    
    if (![self.fourSquare isSessionValid]) {
        [self.fourSquare startAuthorization];
    }
    
    [self.navigationController pushViewController:nearbyController animated:YES];
}

@end
