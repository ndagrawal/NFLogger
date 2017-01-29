//
//  NFLOGTimeEvent.m
//  NFLogger
//
//  Created by Nilesh Agrawal on 1/25/17.
//  Copyright © 2017 Nilesh Agrawal. All rights reserved.
//

#import "NFLOGEvent.h"

@implementation NFLOGEvent
@synthesize eventName = _eventName;
@synthesize eventType = _eventType;
@synthesize timeStamp = _timeStamp;

-(id)initWithEventName:(NSString *)eventName eventType:(NSString *)eventType eventParameters:(NSDictionary *)eventParameters timeStamp:(NSInteger)timeStamp {
    self = [super init];
    if(self){
        self.eventName = eventName;
        self.eventType = eventType;
        self.eventParameters = eventParameters;
        self.timeStamp = timeStamp;
    }
    return self;
}

-(NSString *) description{
    return [NSString stringWithFormat:@"event name = %@ , event Type = %@ , timeStamp = %.f",_eventName,_eventType,_timeStamp];
}

@end
