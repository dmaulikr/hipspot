//
//  LaunchGameViewController.m
//  HipSpot
//
//  Created by soedar on 5/1/13.
//  Copyright (c) 2013 noc. All rights reserved.
//

#import "LaunchGameViewController.h"
#import "ShakeCanViewController.h"

@interface LaunchGameViewController ()

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
