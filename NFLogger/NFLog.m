//
//  NFLog.m
//  NFLogger
//
//  Created by Nilesh Agrawal on 1/25/17.
//  Copyright © 2017 Nilesh Agrawal. All rights reserved.
//

#import "NFLog.h"
#import "NFLOGConstants.h"
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
    [[NFLOGRequestManager sharedInstance] createTableforEventType:NFLOG_SPECIFIC_TIME_EVENT];
    
    [[NFLOGRequestManager sharedInstance] createTableforEventType:NFLOG_START_ACTIVE_TIME_EVENT];
    
    
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
    //[[NFLOGRequestManager sharedInstance] validateTimer];
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

+(void)logEvent:(NSString *)eventName{
    if(eventName == nil || allTrim(eventName)){
        NFLogDebug(@"event name is nil so failed to log event");
        return;
    }
    [[[self sharedInstance] logBehaviour] logEvent:eventName withParameters:nil completionBlock:nil];
}


+(void)logEvent:(NSString *)eventName withParameters:(NSDictionary *)parameters{
    if(eventName == nil || allTrim(eventName)){
        NFLogDebug(@"event name is nil so failed to log event");
        return;
    }
    [[[self sharedInstance] logBehaviour] logEvent:eventName withParameters:parameters completionBlock:nil];
}


+(void)logEvent:(NSString *)eventName withParameters:(NSDictionary *)parameters completionBlock:(void (^)(NFLOGRecordStatus recordStatus))completionBlock{
    if(eventName == nil || allTrim(eventName)){
        NFLogDebug(@"event name is nil so failed to log event");
        completionBlock(NFLOGEventRecordFailed);
        return;
    }
    [[[self sharedInstance] logBehaviour] logEvent:eventName withParameters:parameters completionBlock:completionBlock];
}

+(void)startActiveEvent:(NSString *)eventName{
    if(eventName == nil || allTrim(eventName)){
        NFLogDebug(@"event name is nil so failed to log event");
        return;
    }
    [[[self sharedInstance] logBehaviour] startActiveEvent:eventName withParameters:nil completionBlock:nil];
}

+(void)startActiveEvent:(NSString *)eventName withParameters:(NSDictionary *)paramters{
    if(eventName == nil || allTrim(eventName)){
        NFLogDebug(@"event name is nil so failed to log event");
        return;
    }
    [[[self sharedInstance] logBehaviour] startActiveEvent:eventName withParameters:paramters completionBlock:nil];
}

+(void)startActiveEvent:(NSString *)eventName withParameters:(NSDictionary *)paramters completionBlock:(void (^)(NFLOGRecordStatus recordStatus)) completionBlock{
    if(eventName == nil || allTrim(eventName)){
        NFLogDebug(@"event name is nil so failed to log event");
        completionBlock(NFLOGEventRecordFailed);
        return;
    }
    [[[self sharedInstance] logBehaviour] startActiveEvent:eventName withParameters:paramters completionBlock:completionBlock];
}

+(void)endActiveEvent:(NSString *)eventName{
    if(eventName == nil || allTrim(eventName)){
        NFLogDebug(@"event name is nil so failed to log event");
        return;
    }
    [[[self sharedInstance] logBehaviour] endActiveEvent:eventName completionBlock:nil];
}

+(void)endActiveEvent:(NSString *)eventName completionBlock:(void (^)(NFLOGRecordStatus recordStatus))completionBlock{
    if(eventName == nil || allTrim(eventName)){
        NFLogDebug(@"event name is nil so failed to log event");
        completionBlock(NFLOGEventRecordFailed);
        return;
    }
    [[[self sharedInstance] logBehaviour] endActiveEvent:eventName completionBlock:completionBlock];
}

@end
