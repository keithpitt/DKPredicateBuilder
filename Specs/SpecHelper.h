//
//  SpecHelper.h
//  DiscoKit
//
//  Created by Keith Pitt on 21/06/11.
//  Copyright 2011 Mostly Disco. All rights reserved.
//

#if TARGET_OS_IPHONE
    #import <Cedar-iPhone/SpecHelper.h>
#else
    #import <Cedar/SpecHelper.h>
#endif

#define EXP_SHORTHAND
#import "Expecta.h"