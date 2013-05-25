//
//  AppDelegate.m
//  HipSpot
//
//  Created by soedar on 5/1/13.
//  Copyright (c) 2013 noc. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"
#import "ShakeCanViewController.h"
#import "NearbyViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    //UIViewController *viewController = [[ShakeCanViewController alloc] initWithNibName:@"ShakeCanViewController" bundle:[NSBundle mainBundle]];
    //UIViewController *viewController = [[NearbyViewController alloc] initWithNibName:@"NearbyViewController" bundle:[NSBundle mainBundle]];
    UIViewController *viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:[NSBundle mainBundle]];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
    navController.navigationBarHidden = YES;
    self.window.rootViewController = navController;
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];

    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
    ViewController *masterViewController = [navigationController.viewControllers objectAtIndex:0];
    BZFoursquare *foursquare = masterViewController.fourSquare;
    return [foursquare handleOpenURL:url];
}

@end
