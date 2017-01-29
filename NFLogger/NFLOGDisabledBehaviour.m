//
//  NFLOGDisabledBehaviour.m
//  NFLogger
//
//  Created by Nilesh Agrawal on 1/27/17.
//  Copyright © 2017 Nilesh Agrawal. All rights reserved.
//

#import "NFLOGDisabledBehaviour.h"

@implementation NFLOGDisabledBehaviour
-(void)swizzleClasses{
    
}

-(void)logEvent:(NSString *)eventName withParameters:(NSDictionary *)parameters completionBlock:(void (^)(NFLOGRecordStatus recordStatus))completionBlock{
    
    if(completionBlock){
        completionBlock(NFLOGDisabled);
    }
}

-(void)startActiveEvent:(NSString *)eventName withParameters:(NSDictionary *)parameters completionBlock:(void (^)(NFLOGRecordStatus recordStatus))completionBlock{
    if(completionBlock){
        completionBlock(NFLOGDisabled);
    }
}

-(void)endActiveEvent:(NSString *)eventName completionBlock:(void (^)(NFLOGRecordStatus recordStatus))completionBlock{
    if(completionBlock){
        completionBlock(NFLOGDisabled);
    }
}


@end
