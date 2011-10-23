//
//  DKArrayQueryFinish.h
//  DKPredicateBuilder
//
//  Created by Keith Pitt on 29/08/11.
//  Copyright 2011 Mostly Disco. All rights reserved.
//

#import "DKPredicateBuilder.h"

typedef void (^DKArrayQueryFinish)(NSArray * records);

@interface DKArrayQuery : DKPredicateBuilder {
    
    NSArray * source;
    
    dispatch_queue_t queue;
    
}

+ (id)queryWithArray:(NSArray *)array;

- (id)initWithArray:(NSArray *)array;

- (NSArray *)results;

- (void)perform:(DKArrayQueryFinish)block;
- (void)perform:(DKArrayQueryFinish)block background:(BOOL)background;

@end