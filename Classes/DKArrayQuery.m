//
//  DKArrayQueryFinish.m
//  DKPredicateBuilder
//
//  Created by Keith Pitt on 29/08/11.
//  Copyright 2011 Mostly Disco. All rights reserved.
//

#import "DKArrayQuery.h"

@implementation DKArrayQuery

+ (id)queryWithArray:(NSArray *)array {
    
    return [[[DKArrayQuery alloc] initWithArray:array] autorelease];
    
}

- (id)initWithArray:(NSArray *)array {
    
    if ((self = [super init])) {
        source = [array retain];
        queue =  dispatch_queue_create("com.mostlydisco.DKArrayQueue", 0);
    }
        
    return self;
    
}

- (NSArray *)results {
    
    NSArray * results = [source copy];
    
    // Filter the results
    if ([self.predicates count] > 0)
        results = [results filteredArrayUsingPredicate:[self compoundPredicate]];
    
    // Sort the results
    if ([self.sorters count] > 0)
        results = [results sortedArrayUsingDescriptors:self.sorters];
    
    // Apply the limit/offset
    if (self.limit || self.offset) {
        
        int count = [results count];
        
        // Calculate the start/end of the range
        int start = self.offset ? [self.offset intValue] : 0;
        int length = self.limit ? [self.limit intValue] : count;
        
        // If the length is more than the total results
        if (length > count)
            length = count;
        
        // If the start is more than the length, return no results
        if (start > length)
            return [NSArray array];
        
        // Apply the limit/offset
        NSRange range = NSMakeRange(start, length);
        results = [results subarrayWithRange:range];
        
    }
    
    return results;
    
}

- (void)perform:(DKArrayQueryFinish)block {
    
    [self perform:block background:NO];
    
}

- (void)perform:(DKArrayQueryFinish)block background:(BOOL)background {
    
    if (background == YES) {
        
        // Retain selc during the operation
        [self retain];
        
        // Grab the current dispatch queue
        dispatch_queue_t current = dispatch_get_current_queue();
        
        // Perform the calculation on a background thread
        dispatch_async(queue, ^{
            
            NSArray * results = [self results];
            
            // Call the finish block on the originating thread
            dispatch_sync(current, ^{
                
                // Call the finish block with the results
                block(results);
                
                // Cleanup
                [self release];
                
            });
            
        });
        
    } else {
        
        block([self results]);
        
    }
        
}

- (void)delloc {
    
    [source release];
    
    [super dealloc];
    
}

@end