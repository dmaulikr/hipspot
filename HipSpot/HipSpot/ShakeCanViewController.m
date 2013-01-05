//
//  ShakeCanViewController.m
//  HipSpot
//
//  Created by soedar on 5/1/13.
//  Copyright (c) 2013 noc. All rights reserved.
//

#import "ShakeCanViewController.h"

#define RADIANS(degrees) ((degrees * M_PI) / 180.0)
#define TIME_TO_SHAKE       9

@interface ShakeCanViewController ()
@property (nonatomic) CGAffineTransform leftWobble;
@property (nonatomic) CGAffineTransform rightWobble;

@property (nonatomic) BOOL isAnimating;
@end

@implementation ShakeCanViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.timerCount = TIME_TO_SHAKE;
        self.shakeCount = 0;
        
        self.leftWobble = CGAffineTransformRotate(CGAffineTransformIdentity, RADIANS(-10.0));
        self.rightWobble = CGAffineTransformRotate(CGAffineTransformIdentity, RADIANS(10.0));
        
        self.isAnimating = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self startTimer];
    //[self reduceShake];
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
    self.shakeCount++;
    self.shakeLabel.text = [NSString stringWithFormat:@"%i", self.shakeCount];
    
    if (!self.isAnimating) {
        self.isAnimating = YES;
        [UIView animateWithDuration:0.1 animations:^{
            self.sodaCanView.transform = self.leftWobble;
            self.sodaCanView.transform = self.rightWobble;
        } completion:^(BOOL finished) {
            self.sodaCanView.transform = CGAffineTransformIdentity;
            self.isAnimating = NO;
        }];
    }
}

@end