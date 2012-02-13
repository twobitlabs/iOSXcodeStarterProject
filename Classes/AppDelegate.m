//
//  AppDelegate.m
//
//  Created by Todd Huss on 2/9/12.
//  Copyright (c) 2012 Two Bit Labs. All rights reserved.
//

#import "AppDelegate.h"
#import "AnalyticsKitTestFlightProvider.h"
#import "AnalyticsKitFlurryProvider.h"
#import "AnalyticsKitApsalarProvider.h"

@interface AppDelegate ()

-(void)configureAnalyticsWithOptions:(NSDictionary *)launchOptions;

@end

@implementation AppDelegate

@synthesize window = _window;

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    return YES;
}
	
#pragma mark -
#pragma mark Analytics

void analyticsExceptionHandler(NSException *exception) {
    [AnalyticsKit uncaughtException:exception];    
}

-(void)configureAnalyticsWithOptions:(NSDictionary *)launchOptions {
#if (!TARGET_IPHONE_SIMULATOR)
    NSString *flurryKey = [[NSBundle mainBundle] objectForInfoDictionaryKey:FLURRY_KEY];
    
    NSString *apsalarKey = [[NSBundle mainBundle] objectForInfoDictionaryKey:APSALAR_KEY];
    NSString *apsalarSecret = [[NSBundle mainBundle] objectForInfoDictionaryKey:APSALAR_SECRET];

    NSString *testFlightKey = [[NSBundle mainBundle] objectForInfoDictionaryKey:TESTFLIGHT_KEY]

    NSArray *loggers = [NSArray arrayWithObjects:
                        [[AnalyticsKitFlurryProvider alloc] initWithAPIKey:key],
                        [[AnalyticsKitApsalarProvider alloc] initWithAPIKey:apsalarKey andSecret:apsalarSecret andLaunchOptions:launchOptions], 
                        [[AnalyticsKitTestFlightProvider alloc] initWithAPIKey:testFlightKey],
                        nil];
    [AnalyticsKit initializeLoggers:loggers];
#else

    //initialize AnalyticsKit to send messages to Flurry and TestFlight
    NSSetUncaughtExceptionHandler(&analyticsExceptionHandler);
    
    //Flurry: Track iOS version so we know when we can drop support for older versions
    NSDictionary *versDict = [NSDictionary dictionaryWithObject:[[UIDevice currentDevice] systemVersion] forKey:@"version"];
    [AnalyticsKit logEvent:@"App Started - All" withProperties:versDict];
    if (kCFCoreFoundationVersionNumber < 550.32) {
        [AnalyticsKit logEvent:@"App Started - 3" withProperties:versDict];
    } else if (kCFCoreFoundationVersionNumber < 600.0) {
        [AnalyticsKit logEvent:@"App Started - 4" withProperties:versDict];
    } else {
        [AnalyticsKit logEvent:@"App Started - 5" withProperties:versDict];
    }    
}

@end
