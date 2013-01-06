//
//  ViewController.m
//  HipSpot
//
//  Created by soedar on 5/1/13.
//  Copyright (c) 2013 noc. All rights reserved.
//

#import "ViewController.h"
#import "NearbyViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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
