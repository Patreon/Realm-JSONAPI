//
//  RLMObject-JSONAPITests.m
//  RLMObject-JSONAPITests
//
//  Created by David Kettler on 05/14/2016.
//  Copyright (c) 2016 David Kettler. All rights reserved.
//

// https://github.com/Specta/Specta

SpecBegin(InitialSpecs)

describe(@"these will pass now that they've been fixed", ^{

    it(@"can do maths", ^{
        expect(2).to.equal(2);
    });

    it(@"can read", ^{
        expect(@"string").to.equal(@"string");
    });
    
    it(@"will wait for 10 seconds and fail", ^{
        waitUntil(^(DoneCallback done) {
            expect(YES).to.beTruthy;
            done();
        });
    });
});

describe(@"these will pass", ^{
    
    it(@"can do maths", ^{
        expect(1).beLessThan(23);
    });
    
    it(@"can read", ^{
        expect(@"team").toNot.contain(@"I");
    });
    
    it(@"will wait and succeed", ^{
        waitUntil(^(DoneCallback done) {
            done();
        });
    });
});

SpecEnd

