//
//  NearbyViewController.m
//  HipSpot
//
//  Created by soedar on 5/1/13.
//  Copyright (c) 2013 noc. All rights reserved.
//

#import "NearbyViewController.h"

#define FS_CLIENTID @"0NNXENMTYWXF2LBOVWYFT2ZUA3YTPOMTNCGTIULFN4PNZ5SK"
#define FS_CALLBACK @"hipspot://foursquare"

@interface NearbyViewController ()
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
    self.fourSquare = [[BZFoursquare alloc] initWithClientID:FS_CLIENTID callbackURL:FS_CALLBACK];
    self.fourSquare.sessionDelegate = self;
    self.fourSquare.version = @"20130105";
    
    if (![self.fourSquare isSessionValid]) {
        [self.fourSquare startAuthorization];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 68.0;
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
        /*
        if ([view isKindOfClass:[UIImageView class]]) {
            UIImageView *imageView = (UIImageView*)view;
            NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:data.imageURL]];
            imageView.image = [UIImage imageWithData:imageData];
        }
        else 
         */
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel*) view;
            switch (label.tag) {
                case 0:
                    label.text = data.name;
                    break;
                case 1:
                    label.text = data.type;
                    break;
                case 2:
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
        prefix = [prefix substringToIndex:prefix.length-1];

        locationData.imageURL = [NSString stringWithFormat:@"%@%@",
                                 prefix,
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
    
    BZFoursquareRequest *request = [self.fourSquare requestWithPath:@"venues/explore" HTTPMethod:@"GET" parameters:params delegate:self];
    [request start];
}

- (void)foursquareDidNotAuthorize:(BZFoursquare *)foursquare error:(NSDictionary *)errorInfo
{
    NSLog(@"Session Error: %@", errorInfo);
    
}

@end
