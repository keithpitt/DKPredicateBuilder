//
//  DKPredicateBuilder.m
//  DiscoKit
//
//  Created by Keith Pitt on 12/07/11.
//  Copyright 2011 Mostly Disco. All rights reserved.
//

#import "DKPredicateBuilder.h"

#import "NSString+Hash.h"

@implementation DKPredicateBuilder

@synthesize predicates, sorters, columns, limit, offset, batchSize;
@synthesize lastPerformDate;

- (id)init {
        
    if ((self = [super init])) {
                
        // Create the predicates mutable array
        predicates = [[NSMutableArray alloc] init];
        
        // Create the sorters mutable array
        sorters = [[NSMutableArray alloc] init];
        
        // Create the columns mutable array
        columns = [[NSMutableArray alloc] init];
        
    }
    
    return self;
    
}

- (id)only:(NSString *)column {
    
    [self.columns addObject:column];
    
    return self;
    
}

- (id)where:(DKPredicate *)predicate {
    
    [self.predicates addObject:predicate];
    
    return self;
    
}

- (id)where:(NSString *)key isFalse:(BOOL)value {
    
    [self where:key isTrue:!value];
    
    return self;
    
}

- (id)where:(NSString *)key isTrue:(BOOL)value {
    
    [self where:[DKPredicate withPredicate:[NSPredicate predicateWithFormat:@"%K = %@", key, [NSNumber numberWithBool:value]]
                                predicateType:value ? DKPredicateTypeIsTrue : DKPredicateTypeIsFalse
                                         info:[NSDictionary dictionaryWithObject:key forKey:@"column"]]];
    
    return self;
    
}

- (id)where:(NSString *)key isNull:(BOOL)value {
    
    if (value == YES) {
        
        [self where:[DKPredicate withPredicate:[NSPredicate predicateWithFormat:@"%K == nil", key]
                                    predicateType:value ? DKPredicateTypeIsTrue : DKPredicateTypeIsFalse
                                             info:[NSDictionary dictionaryWithObject:key forKey:@"column"]]];
        
    } else {
        
        [self where:key isNotNull:YES];
        
    }
    
    return self;
    
}

- (id)where:(NSString *)key isNotNull:(BOOL)value {
    
    if (value == YES) {
        
        [self where:[DKPredicate withPredicate:[NSPredicate predicateWithFormat:@"%K != nil", key]
                                    predicateType:value ? DKPredicateTypeIsTrue : DKPredicateTypeIsFalse
                                             info:[NSDictionary dictionaryWithObject:key forKey:@"column"]]];
        
    } else {
        
        [self where:key isNull:YES];
        
    }
    
    return self;
    
}

- (id)where:(NSString *)key equals:(id)value {
    
    [self where:[DKPredicate withPredicate:[NSPredicate predicateWithFormat:@"%K = %@", key, value]
                                predicateType:DKPredicateTypeEquals
                                         info:[NSDictionary dictionaryWithObjectsAndKeys:
                                               key, @"column",
                                               value, @"value",
                                               nil]]];
    
    return self;
    
}

- (id)where:(NSString *)key doesntEqual:(id)value {
    
    [self where:[DKPredicate withPredicate:[NSPredicate predicateWithFormat:@"%K != %@", key, value]
                                predicateType:DKPredicateTypeNotEquals
                                         info:[NSDictionary dictionaryWithObjectsAndKeys:
                                               key, @"column",
                                               value, @"value",
                                               nil]]];
    
    return self;
    
}

- (id)where:(NSString *)key isIn:(NSArray *)values {
    
    [self where:[DKPredicate withPredicate:[NSPredicate predicateWithFormat:@"%K IN (%@)", key, values]
                                predicateType:DKPredicateTypeIn
                                         info:[NSDictionary dictionaryWithObjectsAndKeys:
                                               key, @"column",
                                               values, @"values",
                                               nil]]];
    
    return self;
    
}

- (id)where:(NSString *)key isNotIn:(NSArray *)values {
    
    [self where:[DKPredicate withPredicate:[NSPredicate predicateWithFormat:@"NOT %K IN (%@)", key, values]
                                predicateType:DKPredicateTypeNotIn
                                         info:[NSDictionary dictionaryWithObjectsAndKeys:
                                               key, @"column",
                                               values, @"values",
                                               nil]]];
    
    return self;
    
}

- (id)where:(NSString *)key startsWith:(NSString *)value {
    
    [self where:[DKPredicate withPredicate:[NSPredicate predicateWithFormat:@"%K BEGINSWITH[cd] %@", key, value]
                                predicateType:DKPredicateTypeStartsWith
                                         info:[NSDictionary dictionaryWithObjectsAndKeys:
                                               key, @"column",
                                               value, @"value",
                                               nil]]];
    
    return self;
    
}

- (id)where:(NSString *)key doesntStartWith:(NSString *)value {
    
    [self where:[DKPredicate withPredicate:[NSPredicate predicateWithFormat:@"NOT %K BEGINSWITH[cd] %@", key, value]
                                predicateType:DKPredicateTypeDoesntStartWith
                                         info:[NSDictionary dictionaryWithObjectsAndKeys:
                                               key, @"column",
                                               value, @"value",
                                               nil]]];
    
    return self;
    
}

- (id)where:(NSString *)key endsWith:(NSString *)value {
    
    [self where:[DKPredicate withPredicate:[NSPredicate predicateWithFormat:@"%K ENDSWITH[cd] %@", key, value]
                                predicateType:DKPredicateTypeEndsWith
                                         info:[NSDictionary dictionaryWithObjectsAndKeys:
                                               key, @"column",
                                               value, @"value",
                                               nil]]];
    
    return self;
    
}

