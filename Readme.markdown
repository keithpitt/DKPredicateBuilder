# DKPredicateBuilder

The predicate builder is an easy way to generate `NSPredicate` objects for use
with your Core Data and NSArray queries.

```objective-c
#import "DKPredicateBuilder.h"

DKPredicateBuilder * predicateBuilder = [[DKPredicateBuilder alloc] init];

[predicateBuilder where:@"name" equals:@"keith"];
[predicateBuilder where:@"count" greaterThan:[NSNumber numberWithInt:12]];
[predicateBuilder where:@"username" isNull:NO];

NSLog(@"%@", [compoundPredicate predicateFormat]);
// "name == \"keith\" AND count > 12 AND username != nil"

[predicateBuilder release];
```

You can also chain together predicates like this

```objective-c
[[predicateBuilder where:@"name" equals:@"keith"] where:@"username" isNull:NO]
```

`DKPredicateBuilder` also ships with a way to use the predicate builder
with `NSArray` objects.

```objective-c
#import "DKArrayQuery.h"

NSArray * namesArray = [NSArray arrayWithObjects:
                            [NSDictionary dictionaryWithObjectsAndKeys:@"Kevin", @"first_name", nil],
                            [NSDictionary dictionaryWithObjectsAndKeys:@"Keith", @"first_name", nil],
                            [NSDictionary dictionaryWithObjectsAndKeys:@"Jordan", @"first_name", nil],
                            [NSDictionary dictionaryWithObjectsAndKeys:@"Mario", @"first_name", nil],
                            [NSDictionary dictionaryWithObjectsAndKeys:@"Dirk", @"first_name", nil],
                            nil];

DKArrayQuery * arrayQuery = [DKArrayQuery queryWithArray:namesArray];

[arrayQuery where:@"first_name" startsWith:@"Ke"];
[arrayQuery orderBy:@"first_name" ascending:YES];

[arrayQuery perform:^(NSArray * records) {
  // Returns an array with in this order;
  //   [NSDictionary dictionaryWithObjectsAndKeys:@"Keith", @"first_name", nil]
  //   [NSDictionary dictionaryWithObjectsAndKeys:@"Kevin", @"first_name", nil]
}];
```

There is also an NSArray category to make creating `DKArrayQuery`
objects easy.

```objective-c
#import "NSArray+ArrayQuery.h"

DKArrayQuery * arrayQuery = [[namesArray query] where:@"first_name" isNull:NO];
```

`DKArrayQuery` also makes it easy to run these calculations in a
background thread. This is usefull for arrays with many records.

```objective-c
[arrayQuery perform:^(NSArray * records) {
  // ...
} background:YES];
```

