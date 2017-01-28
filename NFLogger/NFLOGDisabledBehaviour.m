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
-(NFLOGRecordStatus)logEvent:(NSString *)eventName withParameters:(NSDictionary *)parameters{
    return NFLOGDisabled;
}

-(NFLOGRecordStatus)startActiveEvent:(NSString *)eventName withParameters:(NSDictionary *)paramters{
    return NFLOGDisabled;
}

-(NFLOGRecordStatus)endActiveEvent:(NSString *)eventName withParameters:(NSDictionary *)parameters{
    return NFLOGDisabled;
}

@end
