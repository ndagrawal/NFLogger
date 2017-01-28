//
//  NFLConstants.h
//  NFLogger
//
//  Created by Nilesh Agrawal on 1/25/17.
//  Copyright © 2017 Nilesh Agrawal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NFLOGConstants : NSObject

#pragma mark - HouseKeeping Constants

extern NSString  * const NFLOG_SDK_VERSION;

#pragma mark - Table Names

extern NSString  * const NFLOG_ACTIVE_EVENT_TABLE_NAME;
extern NSString  * const NFLOG_SPECIFIC_TIME_EVENT_TABLE_NAME;

#pragma mark - Event Types

extern NSString *  const NFLOG_SPECIFIC_TIME_EVENT ;
extern NSString *  const NFLOG_START_ACTIVE_TIME_EVENT;
extern NSString *  const NFLOG_END_TIME_EVENT ;

@end