It is used in the apps written by [Mostly Disco](http://www.mostlydisco.com)
and [The Frontier Group](http://www.thefrontiergroup.com.au)

## Installation

Copy the files within `Classes` into to your project folder, and add them to your
XCode project.

You will need to add [DKSupport](https://github.com/keithpitt/DKSupport)
to your project.

## API

`- (id)where:(DKPredicate *)predicate;`

Add a custom NSPredicate to the builder

`- (id)where:(NSString *)key isTrue:(BOOL)value;`

A predicate to check whether or not the key is `TRUE` or `FALSE`

```objective-c
// All records where 'active' is TRUE
[predicateBuilder where:@"active" isTrue:YES]

// All records where 'active' is FALSE
[predicateBuilder where:@"active" isTrue:NO]
```

`- (id)where:(NSString *)key isFalse:(BOOL)value;`

The compliment of `isTrue`

```objective-c
// All records where 'active' is FALSE
[predicateBuilder where:@"active" isFalse:YES]

// All records where 'active' is TRUE
[predicateBuilder where:@"active" isFalse:NO]
```

`- (id)where:(NSString *)key isNull:(BOOL)value;`

The key has a `NULL` value

```objective-c
[predicateBuilder where:@"username" isNull:YES];
```

`- (id)where:(NSString *)key isNotNull:(BOOL)value;`

The key doesn't have a `NULL` value

```objective-c
[predicateBuilder where:@"username" isNotNull:YES];
```

`- (id)where:(NSString *)key equals:(id)value;`

The key equals the value

```objective-c
[predicateBuilder where:@"username" equals:@"keithpitt"];
```

`- (id)where:(NSString *)key doesntEqual:(id)value;`

The key doesn't equal the value

```objective-c
[predicateBuilder where:@"username" doesntEqual:@"jordanmaguire"];
```

`- (id)where:(NSString *)key isIn:(NSArray *)values;`

The key is in one of the values

```objective-c
[predicateBuilder where:@"username" isIn:[NSArray arrayWithObjects:@"keithpitt", @"jordanmaguire", nil]];
```

`- (id)where:(NSString *)key isNotIn:(NSArray *)values;`

They key is not in one of the values

```objective-c
[predicateBuilder where:@"username" isNotIn:[NSArray isNotIn:@"stevejobs", @"waz", nil]];
```

`- (id)where:(NSString *)key startsWith:(NSString *)value;`

The key starts with the value

```objective-c
[predicateBuilder where:@"username" startsWith:@"kei"];
```

`- (id)where:(NSString *)key doesntStartWith:(NSString *)value;`

The key doesn't start with the value

```objective-c
[predicateBuilder where:@"username" doesntStartWith:@"jor"];
```

`- (id)where:(NSString *)key endsWith:(NSString *)value;`

The key ends with the value

```objective-c
[predicateBuilder where:@"username" endsWith:@"pitt"];
```

`- (id)where:(NSString *)key doesntEndWith:(NSString *)value;`

The key doens't end with the value

```objective-c
[predicateBuilder where:@"username" doesntEndWith:@"maguire"];
```

`- (id)where:(NSString *)key contains:(NSString *)value;`

The key `CONTAINS` the value

```objective-c
[predicateBuilder where:@"username" contains:@"eith"];
```

`- (id)where:(NSString *)key like:(NSString *)value;`

The key is `LIKE` the value

```objective-c
[predicateBuilder where:@"username" like:@"keith"];
```

`- (id)where:(NSString *)key greaterThan:(id)value;`

The key is more than the value

```objective-c
[predicateBuilder where:@"views" greaterThan:[NSNumber numberWithInt:12]];
```

`- (id)where:(NSString *)key greaterThanOrEqualTo:(id)value;`

The key is more than or equal to the value

```objective-c
[predicateBuilder where:@"views" greaterThanOrEqualTo:[NSNumber numberWithInt:12]];
```

`- (id)where:(NSString *)key lessThan:(id)value;`

The key is less than the value

```objective-c
[predicateBuilder where:@"views" lessThan:[NSNumber numberWithInt:12]];
```

`- (id)where:(NSString *)key lessThanOrEqualTo:(id)value;`

The key is less than or equal to the value

```objective-c
[predicateBuilder where:@"views" lessThanOrEqualTo:[NSNumber numberWithInt:12]];
```

`- (id)where:(NSString *)key between:(id)first andThis:(id)second;`

The key is between the first value and the second value

```objective-c
[predicateBuilder where:@"createdAt" between:[[NSDate date] beginingOfDay] andThis:[[NSDate date] endOfDay]];
```

`- (id)orderBy:(NSString *)column ascending:(BOOL)ascending;`

Creates an NSSortDescriptor and add it to the `sorters` property on the
`DKPropertyBuilder`

```objective-c
[predicateBuilder orderBy:@"views" ascending:YES];
```

`- (id)limit:(int)value;`

Specify a limit of the query

```objective-c
[predicateBuilder limit:12];
```

`- (id)offset:(int)value;`

Specify an offset for the query

```objective-c
[predicateBuilder offset:63];
```

`- (NSCompoundPredicate *)compoundPredicate;`

Returns an `NSCompoundPredicate` with all the predicates defined

`- (NSString *)compoundPredicateKey;`

Returns an MD5 hash of the NSCompoundPredicate. This is usefull for cache keys.

## Running Specs

Before running the specs, you'll need checkout the git submodules:

```
$ git submodule init
$ git submodule update
```

Then, to run the specs, open [DKPredicateBuilder.xcodeproj](https://github.com/keithpitt/DKPredicateBuilder/tree/master/DKPredicateBuilder.xcodeproj) project, and run the `Specs` target. You will need to

## Libraries Used

* http://code.google.com/p/json-framework
* https://github.com/petejkim/expecta
* https://github.com/pivotal/cedar
* http://boredzo.org/iso8601unparser/
* http://regexkit.sourceforge.net/#RegexKitLite
* https://github.com/fpillet/NSLogger
* https://github.com/adamelliot/Inflections

## Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Send me a pull request. Bonus points for topic branches.

## Contributers

* [Keith Pitt](http://www.keithpitt.com)
* [Jordan Maguire](https://github.com/jordanmaguire)
* [The Frontier Group](http://www.thefrontiergroup.com.au)
* [Mostly Disco](http://www.mostlydisco.com)

## License

DKPredicateBuilder is licensed under the MIT License:

  Copyright (c) 2011 Keith Pitt (http://www.keithpitt.com/)

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
