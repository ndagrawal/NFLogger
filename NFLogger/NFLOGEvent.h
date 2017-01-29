//
//  NFLOGTimeEvent.h
//  NFLogger
//
//  Created by Nilesh Agrawal on 1/25/17.
//  Copyright © 2017 Nilesh Agrawal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NFLOGEvent.h"
/*!
    @brief Class of Event Object.
   
    This class helps in creaating instance of event objects.
    In future for different types of events, we can create protocol of NFLOGEvent Object and generalize it futher. 
 */
@interface NFLOGEvent : NSObject

@property (nonatomic,strong) NSString * eventName;
@property (nonatomic,strong) NSString * eventType;
@property (nonatomic,strong) NSDictionary *eventParameters;
@property (nonatomic,assign) double timeStamp;

/*!
    @brief Initializer to create event object
    For startActiveEvent the timestamp will be used as start time.
    For endTime, the timestamp will be used as end time, difference is calculated at the last while creating the JSON.
 */
-(id)initWithEventName:(NSString *)eventName eventType:(NSString *)eventType eventParameters:(NSDictionary *)eventParameters timeStamp:(NSInteger)timeStamp;
/*!
    @brief description of object.
 */
-(NSString *)description;

@end
