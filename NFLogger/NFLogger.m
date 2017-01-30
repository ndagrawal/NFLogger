//
//  NFLog.m
//  NFLogger
//
//  Created by Nilesh Agrawal on 1/25/17.
//  Copyright © 2017 Nilesh Agrawal. All rights reserved.
//

#import "NFLogger.h"
#import "NFLOGConstants.h"
#import "NFLOGRequestManager.h"
#import "NFLOGUtility.h"
#import "NFLOGBehaviour.h"
#import "NFLOGDisabledBehaviour.h"
#import "NFLOGAutoBehaviour.h"
#import "NFLOGManualBehaviour.h"
#import "NFLOGLogger.h"

static NFLogger * sharedLog;

@interface NFLogger()
@property NSInteger uploadInterval;
@property id<NFLOGBehaviour> logBehaviour;
@end

@implementation NFLogger
@synthesize uploadInterval = _uploadInterval;
@synthesize logBehaviour = _logBehaviour;

+(id)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedLog = [[NFLogger alloc] init];
    });
    return sharedLog;
}

/*
 Table Creation :
 Method tells if the initialization of the sdk was successful.
 Table Creation to store the specific time event , and active event, Table creation happens only once, no matter how many times this API is called.
 
 Policy Management :
 Setting logBehaviour - user can set the behaviour in runtime, either through initialization api or in furture through downloaded policy. Temporarily, I have taken policy information from the user, while initializing, in future such information can be taken through a user defined policy which can be downloaded.
 */

+(BOOL)initializeSDKWithMode:(NFLOGMODE)mode{
    
    __block BOOL successful = YES;
    //Create Tables.
    [[NFLOGRequestManager sharedInstance] createTableforEventType:NFLOG_SPECIFIC_TIME_EVENT];
    [[NFLOGRequestManager sharedInstance] createTableforEventType:NFLOG_START_ACTIVE_TIME_EVENT];

    //Policy Reading
    if(mode == NFLOGAutoCapture){
        [[self sharedInstance] setLogBehaviour:[[NFLOGAutoBehaviour alloc] init]];
    }else if(mode == NFLOGManualCapture){
        [[self sharedInstance] setLogBehaviour:[[NFLOGManualBehaviour alloc] init]];
    }
    
    //Setting inital Logging Level.
    [[NFLOGLogger sharedInstance] setLogLevel:NFLOG_LEVEL_NONE];
    
    return successful;
}

+(void)setUploadInterval:(NSInteger)seconds{
    [[NFLOGRequestManager sharedInstance] setUploadInterval:seconds];
}

+(NSString *)getNFLoggerVersion{
    return NFLOG_SDK_VERSION;
}

+(void)setLogLevelOfNFLog:(NFLogLevel)logLevel{
    [[NFLOGLogger sharedInstance] setLogLevel:logLevel];
}

+(void)logEvent:(NSString *)eventName{
    if(eventName == nil || [allTrim(eventName) length] == 0){
        NFLogDebug(@"event name is nil so failed to log event");
        return;
    }
    [[[self sharedInstance] logBehaviour] logEvent:eventName withParameters:nil completionBlock:nil];
}


+(void)logEvent:(NSString *)eventName withParameters:(NSDictionary *)parameters{
    if(eventName == nil || [allTrim(eventName) length] == 0){
        NFLogDebug(@"event name is nil so failed to log event");
        return;
    }
    [[[self sharedInstance] logBehaviour] logEvent:eventName withParameters:parameters completionBlock:nil];
}


+(void)logEvent:(NSString *)eventName withParameters:(NSDictionary *)parameters completionBlock:(void (^)(NFLOGRecordStatus recordStatus))completionBlock{
    if(eventName == nil || [allTrim(eventName) length] == 0){
        NFLogDebug(@"event name is nil so failed to log event");
        completionBlock(NFLOGEventRecordFailed);
        return;
    }
    [[[self sharedInstance] logBehaviour] logEvent:eventName withParameters:parameters completionBlock:completionBlock];
}

+(void)startActiveEvent:(NSString *)eventName{
    if(eventName == nil ||[allTrim(eventName) length] == 0){
        NFLogDebug(@"event name is nil so failed to log event");
        return;
    }
    [[[self sharedInstance] logBehaviour] startActiveEvent:eventName withParameters:nil completionBlock:nil];
}

+(void)startActiveEvent:(NSString *)eventName withParameters:(NSDictionary *)paramters{
    if(eventName == nil || [allTrim(eventName) length] == 0){
        NFLogDebug(@"event name is nil so failed to log event");
        return;
    }
    [[[self sharedInstance] logBehaviour] startActiveEvent:eventName withParameters:paramters completionBlock:nil];
}

+(void)startActiveEvent:(NSString *)eventName withParameters:(NSDictionary *)paramters completionBlock:(void (^)(NFLOGRecordStatus recordStatus)) completionBlock{
    if(eventName == nil || [allTrim(eventName) length] == 0){
        NFLogDebug(@"event name is nil so failed to log event");
        completionBlock(NFLOGEventRecordFailed);
        return;
    }
    [[[self sharedInstance] logBehaviour] startActiveEvent:eventName withParameters:paramters completionBlock:completionBlock];
}

+(void)endActiveEvent:(NSString *)eventName{
    if(eventName == nil || [allTrim(eventName) length] == 0){
        NFLogDebug(@"event name is nil so failed to log event");
        return;
    }
    [[[self sharedInstance] logBehaviour] endActiveEvent:eventName completionBlock:nil];
}

+(void)endActiveEvent:(NSString *)eventName completionBlock:(void (^)(NFLOGRecordStatus recordStatus))completionBlock{
    if(eventName == nil || [allTrim(eventName) length] == 0){
        NFLogDebug(@"event name is nil so failed to log event");
        completionBlock(NFLOGEventRecordFailed);
        return;
    }
    [[[self sharedInstance] logBehaviour] endActiveEvent:eventName completionBlock:completionBlock];
}

@end
