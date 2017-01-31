//
//  NFLConstants.m
//  NFLogger
//
//  Created by Nilesh Agrawal on 1/25/17.
//  Copyright © 2017 Nilesh Agrawal. All rights reserved.
//

#import "NFLOGConstants.h"

@implementation NFLOGConstants

#pragma mark - HouseKeeping Constants
NSString  * const NFLOG_SDK_VERSION                         = @"1.0.0";
NSString  * const NFLOG_APP_KEY                             = @"app_id";
NSString  * const NFLOG_DEVICE_ID_KEY                       = @"device_id";
NSString  * const NFLOG_UPLOAD_URL                          =@"upload_url";

#pragma mark - Configuration Parameters
NSString  * const NFLOG_APP_KEY_VALUE                       =@"xyz@123";
NSString  * const NFLOG_UPLOAD_URL_VALUE                    =@"http://httpbin.org/post/";

#pragma mark - Event Table Names
NSString  * const NFLOG_ACTIVE_EVENT_TABLE_NAME             = @"ActiveEventTable";
NSString  * const NFLOG_SPECIFIC_TIME_EVENT_TABLE_NAME      = @"SpecificEventTable";

#pragma mark - Event Types
NSString *  const NFLOG_SPECIFIC_TIME_EVENT                 = @"SpecificEventTime";
NSString *  const NFLOG_START_ACTIVE_TIME_EVENT             = @"ActiveEventTime";
NSString *  const NFLOG_END_TIME_EVENT                      = @"EndEventTime";

#pragma mark - Specific Time Event
NSString * const NFLOG_SPECIFIC_TIME_EVENT_ROW_ID_COL       = @"specific_event_id";
NSString * const NFLOG_SPECIFIC_TIME_EVENT_NAME_COL         = @"specific_event_name";
NSString * const NFLOG_SPECIFIC_TIME_EVENT_TYPE_COL         = @"specific_event_type";
NSString * const NFLOG_SPECIFIC_TIME_EVENT_PARAMETERS_COL   = @"specific_event_parameters";
NSString * const NFLOG_SPECIFIC_TIME_EVENT_TIMESTAMP_COL    = @"specific_event_timestamp";

#pragma mark - Active Time Event
NSString * const NFLOG_ACTIVE_TIME_EVENT_ROW_ID_COL         = @"active_event_id";
NSString * const NFLOG_ACTIVE_TIME_EVENT_NAME_COL           = @"active_event_name";
NSString * const NFLOG_ACTIVE_TIME_EVENT_TYPE_COL           = @"active_event_type";
NSString * const NFLOG_ACTIVE_TIME_EVENT_PARAMETERS_COL     = @"active_event_parameters";
NSString * const NFLOG_ACTIVE_TIME_EVENT_START_TIME_COL     = @"active_event_start_time";
NSString * const NFLOG_ACTIVE_TIME_EVENT_END_TIME_COL       = @"active_event_end_time";


#pragma mark - JSON Keys
NSString * const NFLOG_JSON_KEY_EVENT_NAME                  = @"event";
NSString * const NFLOG_JSON_KEY_EVENT_PARAMETERS            = @"parameters";
NSString * const NFLOG_JSON_KEY_EVENT_TMESTAMP              = @"timestamp";
NSString * const NFLOG_JSON_KEY_EVENT_TYPE                  = @"type";
NSString * const NFLOG_JSON_KEY_EVENT_START_TIMESTAMP       = @"start_timestamp";
NSString * const NFLOG_JSON_KEY_EVENT_TIME_SPENT            = @"time_spent";
NSString * const NFLOG_JSON_KEY_HDR                         = @"hdr";
NSString * const NFLOG_JSON_VALUE_SPECIFIC_EVENT_TYPE       = @"specific_event";
NSString * const NFLOG_JSON_VALUE_ACTIVE_EVENT_TYPE         = @"active_event";
NSString * const NFLOG_JSON_KEY_EVENTS                      = @"events";

@end
