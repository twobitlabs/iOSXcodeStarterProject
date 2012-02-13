//
//  AppDelegate.m
//  Application
//
//  Created by Todd Huss on 2/9/12.
//  Copyright (c) 2012 Two Bit Labs. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [TestFlight takeOff:@"Insert your Team Token here"];

    return YES;
}
							
@end
