//
//  ShakeCanViewController.m
//  HipSpot
//
//  Created by soedar on 5/1/13.
//  Copyright (c) 2013 noc. All rights reserved.
//

#import "ShakeCanViewController.h"

#define RADIANS(degrees) ((degrees * M_PI) / 180.0)
#define TIME_TO_SHAKE               40
#define FLY_RATE                    200     // Flying rate in pixels per second
#define STRENGTH_TO_OFFSET_RATIO    10      // 10 pixels per strength

@interface ShakeCanViewController ()
@property (nonatomic) CGAffineTransform leftWobble;
@property (nonatomic) CGAffineTransform rightWobble;

@property (nonatomic) BOOL isWobbling;
@property (nonatomic) BOOL isShakable;

@property (nonatomic, strong) NSTimer *backgroundScrollTimer;
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
        
        self.isWobbling = NO;
        self.isShakable = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self startTimer];
    
    float max = 1200 - self.backgroundScrollView.frame.size.height;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wall.jpg"]];
    [self.backgroundScrollView setBackgroundColor:[UIColor greenColor]];
    [self.backgroundScrollView setContentSize:CGSizeMake(320, max)];
    [self.backgroundScrollView addSubview:imageView];
    [self.backgroundScrollView setContentOffset:CGPointMake(0, max)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Timer codes

- (void) startTimer
{
    self.timerLabel.text = [NSString stringWithFormat:@"%d.%d", self.timerCount/10, self.timerCount%10];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(tickTimer) userInfo:nil repeats:YES];
}

- (void) tickTimer
{
    self.timerCount--;
    self.timerLabel.text = [NSString stringWithFormat:@"%d.%d", self.timerCount/10, self.timerCount%10];
    
    if (self.timerCount == 0) {
        [self.timer invalidate];
        self.isShakable = NO;
        self.sodaCanView.transform = CGAffineTransformMakeRotation(RADIANS(180));
        [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(animateSodaCan) userInfo:nil repeats:NO];
    }
}

- (IBAction)shake:(id)sender
{
    if (!self.isShakable) return;
    
    self.shakeCount++;
    self.shakeLabel.text = [NSString stringWithFormat:@"%i", self.shakeCount];
    
    if (!self.isWobbling) {
        self.isWobbling = YES;
        [UIView animateWithDuration:0.1 animations:^{
            self.sodaCanView.transform = self.leftWobble;
            self.sodaCanView.transform = self.rightWobble;
        } completion:^(BOOL finished) {
            self.sodaCanView.transform = CGAffineTransformIdentity;
            self.isWobbling = NO;
        }];
    }
}


- (void) animateSodaCan
{
    if (self.shakeCount > 0) {
        [self scrollBackground];
        [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             self.sodaCanView.transform = CGAffineTransformMakeTranslation(0, -200);
                         } completion:^(BOOL finished) {
                         }];
    }
    
}
- (void) scrollBackground {
    float offset = [self calculateOffsetFromStrength:self.shakeCount];
    float duration = [self calculateDurationFromStrength:self.shakeCount];
    
    [UIView animateWithDuration:duration delay:0.5 options:0 animations:^{
        [self.backgroundScrollView setContentOffset:CGPointMake(0, offset)];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:duration delay:1 options:0 animations:^{
            self.sodaCanView.transform = CGAffineTransformMakeRotation(RADIANS(180));
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 self.sodaCanView.transform = CGAffineTransformMakeTranslation(0, 1000);
                             } completion:^(BOOL finished) {
                             }];
        }];
    }];
}

- (float) calculateOffsetFromStrength:(int) strength {
    float offset = strength * STRENGTH_TO_OFFSET_RATIO;
    
    float max = 1200 - self.backgroundScrollView.frame.size.height;
    if (offset >= max) {
        return 0;
    }
    
    return max-offset;
}

- (float) calculateDurationFromStrength:(int) strength {
    float offset = strength * STRENGTH_TO_OFFSET_RATIO;
    
    return offset / FLY_RATE;
}

@end