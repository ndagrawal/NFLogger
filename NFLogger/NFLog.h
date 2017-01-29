//
//  NFLog.h
//  NFLogger
//
//  Created by Nilesh Agrawal on 1/25/17.
//  Copyright © 2017 Nilesh Agrawal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NFLog : NSObject

typedef NS_ENUM(NSUInteger, NFLOGRecordStatus) {
    NFLOGEventRecordFailed  = 0,
    NFLOGEventRecorded      = (1 << 0),
    NFLOGDisabled           = (1 << 2),
};

typedef NS_ENUM(NSUInteger, NFLOGMODE) {
    NFLOGAutoCapture        = 0,
    NFLOGManualCapture      = (1 << 0),
};

typedef NS_ENUM(NSInteger, NFLogLevel) {
    NFLOG_LEVEL_NONE          = 0,
    NFLOG_LEVEL_ERROR         = (1 << 0),
    NFLOG_LEVEL_DEBUG         = (1 << 1),
    NFLOG_LEVEL_VERBOSE       = (1 << 2)
};


+(BOOL)initializeSDKWithMode:(NFLOGMODE)mode;

+(void)setUploadInterval:(NSInteger)seconds;

+(NSString *)getNFLoggerVersion;

+(void)setLogLevelOfNFLog:(NFLogLevel)logLevel;

+(void)logEvent:(NSString *)eventName;

+(void)logEvent:(NSString *)eventName withParameters:(NSDictionary *)parameters;

+(void)logEvent:(NSString *)eventName withParameters:(NSDictionary *)parameters completionBlock:(void (^)(NFLOGRecordStatus recordStatus))completionBlock;

+(void)startActiveEvent:(NSString *)eventName;

+(void)startActiveEvent:(NSString *)eventName withParameters:(NSDictionary *)paramters;

+(void)startActiveEvent:(NSString *)eventName withParameters:(NSDictionary *)paramters completionBlock:(void (^)(NFLOGRecordStatus recordStatus)) completionBlock;

+(void)endActiveEvent:(NSString *)eventName;

+(void)endActiveEvent:(NSString *)eventName completionBlock:(void (^)(NFLOGRecordStatus recordStatus))completionBlock;

@end
