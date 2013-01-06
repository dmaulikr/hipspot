//
//  ViewController.m
//  HipSpot
//
//  Created by soedar on 5/1/13.
//  Copyright (c) 2013 noc. All rights reserved.
//

#import "ViewController.h"
#import "NearbyViewController.h"

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
        logo.transform = CGAffineTransformMakeScale(1.10, 1.10);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5f
                              delay:0.0f
                            options: UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat
                         animations:^{
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
    
    [self.navigationController pushViewController:nearbyController animated:YES];
}

@end
