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
#import "AnalyticsKitLocalyitcsProvider.h"

@interface AppDelegate ()

-(void)configureUserAgent;
-(void)configureCache;
-(void)configureAnalyticsWithOptions:(NSDictionary *)launchOptions;

@end

@implementation AppDelegate

@synthesize window = _window;

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self configureAnalyticsWithOptions:launchOptions];
    return YES;
}

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self configureAnalyticsWithOptions:launchOptions];
    return YES;
}

#pragma mark -
#pragma mark User Agent
-(void)configureUserAgent {
    // Append app name and version information to User Agent string
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    NSString *secretAgent = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    if (secretAgent == nil || [secretAgent length] == 0) return;
    NSString *newAgent = [NSString stringWithFormat: @"%@%@%@%@%@%@%@",
                          secretAgent, 
                          [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"],
                          (TARGETED_DEVICE_IS_IPHONE) ? @" (iPhone " : @" (iPad ",
                          [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"],
                          @" ",
                          [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"],
                          @")"];
    NSDictionary *agentDictionary = [NSDictionary dictionaryWithObjectsAndKeys: newAgent, @"UserAgent", nil];    
    [[NSUserDefaults standardUserDefaults] registerDefaults:agentDictionary];
    NSLog(@"UA: %@", newAgent);    
}
	
#pragma mark -
#pragma mark Analytics

void analyticsExceptionHandler(NSException *exception) {
    [AnalyticsKit uncaughtException:exception];    
}

-(void)configureAnalyticsWithOptions:(NSDictionary *)launchOptions {
#if (!TARGET_IPHONE_SIMULATOR)
    NSMutableArray *providers = [NSMutableArray array];

    NSString *flurryKey = [[NSBundle mainBundle] objectForInfoDictionaryKey:FLURRY_KEY];
    [providers addObject:[[AnalyticsKitFlurryProvider alloc] initWithAPIKey:flurryKey]];
    
    NSString *apsalarKey = [[NSBundle mainBundle] objectForInfoDictionaryKey:APSALAR_KEY];
    NSString *apsalarSecret = [[NSBundle mainBundle] objectForInfoDictionaryKey:APSALAR_SECRET];
    [providers addObject:[[AnalyticsKitApsalarProvider alloc] initWithAPIKey:apsalarKey andSecret:apsalarSecret andLaunchOptions:launchOptions]]; 
    
    NSString *localyticsKey = [[NSBundle mainBundle] objectForInfoDictionaryKey:LOCALYTICS_KEY];
    [providers addObject:[[AnalyticsKitLocalyitcsProvider alloc] initWithAPIKey:localyticsKey]]; 
    
#ifdef DEBUG
    NSString *testFlightKey = [[NSBundle mainBundle] objectForInfoDictionaryKey:TESTFLIGHT_KEY];
    [providers addObject:[[AnalyticsKitTestFlightProvider alloc] initWithAPIKey:testFlightKey]];

#endif
    
    [AnalyticsKit initializeLoggers:providers];
#endif

    //initialize AnalyticsKit to send messages to Flurry and TestFlight
    NSSetUncaughtExceptionHandler(&analyticsExceptionHandler);
    
    // Track iOS version so we know when we can drop support for older versions
    NSDictionary *versDict = [NSDictionary dictionaryWithObject:[[UIDevice currentDevice] systemVersion] forKey:@"version"];
    [AnalyticsKit logEvent:@"App Started" withProperties:versDict];
}

@end
