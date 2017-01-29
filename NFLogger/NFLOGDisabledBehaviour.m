//
//  NFLOGDisabledBehaviour.m
//  NFLogger
//
//  Created by Nilesh Agrawal on 1/27/17.
//  Copyright © 2017 Nilesh Agrawal. All rights reserved.
//

#import "NFLOGDisabledBehaviour.h"

@implementation NFLOGDisabledBehaviour

//Classes should not be swizzled in Disabled mode.
-(void)swizzleClasses{
    
}

//events are not logged in disabled mode and NFLOGDisabled status is sent in completion block to notify user.
-(void)logEvent:(NSString *)eventName withParameters:(NSDictionary *)parameters completionBlock:(void (^)(NFLOGRecordStatus recordStatus))completionBlock{
    if(completionBlock){
        completionBlock(NFLOGDisabled);
    }
}

//events are not logged in disabled mode and NFLOGDisabled status is sent in completion block to notify user.-(void)startActiveEvent:(NSString *)eventName withParameters:(NSDictionary *)parameters completionBlock:(void (^)(NFLOGRecordStatus recordStatus))completionBlock{
    if(completionBlock){
        completionBlock(NFLOGDisabled);
    }
}

//events are not logged in disabled mode and NFLOGDisabled status is sent in completion block to notify user.
-(void)endActiveEvent:(NSString *)eventName completionBlock:(void (^)(NFLOGRecordStatus recordStatus))completionBlock{
    if(completionBlock){
        completionBlock(NFLOGDisabled);
    }
}
@end
