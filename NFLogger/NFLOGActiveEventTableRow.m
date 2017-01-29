//
//  NFLOGActiveEventTableRow.m
//  NFLogger
//
//  Created by Nilesh Agrawal on 1/25/17.
//  Copyright © 2017 Nilesh Agrawal. All rights reserved.
//

#import "NFLOGActiveEventTableRow.h"
#import "NFLOGSqlParam.h"
#import "NFLOGUtility.h"
#import "NFLOGConstants.h"

@implementation NFLOGActiveEventTableRow
@synthesize rowId = _rowId;
@synthesize eventName = _eventName;
@synthesize eventType = _eventType;
@synthesize eventParameters = _eventParameters;
@synthesize startTimeStamp = _startTimeStamp;
@synthesize endTimeStamp = _endTimeStamp;


-(id)initWithEvent:(NFLOGEvent *)event{
    self = [super init];
    if(self){
        self.rowId = 0;
        self.eventName = [event eventName];
        self.eventType = [event eventType];
        self.eventParameters = [NFLOGUtility convertToString:[event eventParameters]];
        self.startTimeStamp = [event timeStamp];
        self.endTimeStamp = 0;
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
-(NFLOGSqlParam *)eventStartTimeStampParam{
    return [NFLOGSqlParam sqlParamWithDouble:_startTimeStamp];
}
-(NFLOGSqlParam *)eventEndTimeStampParam{
    return [NFLOGSqlParam sqlParamWithDouble:_endTimeStamp];
}

-(void)configWithDict:(NSDictionary *)dict{
    _rowId = [[dict objectForKey:NFLOG_ACTIVE_TIME_EVENT_ROW_ID_COL] integerValue];
    _eventName = [dict objectForKey:NFLOG_ACTIVE_TIME_EVENT_NAME_COL];
    _eventType = [dict objectForKey:NFLOG_ACTIVE_TIME_EVENT_TYPE_COL];
    _eventParameters = [dict objectForKey:NFLOG_ACTIVE_TIME_EVENT_PARAMETERS_COL];
    _startTimeStamp = [[dict objectForKey:NFLOG_ACTIVE_TIME_EVENT_START_TIME_COL] doubleValue];
    _endTimeStamp = [[dict objectForKey:NFLOG_ACTIVE_TIME_EVENT_END_TIME_COL] doubleValue];
}

-(NSDictionary *)toDictionary{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setValue:_eventName forKey:NFLOG_JSON_KEY_EVENT_NAME];
    [dictionary setValue:[NSString stringWithFormat:@"%.f",_startTimeStamp] forKey:NFLOG_JSON_KEY_EVENT_TMESTAMP];
    double diff = _endTimeStamp - _startTimeStamp;
    [dictionary setValue:[NSString stringWithFormat:@"%.f",diff] forKey:NFLOG_JSON_KEY_EVENT_TIME_SPENT];
    if([allTrim(_eventParameters) length] != 0){
        NSDictionary *paramDict = [NFLOGUtility convertToDictionary:_eventParameters];
        [dictionary setObject:paramDict forKey:NFLOG_JSON_KEY_EVENT_PARAMETERS];
    }
    return [dictionary copy];
}

-(NSString *)description{
     return [NSString stringWithFormat:@"event name = %@ , event parameters = %@ , event start timestamp = %.f event end timestamp = %.f, _timespent = %.f",_eventName,_eventParameters,_startTimeStamp,_endTimeStamp,(_endTimeStamp - _startTimeStamp)];
}

@end