- (id)where:(NSString *)key doesntEndWith:(NSString *)value {
    
    [self where:[DKPredicate withPredicate:[NSPredicate predicateWithFormat:@"NOT %K ENDSWITH[cd] %@", key, value]
                                predicateType:DKPredicateTypeDoesntEndWith
                                         info:[NSDictionary dictionaryWithObjectsAndKeys:
                                               key, @"column",
                                               value, @"value",
                                               nil]]];
    
    return self;
    
}

- (id)where:(NSString *)key contains:(NSString *)value {
    
    [self where:[DKPredicate withPredicate:[NSPredicate predicateWithFormat:@"%K CONTAINS[cd] %@", key, value]
                                predicateType:DKPredicateTypeContains
                                         info:[NSDictionary dictionaryWithObjectsAndKeys:
                                               key, @"column",
                                               value, @"value",
                                               nil]]];
    
    return self;
    
}

- (id)where:(NSString *)key like:(NSString *)value {
    
    [self where:[DKPredicate withPredicate:[NSPredicate predicateWithFormat:@"%K LIKE[cd] %@", key, value]
                                predicateType:DKPredicateTypeLike
                                         info:[NSDictionary dictionaryWithObjectsAndKeys:
                                               key, @"column",
                                               value, @"value",
                                               nil]]];
    
    return self;
    
}

- (id)where:(NSString *)key greaterThan:(id)value {
    
    [self where:[DKPredicate withPredicate:[NSPredicate predicateWithFormat:@"%K > %@", key, value]
                                predicateType:DKPredicateTypeGreaterThan
                                         info:[NSDictionary dictionaryWithObjectsAndKeys:
                                               key, @"column",
                                               value, @"value",
                                               nil]]];
    
    return self;
}

- (id)where:(NSString *)key greaterThanOrEqualTo:(id)value {
    
    [self where:[DKPredicate withPredicate:[NSPredicate predicateWithFormat:@"%K >= %@", key, value]
                                predicateType:DKPredicateTypeGreaterThanOrEqualTo
                                         info:[NSDictionary dictionaryWithObjectsAndKeys:
                                               key, @"column",
                                               value, @"value",
                                               nil]]];
    
    return self;
    
}

- (id)where:(NSString *)key lessThan:(id)value {
    
    [self where:[DKPredicate withPredicate:[NSPredicate predicateWithFormat:@"%K < %@", key, value]
                                predicateType:DKPredicateTypeLessThan
                                         info:[NSDictionary dictionaryWithObjectsAndKeys:
                                               key, @"column",
                                               value, @"value",
                                               nil]]];
    
    return self;
    
}

- (id)where:(NSString *)key lessThanOrEqualTo:(id)value {
    
    [self where:[DKPredicate withPredicate:[NSPredicate predicateWithFormat:@"%K <= %@", key, value]
                                predicateType:DKPredicateTypeLessThanOrEqualTo
                                         info:[NSDictionary dictionaryWithObjectsAndKeys:
                                               key, @"column",
                                               value, @"value",
                                               nil]]];
    
    return self;
    
}

- (id)where:(NSString *)key between:(id)first andThis:(id)second {
    
    [self where:[DKPredicate withPredicate:[NSPredicate predicateWithFormat:@"(%K >= %@) AND (%K < %@)", key, first, key, second]
                                predicateType:DKPredicateTypeBetween
                                         info:[NSDictionary dictionaryWithObjectsAndKeys:
                                               key, @"column",
                                               first, @"first",
                                               second, @"second",
                                               nil]]];
    
    return self;
    
}

- (id)orderBy:(NSString *)column ascending:(BOOL)ascending {
    
    // Create the sort descriptor
    NSSortDescriptor * sort = [[NSSortDescriptor alloc] initWithKey:column
                                                          ascending:ascending];
    
    // Add it to the sorters array
    [self.sorters addObject:sort];
    
    // Release the sort
    [sort release];
    
    return self;
    
}

- (id)offset:(int)value {
    
    // Set the offset
    self.offset = [NSNumber numberWithInt:value];
    
    return self;
    
}

- (id)limit:(int)value {
    
    // Set the limit
    self.limit = [NSNumber numberWithInt:value];
    
    return self;
    
}

- (id)batchSize:(int)value {
    
    // Set the batch size
    self.batchSize = [NSNumber numberWithInt:value];
    
    return self;
    
}

- (NSCompoundPredicate *)compoundPredicate {
    
    // Collect all the predicates
    NSMutableArray * collectedPredicates = [NSMutableArray array];
    for (DKPredicate * relPredicate in predicates) {
        [collectedPredicates addObject:relPredicate.predicate];
    }
    
    // Add the predicates to a NSCompoundPredicate
    NSCompoundPredicate * compoundPredicate = [[NSCompoundPredicate alloc] initWithType:NSAndPredicateType
                                                                          subpredicates:collectedPredicates];
    
    return [compoundPredicate autorelease];
    
}

- (NSString *)compoundPredicateKey {
    
    return [[self.compoundPredicate predicateFormat] md5];
    
}

- (void)setLastPerformDate:(NSDate *)value {
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setValue:value forKey:[NSString stringWithFormat:@"DKPredicateBuilder/%@", [self compoundPredicateKey]]];
    [userDefaults synchronize];
    
}

- (NSDate *)lastPerformDate {
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
    return (NSDate *)[userDefaults valueForKey:[NSString stringWithFormat:@"DKPredicateBuilder/%@", [self compoundPredicateKey]]];
    
}

- (void)dealloc {
    
    [predicates release];
    [sorters release];
    [columns release];
    
    [limit release];
    [offset release];
    [batchSize release];
    
    [super dealloc];
    
}

@end