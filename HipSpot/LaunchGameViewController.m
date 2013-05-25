//
//  LaunchGameViewController.m
//  HipSpot
//
//  Created by soedar on 5/1/13.
//  Copyright (c) 2013 noc. All rights reserved.
//

#import "LaunchGameViewController.h"
#import "ShakeCanViewController.h"

@interface LaunchGameViewController () {
    IBOutlet UILabel *label;
}

@end

@implementation LaunchGameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)checkin:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Check In"
                                                    message:@"You have checked in at Burger Bar!"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    label.font = [UIFont fontWithName:@"Barthowheel" size:24];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) launchGame:(id)sender
{
    UIViewController *gameController = [[ShakeCanViewController alloc] initWithNibName:@"ShakeCanViewController" bundle:[NSBundle mainBundle]];
    
    [self.navigationController pushViewController:gameController animated:YES];
}

@end
