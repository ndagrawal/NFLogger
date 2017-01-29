//
//  NFLOGManualBehaviour.m
//  NFLogger
//
//  Created by Nilesh Agrawal on 1/27/17.
//  Copyright © 2017 Nilesh Agrawal. All rights reserved.
//

#import "NFLOGManualBehaviour.h"
#import "NFLOGEvent.h"
#import "NFLOGUtility.h"
#import "NFLOGConstants.h"
#import "NFLOGRequestManager.h"

@implementation NFLOGManualBehaviour
-(void)swizzleClasses{
    /**
     * In manual mode , we dont swizzle the classes.
     **/
}

-(void)logEvent:(NSString *)eventName withParameters:(NSDictionary *)parameters completionBlock:(void (^)(NFLOGRecordStatus recordStatus))completionBlock{
    NFLOGEvent *event = [[NFLOGEvent alloc] initWithEventName:eventName eventType:NFLOG_SPECIFIC_TIME_EVENT eventParameters:parameters timeStamp:[NFLOGUtility getUnixtimestamp]];
    [[NFLOGRequestManager sharedInstance] record:event withCompletionBlock:completionBlock];
}

-(void)startActiveEvent:(NSString *)eventName withParameters:(NSDictionary *)parameters completionBlock:(void (^)(NFLOGRecordStatus recordStatus))completionBlock{
    NFLOGEvent *event = [[NFLOGEvent alloc] initWithEventName:eventName eventType:NFLOG_START_ACTIVE_TIME_EVENT eventParameters:parameters timeStamp:[NFLOGUtility getUnixtimestamp]];
    [[NFLOGRequestManager sharedInstance] record:event withCompletionBlock:completionBlock];
}

-(void)endActiveEvent:(NSString *)eventName completionBlock:(void (^)(NFLOGRecordStatus recordStatus))completionBlock{
    NFLOGEvent *event = [[NFLOGEvent alloc] initWithEventName:eventName eventType:NFLOG_END_TIME_EVENT eventParameters:nil timeStamp:[NFLOGUtility getUnixtimestamp]];
    [[NFLOGRequestManager sharedInstance] update:event withCompletionBlock:completionBlock];
}


@end
