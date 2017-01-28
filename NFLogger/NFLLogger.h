//
//  NFLLogger.h
//  NFLogger
//
//  Created by Nilesh Agrawal on 1/25/17.
//  Copyright © 2017 Nilesh Agrawal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NFLog.h"

@interface NFLLogger : NSObject{
}

@property  NFLogLevel logLevel;

+(NFLLogger *) sharedInstance;

#define LOG_LEVEL [[NFLLogger sharedInstance] logLevel]

#define  NFLogError(fmt, ...)  \
if ((NFLOG_LEVEL_ERROR & LOG_LEVEL) == NFLOG_LEVEL_ERROR)  NSLog((@"[NFLOGGER][ERROR][Method %s] [Line %d] " fmt),__PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

#define  NFLogDebug(fmt, ...)  \
if ((NFLOG_LEVEL_DEBUG & LOG_LEVEL) == NFLOG_LEVEL_DEBUG)  NSLog((@"[NFLOGGER][DEBUG][Method %s] [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define  NFLogVerbose(fmt, ...)  \
if ((NFLOG_LEVEL_VERBOSE & LOG_LEVEL) == NFLOG_LEVEL_VERBOSE)  NSLog((@"[NFLOGGER][VERBOSE][Method %s] [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

@end


