//
//  NFLOGAutoBehaviour.m
//  NFLogger
//
//  Created by Nilesh Agrawal on 1/27/17.
//  Copyright © 2017 Nilesh Agrawal. All rights reserved.
//

#import "NFLOGAutoBehaviour.h"
#import "NFLOGEvent.h"
#import "NFLOGUtility.h"
#import "NFLOGConstants.h"
#import "NFLOGRequestManager.h"

@implementation NFLOGAutoBehaviour
-(void)swizzleClasses{
    
    //TODO: Implement Method Swizzling
}

-(NFLOGRecordStatus)logEvent:(NSString *)eventName withParameters:(NSDictionary *)parameters{
    
    //Create Event Instance
    NFLOGEvent *event = [[NFLOGEvent alloc] initWithEventName:eventName eventType:NFLOG_SPECIFIC_TIME_EVENT eventParameters:parameters timeStamp:[NFLOGUtility getUnixtimestamp]];
    
    //Record the event.
    [[NFLOGRequestManager sharedInstance] record:event withCompletionBlock:^NFLOGRecordStatus(BOOL success) {
        if(success){
            return NFLOGEventRecorded;
        }else{
            return NFLOGEventRecordFailed;
        }
    }];
    return NFLOGEventRecordFailed;
}

-(NFLOGRecordStatus)startActiveEvent:(NSString *)eventName withParameters:(NSDictionary *)parameters{
    
    //Create Event Instance
    NFLOGEvent *event = [[NFLOGEvent alloc] initWithEventName:eventName eventType:NFLOG_SPECIFIC_TIME_EVENT eventParameters:parameters timeStamp:[NFLOGUtility getUnixtimestamp]];
    
    //Record the event.
    [[NFLOGRequestManager sharedInstance] record:event withCompletionBlock:^NFLOGRecordStatus(BOOL success) {
        if(success){
            return NFLOGEventRecorded;
        }else{
            return NFLOGEventRecordFailed;
        }
    }];
    return NFLOGEventRecordFailed;
    
    
}

-(NFLOGRecordStatus)endActiveEvent:(NSString *)eventName withParameters:(NSDictionary *)parameters{
    //Create Event Instance
    NFLOGEvent *event = [[NFLOGEvent alloc] initWithEventName:eventName eventType:NFLOG_SPECIFIC_TIME_EVENT eventParameters:parameters timeStamp:[NFLOGUtility getUnixtimestamp]];
    
    //Record the event.
    [[NFLOGRequestManager sharedInstance] update:event withCompletionBlock:^NFLOGRecordStatus(BOOL success) {
        if(success){
            return NFLOGEventRecorded;
        }else{
            return NFLOGEventRecordFailed;
        }
    }];
    return NFLOGEventRecordFailed;
}



@end
