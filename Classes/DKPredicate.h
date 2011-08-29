//
//  DKPredicate.h
//  DiscoKit
//
//  Created by Keith Pitt on 11/07/11.
//  Copyright 2011 Mostly Disco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

typedef enum {
    DKPredicateTypeIsTrue,
    DKPredicateTypeIsFalse,
    DKPredicateTypeIsNull,
    DKPredicateTypeIsNotNull,
    DKPredicateTypeEquals,
    DKPredicateTypeNotEquals,
    DKPredicateTypeIn,
    DKPredicateTypeNotIn,
    DKPredicateTypeLike,
    DKPredicateTypeContains,
    DKPredicateTypeBetween,
    DKPredicateTypeStartsWith,
    DKPredicateTypeDoesntStartWith,
    DKPredicateTypeEndsWith,
    DKPredicateTypeDoesntEndWith,
    DKPredicateTypeGreaterThan,
    DKPredicateTypeGreaterThanOrEqualTo,
    DKPredicateTypeLessThan,
    DKPredicateTypeLessThanOrEqualTo
} DKPredicateType;

@interface DKPredicate : NSObject {
    
    NSPredicate * predicate;
    NSDictionary * info;
    
    DKPredicateType predicateType;
    
}

@property (nonatomic, readonly) NSPredicate * predicate;
@property (nonatomic, readonly) NSDictionary * info;
@property (nonatomic, readonly) DKPredicateType predicateType;

+ (DKPredicate *)withPredicate:(NSPredicate *)predicate predicateType:(DKPredicateType)predicateType info:(NSDictionary *)dictionary;

- (id)initWithPredicate:(NSPredicate *)thePredicate predicateType:(DKPredicateType)thePredicateType info:(NSDictionary *)dictionary;
- (NSString *)predicateFormat;

@end