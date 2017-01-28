//
//  NFLLogger.m
//  NFLogger
//
//  Created by Nilesh Agrawal on 1/25/17.
//  Copyright © 2017 Nilesh Agrawal. All rights reserved.
//

#import "NFLLogger.h"

static NFLLogger * sharedLogger;

@implementation NFLLogger

+(id)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedLogger = [[NFLLogger alloc] init];
    });
    return sharedLogger;
}

@end
