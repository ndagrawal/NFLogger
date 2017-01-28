//
//  NFLog.m
//  NFLogger
//
//  Created by Nilesh Agrawal on 1/25/17.
//  Copyright © 2017 Nilesh Agrawal. All rights reserved.
//

#import "NFLog.h"
#import "NFLOGConstants.h"
#import "NFLOGDatabaseManager.h"
#import "NFLOGRequestManager.h"
#import "NFLOGEvent.h"
#import "NFLOGUtility.h"


#import "NFLOGBehaviour.h"
#import "NFLOGDisabledBehaviour.h"
#import "NFLOGAutoBehaviour.h"
#import "NFLOGManualBehaviour.h"
#import "NFLLogger.h"

static NFLog * sharedLog;

@interface NFLog()
@property NSInteger uploadInterval;
@property id<NFLOGBehaviour> logBehaviour;
@end

@implementation NFLog
@synthesize uploadInterval = _uploadInterval;
@synthesize logBehaviour = _logBehaviour;

+(id)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedLog = [[NFLog alloc] init];
    });
    return sharedLog;
}

/*
 * Method tells if the initialization of the sdk was successful.
 */
+(BOOL)initializeSDKWithMode:(NFLOGMODE)mode{
    
    __block BOOL successful = YES;
    
    //Table Creation .
    [[NFLOGRequestManager sharedInstance] createTableforEventType:NFLOG_SPECIFIC_TIME_EVENT_TABLE_NAME withCompletionBlock:^(BOOL success) {
        successful &= success;
    }];
    
    [[NFLOGRequestManager sharedInstance] createTableforEventType:NFLOG_SPECIFIC_TIME_EVENT_TABLE_NAME withCompletionBlock:^(BOOL success) {
        successful &= success;
    }];
    
    //Policy Reading
    if(mode == NFLOGAutoCapture){
        [[self sharedInstance] setLogBehaviour:[[NFLOGAutoBehaviour alloc] init]];
    }else if(mode == NFLOGManualCapture){
        [[self sharedInstance] setLogBehaviour:[[NFLOGManualBehaviour alloc] init]];
    }
    //TODO: Implement Configuration Reading.
    //If configuration reading is not sucessful, then disable the sdk, rather than continuing to use it and return NO.
    //WE might have to create a concurrent initializerQueue which will do two things,
    //1. Create Tables (both table creation in one operation and nextly,
    //2. Read the configuration and store it.
    
    //Setting inital Logging Level.
    [[NFLLogger sharedInstance] setLogLevel:NFLOG_LEVEL_NONE];
    
    return successful;
}

+(void)setUploadInterval:(NSInteger)seconds{
    [[NFLOGRequestManager sharedInstance] setUploadInterval:seconds];
}

+(NSString *)getNFLoggerVersion{
    return NFLOG_SDK_VERSION;
}

+(void)setLogLevelOfNFLog:(NFLogLevel)logLevel{
    [[NFLLogger sharedInstance] setLogLevel:logLevel];
}

+(NFLOGRecordStatus)logEvent:(NSString *)eventName{
    return [[[self sharedInstance] logBehaviour] logEvent:eventName withParameters:nil];
}

+(NFLOGRecordStatus)logEvent:(NSString *)eventName withParameters:(NSDictionary *)parameters{
    return [[[self sharedInstance] logBehaviour] logEvent:eventName withParameters:parameters];
}

+(NFLOGRecordStatus)startActiveEvent:(NSString *)eventName{
    return [[[self sharedInstance] logBehaviour] startActiveEvent:eventName withParameters:nil];
}

+(NFLOGRecordStatus)endActiveEvent:(NSString *)eventName{
    return [[[self sharedInstance] logBehaviour] endActiveEvent:eventName withParameters:nil];
}

+(NFLOGRecordStatus)startActiveEvent:(NSString *)eventName withParameters:(NSDictionary *)paramters{
    return [[[self sharedInstance] logBehaviour] startActiveEvent:eventName withParameters:paramters];
}

+(NFLOGRecordStatus)endActiveEvent:(NSString *)eventName withParameters:(NSDictionary *)parameters{
    return [[[self sharedInstance] logBehaviour] endActiveEvent:eventName withParameters:parameters];
}

@end
