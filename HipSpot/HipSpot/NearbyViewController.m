//
//  NearbyViewController.m
//  HipSpot
//
//  Created by soedar on 5/1/13.
//  Copyright (c) 2013 noc. All rights reserved.
//

#import "NearbyViewController.h"
#import "ViewController.h"
#import "LaunchGameViewController.h"
#import "UIImageView+JMImageCache.h"

@interface NearbyViewController () {
    IBOutlet UIActivityIndicatorView *indicator;
}
@property (nonatomic, strong) NSArray *locationsData;
@end

@interface LocationData : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *type;
@property (nonatomic) int distance;
@property (nonatomic, strong) NSString *imageURL;
@end

@implementation LocationData
- (NSString*) description
{
    return [NSString stringWithFormat:@"%@ %@ %@ %i", self.name, self.type, self.imageURL, self.distance];
}
@end

@implementation NearbyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.hipScore.font = [UIFont fontWithName:@"Barthowheel" size:25];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 68.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LaunchGameViewController *launchGameController = [[LaunchGameViewController alloc] initWithNibName:@"LaunchGameViewController" bundle:[NSBundle mainBundle]];
    
    [self.navigationController pushViewController:launchGameController animated:YES];
}

#pragma mark - Table Data Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.locationsData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NearbyViewCell"];
    if (cell == nil) {
        // Load the top-level objects from the custom cell XIB.
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"NearbyViewCell" owner:self options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
    }
    else {
        NSLog(@"reusing");
    }
    
    int index = indexPath.row;
    LocationData *data = self.locationsData[index];
    for (UIView *view in cell.contentView.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            UIImageView *imageView = (UIImageView*)view;
            [imageView setImageWithURL:[NSURL URLWithString:data.imageURL]];
        }
        else if ([view isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel*) view;
            switch (label.tag) {
                case 0:
                    label.font = [UIFont fontWithName:@"Barthowheel" size:28];
                    label.text = data.name;
                    break;
                case 1:
                    label.font = [UIFont fontWithName:@"Barthowheel" size:20];
                    label.text = data.type;
                    break;
                case 2:
                    label.font = [UIFont fontWithName:@"Barthowheel" size:20];
                    label.text = [NSString stringWithFormat:@"%im", data.distance];
                    break;
            }
        }
    }
    
    return cell;
}

#pragma mark - Request Delegate Protocol
- (void)requestDidFinishLoading:(BZFoursquareRequest *)request
{
    self.locationsData = [self getLocationDataFromResponse:request.response];
    [self.nearbyTableView reloadData];
    [indicator stopAnimating];
    indicator.hidden = YES;
    self.nearbyTableView.hidden = NO;
    
}

- (NSArray*) getLocationDataFromResponse:(NSDictionary*)response
{
    NSArray *items = response[@"groups"][0][@"items"];
    // name, type, distance, type image
    
    NSMutableArray *locationsData = [NSMutableArray array];
    for (NSDictionary *item in items) {
        LocationData *locationData = [[LocationData alloc] init];
        locationData.name = item[@"venue"][@"name"];
        locationData.type = item[@"venue"][@"categories"][0][@"shortName"];
        locationData.distance = [item[@"venue"][@"location"][@"distance"] integerValue];
        
        NSString *prefix = item[@"venue"][@"categories"][0][@"icon"][@"prefix"];

        locationData.imageURL = [NSString stringWithFormat:@"%@%i%@",
                                 prefix,
                                 64,
                                 item[@"venue"][@"categories"][0][@"icon"][@"suffix"]];
        
        [locationsData addObject:locationData];
    }
    return locationsData;
}

- (void)request:(BZFoursquareRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"Request Error: %@", [error localizedDescription]);
}

#pragma mark - Session Protocol
- (void)foursquareDidAuthorize:(BZFoursquare *)foursquare
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"ll"] = @"37.785834,-122.406417";
    params[@"radius"] = @"250";
    
    UINavigationController *navigationController = self.navigationController;
    ViewController *viewController = [navigationController.viewControllers objectAtIndex:0];
    
    BZFoursquareRequest *request = [viewController.fourSquare requestWithPath:@"venues/explore" HTTPMethod:@"GET" parameters:params delegate:self];
    [request start];
}

- (void)foursquareDidNotAuthorize:(BZFoursquare *)foursquare error:(NSDictionary *)errorInfo
{
    NSLog(@"Session Error: %@", errorInfo);
    
}

@end
