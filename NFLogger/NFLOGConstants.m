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
NSString  * const NFLOG_SDK_VERSION = @"1.0.0";

#pragma mark - Event Table Names
NSString  * const NFLOG_ACTIVE_EVENT_TABLE_NAME = @"ActiveEventTable";
NSString  * const NFLOG_SPECIFIC_TIME_EVENT_TABLE_NAME = @"SpecificEventTable";

#pragma mark - Event Types
NSString *  const NFLOG_SPECIFIC_TIME_EVENT = @"SpecificEventTime";
NSString *  const NFLOG_START_ACTIVE_TIME_EVENT = @"ActiveEventTime";
NSString *  const NFLOG_END_TIME_EVENT = @"EndEventTime";

@end
