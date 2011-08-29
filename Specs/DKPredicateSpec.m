//
//  DKPredicateSpec.m
//  DiscoKit
//
//  Created by Keith Pitt on 12/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SpecHelper.h"

#import "DKPredicate.h"

SPEC_BEGIN(DKPredicateSpec)
    
context(@"initWithPredicate:predicateType:info:", ^{
   
    it(@"should set the correct properties", ^{
        
        NSPredicate * actualPredicate = [NSPredicate predicateWithFormat:@"%K = %@", @"name", @"keith"];
        NSDictionary * info = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"name", @"column",
                               @"keith", @"value",
                               nil];
        
        DKPredicate * predicate = [DKPredicate withPredicate:actualPredicate
                                               predicateType:DKPredicateTypeEquals
                                                        info:info];
        
        expect(predicate.predicate).toEqual(actualPredicate);
        expect(predicate.info).toEqual(info);
        expect(predicate.predicateType).toEqual(DKPredicateTypeEquals);
        
    });
    
});

context(@"-predicateFormat", ^{
    
    it(@"should return the correct format for DKPredicateTypeEquals", ^{
        
        DKPredicate * predicate = [DKPredicate withPredicate:[NSPredicate predicateWithFormat:@"%K = %@", @"name", @"keith"]
                                               predicateType:DKPredicateTypeEquals
                                                        info:[NSDictionary dictionaryWithObjectsAndKeys:
                                                              @"name", @"column",
                                                              @"keith", @"value",
                                                              nil]];
        
        expect([predicate predicateFormat]).toEqual(@"name == \"keith\"");
        
    });
    
});

SPEC_END