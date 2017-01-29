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
    //This method is not implemented at present, because of the scope of project, but in future we will implement it .
    //Method is hence kept as demo.
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
