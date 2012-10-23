//
//  SomeSpec.m
//  Unit Tests
//

#import "BaseTestCase.h"

SpecBegin(SomeSpec)

describe(@"SomeSpec", ^{
    __block NSObject *foo;
    
    beforeAll(^{
        // This is run once and only once before all of the examples
        // in this group and before any beforeEach blocks.
    });
    
    beforeEach(^{
        foo = [[NSObject alloc] init];
    });
    
    it(@"should do something", ^{
        id mockFoo = [OCMockObject mockForClass:[NSString class]];
        [[[mockFoo stub] andReturn:@"foo"] lowercaseString];
        
        expect([mockFoo lowercaseString]).toEqual(@"foo");
    });
    
    describe(@"Nested examples", ^{
        it(@"should do even more stuff", ^{
            // ...
        });
    });
    
    pending(@"pending example");
    
    pending(@"another pending example", ^{
        // ...
    });
    
    afterEach(^{
        foo = nil;
    });
    
    afterAll(^{
        // This is run once and only once after all of the examples
        // in this group and after any afterEach blocks.
    });
});

SpecEnd

