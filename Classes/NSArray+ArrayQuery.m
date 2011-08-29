//
//  Query.m
//  DKPredicateBuilder
//
//  Created by Keith Pitt on 29/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NSArray+ArrayQuery.h"

@implementation NSArray (DKArrayQuery)

- (DKArrayQuery *)query {
    
    return [DKArrayQuery queryWithArray:self];
    
}

@end