//
//  AppDelegate.m
//  NFLoggerDemo
//
//  Created by Nilesh Agrawal on 1/27/17.
//  Copyright © 2017 Nilesh Agrawal. All rights reserved.
//

#import "AppDelegate.h"
#import "NFLogger.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [NFLogger initializeSDKWithMode:NFLOGManualCapture];
    [NFLogger setLogLevelOfNFLog:NFLOG_LEVEL_VERBOSE|NFLOG_LEVEL_DEBUG|NFLOG_LEVEL_ERROR];
    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

@end
