//
//  SomeSpec.m
//  Unit Tests
//
//  Created by Christopher Pickslay on 2/9/12.
//  Copyright 2012 Two Bit Labs. All rights reserved.
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
        // ...
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

