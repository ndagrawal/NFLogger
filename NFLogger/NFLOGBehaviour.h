//
//  NFLOGBehaviour.h
//  NFLogger
//
//  Created by Nilesh Agrawal on 1/27/17.
//  Copyright © 2017 Nilesh Agrawal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NFLogger.h"
/*!
    @brief Protocol defined to create different behaviour for NFLogger library as per different modes.
 */
@protocol NFLOGBehaviour <NSObject>
/*!
    @brief Method to define the behaviour of swizzled classes. 
    For Auto Mode, classes should be swizzled (yet to be implemented).
    For Manual Mode, classes should not be swizzled.
 */
-(void)swizzleClasses;
/*!
    @brief LogEvent in Database. 
    This method creates an instance of NFLOGEvent class and dispatches it to database.
 */
-(void)logEvent:(NSString *)eventName withParameters:(NSDictionary *)parameters completionBlock:(void (^)(NFLOGRecordStatus recordStatus))completionBlock;
/*!
    @brief Logs startActiveEvent in Database.
    This method creates an instance of NFLOGEvent class and dispatches it to database.
 */
-(void)startActiveEvent:(NSString *)eventName withParameters:(NSDictionary *)parameters completionBlock:(void (^)(NFLOGRecordStatus recordStatus))completionBlock;

/*!
    @brief Logs EndActiveEvent in Database.
    This method creates an instance of NFLOGEvent class and dispatches it to database.
 */
-(void)endActiveEvent:(NSString *)eventName completionBlock:(void (^)(NFLOGRecordStatus recordStatus))completionBlock;
@end

