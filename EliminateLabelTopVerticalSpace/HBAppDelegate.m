//
//  HBAppDelegate.m
//  EliminateLabelTopVerticalSpace
//
//  Created by Heath Borders on 10/7/12.
//  Copyright (c) 2012 Heath Borders. All rights reserved.
//

#import "HBAppDelegate.h"

#import "HBViewController.h"

@implementation HBAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [HBViewController new];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
