//
//  DKPredicateBuilderSpec.m
//  DiscoKit
//
//  Created by Keith Pitt on 12/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SpecHelper.h"

#import "DKPredicateBuilder.h"

SPEC_BEGIN(DKPredicateBuilderSpec)

__block DKPredicateBuilder * predicateBuilder;
__block NSCompoundPredicate * compoundPredicate;

beforeEach(^{
    
    predicateBuilder = [[DKPredicateBuilder alloc] init];
    
    [predicateBuilder where:@"name" equals:@"keith"];
    [predicateBuilder where:@"count" greaterThan:[NSNumber numberWithInt:12]];
    [predicateBuilder where:@"username" isNull:NO];
    
    compoundPredicate = [predicateBuilder compoundPredicate];
    
});

context(@"-compoundPredicate", ^{
    
    it(@"should construct an NSCompoundPredicate", ^{
        
        expect([compoundPredicate predicateFormat]).toEqual(@"name == \"keith\" AND count > 12 AND username != nil");
        
    });
    
});

SPEC_END