//
//  ShakeCanViewController.m
//  HipSpot
//
//  Created by soedar on 5/1/13.
//  Copyright (c) 2013 noc. All rights reserved.
//

#import "ShakeCanViewController.h"

@interface ShakeCanViewController ()
@end

@implementation ShakeCanViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.timerCount = 9;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self startTimer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Timer codes

- (void) startTimer
{
    self.timerLabel.text = [NSString stringWithFormat:@"%i", self.timerCount];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tickTimer) userInfo:nil repeats:YES];
}

- (void) tickTimer
{
    self.timerCount--;
    self.timerLabel.text = [NSString stringWithFormat:@"%i", self.timerCount];
    
    if (self.timerCount == 0) {
        [self.timer invalidate];
    }
}

- (IBAction)shake:(id)sender
{
    
}

@end
