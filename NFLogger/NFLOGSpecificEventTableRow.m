//
//  NFLOGSpecificEventTableRow.m
//  NFLogger
//
//  Created by Nilesh Agrawal on 1/25/17.
//  Copyright © 2017 Nilesh Agrawal. All rights reserved.
//

#import "NFLOGSpecificEventTableRow.h"
#import "NFLOGSqlParam.h"
#import "NFLOGConstants.h"
#import "NFLOGUtility.h"
#import "NFLLogger.h"
#define allTrim( object ) [object stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ]

@implementation NFLOGSpecificEventTableRow

@synthesize rowId = _rowId;
@synthesize eventName = _eventName;
@synthesize eventType = _eventType;
@synthesize eventParameters = _eventParameters;
@synthesize timestamp = _timestamp;

-(id)initWithEvent:(NFLOGEvent *)event{
    self = [super init];
    if(self){
        /*
         This setting of rowId to zero is temporary, while we retrive the row, after select query, we get the actual value of rowId,
         The rowId would be autoIncremented by the row in sqlite
         */
        self.rowId = 0;
        self.eventName = [event eventName];
        self.eventType = [event eventType];
        self.eventParameters = [NFLOGUtility convertToString:[event eventParameters]];
        self.timestamp = [event timeStamp];
    }
    return self;
}

-(NFLOGSqlParam *)eventNameParam{
    return [NFLOGSqlParam sqlParamWithString:_eventName];
}

-(NFLOGSqlParam *)eventTypeParam{
    return [NFLOGSqlParam sqlParamWithString:_eventType];
}

-(NFLOGSqlParam *)eventParametersParam{
    return [NFLOGSqlParam sqlParamWithString:_eventParameters];
}

-(NFLOGSqlParam *)eventTimeStampParam{
    return [NFLOGSqlParam sqlParamWithDouble:_timestamp];
}

-(void)configWithDict:(NSDictionary *)dict{
    _rowId = [[dict objectForKey:NFLOG_SPECIFIC_TIME_EVENT_ROW_ID_COL] integerValue];
    _eventName = [dict objectForKey:NFLOG_SPECIFIC_TIME_EVENT_NAME_COL];
    _eventType = [dict objectForKey:NFLOG_SPECIFIC_TIME_EVENT_TYPE_COL];
    _eventParameters = [dict objectForKey:NFLOG_SPECIFIC_TIME_EVENT_PARAMETERS_COL];
    _timestamp = [[dict objectForKey:NFLOG_SPECIFIC_TIME_EVENT_TIMESTAMP_COL] doubleValue];
}

-(NSDictionary *)toDictionary{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setValue:_eventName forKey:NFLOG_JSON_KEY_EVENT_NAME];
    [dictionary setValue:[NSString stringWithFormat:@"%.f",_timestamp] forKey:NFLOG_JSON_KEY_EVENT_TMESTAMP];
    if([allTrim(_eventParameters) length] != 0){
        NSDictionary *paramDict = [NFLOGUtility convertToDictionary:_eventParameters];
        [dictionary setObject:paramDict forKey:NFLOG_JSON_KEY_EVENT_PARAMETERS];
    }
    NFLogDebug(@"%@",dictionary);
    return [dictionary copy];
}

-(NSString *)description{
    return [NSString stringWithFormat:@"event name = %@ , event parameters = %@ , event timestamp = %f",_eventName,_eventParameters,_timestamp];
}

@end
