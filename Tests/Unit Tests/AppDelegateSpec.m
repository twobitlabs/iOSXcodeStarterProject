//
//  AppDelegateSpec.m
//  Unit Tests
//

#import "BaseTestCase.h"
#import "AppDelegate.h"

@interface AppDelegate ()

-(void)configureUserAgent;

@end

SpecBegin(AppDelegateSpec)

describe(@"AppDelegateSpec", ^{
    __block AppDelegate *delegate;
    
    beforeEach(^{
        delegate = [[UIApplication sharedApplication] delegate];
    });
    
    it(@"should customize the user agent string", ^{
        NSString *userAgentOld = [[[UIWebView alloc] init] stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
        [delegate configureUserAgent];
        NSString *userAgentNew = [[[UIWebView alloc] init] stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];        
        expect(userAgentNew).Not.toEqual(userAgentOld);
        expect(userAgentNew).toContain([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"]);
    });
    
    afterEach(^{
        delegate = nil;
    });
});

SpecEnd

