//
//  NFLOGTimeEvent.h
//  NFLogger
//
//  Created by Nilesh Agrawal on 1/25/17.
//  Copyright © 2017 Nilesh Agrawal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NFLOGEvent.h"

@interface NFLOGEvent : NSObject

@property (nonatomic,strong) NSString * eventName;
@property (nonatomic,strong) NSString * eventType;
@property (nonatomic,strong) NSDictionary *eventParameters;
@property (nonatomic,assign) double timeStamp;

-(id)initWithEventName:(NSString *)eventName eventType:(NSString *)eventType eventParameters:(NSDictionary *)eventParameters timeStamp:(NSInteger)timeStamp;

-(NSString *)description;

@end
