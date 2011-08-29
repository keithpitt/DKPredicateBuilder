//
//  DKArrayQuerySpec.m
//  DKPredicateBuilder
//
//  Created by Keith Pitt on 29/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SpecHelper.h"

#import "DKArrayQuery.h"
#import "NSArray+ArrayQuery.h"

SPEC_BEGIN(DKArrayQuerySpec)

context(@"- (void)perform:(DKArrayQueryFinish)block", ^{
    
    NSArray * namesArray = [NSArray arrayWithObjects:
                            [NSDictionary dictionaryWithObjectsAndKeys:@"Kevin", @"first_name", nil],
                            [NSDictionary dictionaryWithObjectsAndKeys:@"Keith", @"first_name", nil],
                            [NSDictionary dictionaryWithObjectsAndKeys:@"Jordan", @"first_name", nil],
                            [NSDictionary dictionaryWithObjectsAndKeys:@"Mario", @"first_name", nil],
                            [NSDictionary dictionaryWithObjectsAndKeys:@"Dirk", @"first_name", nil],
                            nil];
    
    it(@"where:equals:", ^{
        
        DKArrayQuery * arrayQuery = [DKArrayQuery queryWithArray:namesArray];
        
        [arrayQuery where:@"first_name" equals:@"Keith"];
        
        [arrayQuery perform:^(NSArray * records) {
            
            expect([records count]).toEqual(1);
            expect([records lastObject]).toEqual([namesArray objectAtIndex:1]);
            
        }];
        
    });
    
    it(@"should allow you to sort objects", ^{
        
        DKArrayQuery * arrayQuery = [DKArrayQuery queryWithArray:namesArray];
        
        [arrayQuery where:@"first_name" startsWith:@"Ke"];
        [arrayQuery orderBy:@"first_name" ascending:YES];
        
        [arrayQuery perform:^(NSArray * records) {
            
            expect([records count]).toEqual(2);
            expect([records objectAtIndex:0]).toEqual([namesArray objectAtIndex:1]);
            expect([records objectAtIndex:1]).toEqual([namesArray objectAtIndex:0]);
            
        }];
        
    });
    
    it(@"should allow you perform the query in the background", ^{
        
        __block BOOL completed;
        
        DKArrayQuery * arrayQuery = [[namesArray query] where:@"first_name" equals:@"Keith"];
        
        [arrayQuery perform:^(NSArray * records) {
            
            expect([records count]).toEqual(1);
            expect([records lastObject]).toEqual([namesArray objectAtIndex:1]);
            
            completed = YES;
            
        } background:YES];
        
        while(!completed)
            [NSThread sleepForTimeInterval:0.1];
        
    });
    
});

SPEC_END