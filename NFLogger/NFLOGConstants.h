//
//  NFLConstants.h
//  NFLogger
//
//  Created by Nilesh Agrawal on 1/25/17.
//  Copyright © 2017 Nilesh Agrawal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NFLOGConstants : NSObject

#define allTrim( object ) [object stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ]
#define booleanString(BOOL_VAL) [NSString stringWithFormat:@"%@",BOOL_VAL == YES ? @"YES" : @"NO"]

#pragma mark - HouseKeeping Constants
extern NSString  * const NFLOG_SDK_VERSION;
extern NSString  * const NFLOG_APP_KEY;
extern NSString  * const NFLOG_DEVICE_ID_KEY;

#pragma mark - Event Types
extern NSString *  const NFLOG_SPECIFIC_TIME_EVENT ;
extern NSString *  const NFLOG_START_ACTIVE_TIME_EVENT;
extern NSString *  const NFLOG_END_TIME_EVENT;

#pragma mark - Table Names
extern NSString  * const NFLOG_ACTIVE_EVENT_TABLE_NAME;
extern NSString  * const NFLOG_SPECIFIC_TIME_EVENT_TABLE_NAME;

#pragma mark - Specific Time Event 
extern NSString * const NFLOG_SPECIFIC_TIME_EVENT_ROW_ID_COL;
extern NSString * const NFLOG_SPECIFIC_TIME_EVENT_NAME_COL;
extern NSString * const NFLOG_SPECIFIC_TIME_EVENT_TYPE_COL;
extern NSString * const NFLOG_SPECIFIC_TIME_EVENT_PARAMETERS_COL;
extern NSString * const NFLOG_SPECIFIC_TIME_EVENT_TIMESTAMP_COL;

#pragma mark - Active Time Event
extern NSString * const NFLOG_ACTIVE_TIME_EVENT_ROW_ID_COL;
extern NSString * const NFLOG_ACTIVE_TIME_EVENT_NAME_COL;
extern NSString * const NFLOG_ACTIVE_TIME_EVENT_TYPE_COL;
extern NSString * const NFLOG_ACTIVE_TIME_EVENT_PARAMETERS_COL;
extern NSString * const NFLOG_ACTIVE_TIME_EVENT_START_TIME_COL;
extern NSString * const NFLOG_ACTIVE_TIME_EVENT_END_TIME_COL;

#pragma mark - JSON Keys
extern NSString * const NFLOG_JSON_KEY_EVENT_NAME ;
extern NSString * const NFLOG_JSON_KEY_EVENT_PARAMETERS ;
extern NSString * const NFLOG_JSON_KEY_EVENT_TMESTAMP ;
extern NSString * const NFLOG_JSON_KEY_EVENT_START_TIMESTAMP ;
extern NSString * const NFLOG_JSON_KEY_EVENT_TIME_SPENT;
extern NSString * const NFLOG_JSON_KEY_HDR;
extern NSString * const NFLOG_JSON_KEY_EVENTS;

@end
