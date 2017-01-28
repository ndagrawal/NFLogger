//
//  NFLOGBehaviour.h
//  NFLogger
//
//  Created by Nilesh Agrawal on 1/27/17.
//  Copyright © 2017 Nilesh Agrawal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NFLog.h"

@protocol NFLOGBehaviour <NSObject>
-(void)swizzleClasses;

-(NFLOGRecordStatus)logEvent:(NSString *)eventName withParameters:(NSDictionary *)parameters;

-(NFLOGRecordStatus)startActiveEvent:(NSString *)eventName withParameters:(NSDictionary *)parameters;

-(NFLOGRecordStatus)endActiveEvent:(NSString *)eventName withParameters:(NSDictionary *)parameters;

@end

