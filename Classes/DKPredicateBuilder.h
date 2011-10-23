//
//  DKPredicateBuilder.h
//  DiscoKit
//
//  Created by Keith Pitt on 12/07/11.
//  Copyright 2011 Mostly Disco. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DKPredicate.h"

typedef void (^DKQueryFinishBlock)(NSArray * records, NSError * error);

@interface DKPredicateBuilder : NSObject {
    
    NSMutableArray * predicates;
    NSMutableArray * sorters;
    
    NSNumber * limit;
    NSNumber * offset;
    
}

@property (nonatomic, retain) NSMutableArray * predicates;
@property (nonatomic, retain) NSMutableArray * sorters;
@property (nonatomic, retain) NSNumber * limit;
@property (nonatomic, retain) NSNumber * offset;

- (id)where:(DKPredicate *)predicate;

- (id)where:(NSString *)key isFalse:(BOOL)value;
- (id)where:(NSString *)key isTrue:(BOOL)value;

- (id)where:(NSString *)key isNull:(BOOL)value;
- (id)where:(NSString *)key isNotNull:(BOOL)value;

- (id)where:(NSString *)key equals:(id)value;
- (id)where:(NSString *)key doesntEqual:(id)value;

- (id)where:(NSString *)key isIn:(NSArray *)values;
- (id)where:(NSString *)key isNotIn:(NSArray *)values;

- (id)where:(NSString *)key startsWith:(NSString *)value;
- (id)where:(NSString *)key doesntStartWith:(NSString *)value;
- (id)where:(NSString *)key endsWith:(NSString *)value;
- (id)where:(NSString *)key doesntEndWith:(NSString *)value;

- (id)where:(NSString *)key contains:(NSString *)value;
- (id)where:(NSString *)key like:(NSString *)value;

- (id)where:(NSString *)key greaterThan:(id)value;
- (id)where:(NSString *)key greaterThanOrEqualTo:(id)value;
- (id)where:(NSString *)key lessThan:(id)value;
- (id)where:(NSString *)key lessThanOrEqualTo:(id)value;
- (id)where:(NSString *)key between:(id)first andThis:(id)second;

- (id)orderBy:(NSString *)column ascending:(BOOL)ascending;

- (id)limit:(int)value;
- (id)offset:(int)value;

- (NSCompoundPredicate *)compoundPredicate;

@end