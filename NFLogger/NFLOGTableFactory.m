//
//  NFLOGTableFactory.m
//  NFLogger
//
//  Created by Nilesh Agrawal on 1/25/17.
//  Copyright © 2017 Nilesh Agrawal. All rights reserved.
//

#import "NFLOGTableFactory.h"
#import "NFLOGConstants.h"
#import "NFLOGSpecificEventTable.h"
#import "NFLOGActiveEventTable.h"

@implementation NFLOGTableFactory

+(id<NFLOGEventTable>)getTableInstance:(NSString *)tableName{
    id<NFLOGEventTable> table = nil;
    if([tableName isEqualToString:NFLOG_START_ACTIVE_TIME_EVENT] || [tableName isEqualToString:NFLOG_END_TIME_EVENT]){
        return [[NFLOGActiveEventTable alloc] init];
    }else if([tableName isEqualToString:NFLOG_SPECIFIC_TIME_EVENT]){
        return [[NFLOGSpecificEventTable alloc] init];
    }
    return table;
}

@end
