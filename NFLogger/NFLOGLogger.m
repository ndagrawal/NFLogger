//
//  NFLLogger.m
//  NFLogger
//
//  Created by Nilesh Agrawal on 1/25/17.
//  Copyright © 2017 Nilesh Agrawal. All rights reserved.
//

#import "NFLOGLogger.h"

static NFLOGLogger * sharedLogger;

@implementation NFLOGLogger

+(id)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedLogger = [[NFLOGLogger alloc] init];
    });
    return sharedLogger;
}

@end
