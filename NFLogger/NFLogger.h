//
//  NFLog.h
//  NFLogger
//
//  Created by Nilesh Agrawal on 1/25/17.
//  Copyright © 2017 Nilesh Agrawal. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 *  @brief Provides all available methods for logging UI events from your app.
 *
 *  Set of methods that allow developers to log events detailed, and collect information
 *  regarding the use of their app by end users.
 *
 *  @note 
 *  For more information regarding the use of this library, 
 *   you can connect to support center at nilesh.d.agrawal@gmail.com
 *
 *  @version 1.0.0
 */
@interface NFLogger : NSObject

/*!
 * @brief Enum to provide status of the logged events.
 * @since 1.0.0
 */
typedef NS_ENUM(NSUInteger, NFLOGRecordStatus) {
    NFLOGEventRecordFailed  = 0,
    NFLOGEventRecorded      = (1 << 0),
    NFLOGDisabled           = (1 << 2),
};

/*!
 * @brief Enum to initializeSDK in manual and auto mode. 
 * 
 * In Manual Mode, all the apis will work. 
 * In Auto Mode, some of the classes will log events automatically and manual apis will also work.
 *
 * @since 1.0.0
 */
typedef NS_ENUM(NSUInteger, NFLOGMODE) {
    NFLOGAutoCapture        = 1,
    NFLOGManualCapture      = 2
};

/*!
 * @brief Enum to get provide logLevel for logs related to NFLogger.
 * 
 * @note This enum is useful for debugging purpose only. Default mode is none. 
 *
 * @since 1.0.0
 */
typedef NS_ENUM(NSInteger, NFLogLevel) {
    NFLOG_LEVEL_NONE          = 0,
    NFLOG_LEVEL_ERROR         = (1 << 0),
    NFLOG_LEVEL_DEBUG         = (1 << 1),
    NFLOG_LEVEL_VERBOSE       = (1 << 2)
};

/*!
 * @brief Initialize the NFLogger SDK
 * 
 * @param mode version in which sdk should function.
 * 
 * This method serves as entry point for this library. 
 * It initializes the library to collect application information inside your application.
 * It must be placed within the scope of applicationDidFinishLaunching method in the AppDelegate.m file of your app.
 *
 * @code 
 * -(void)applicationDidFinishLaunching:(UIApplication *) application{
 *      [NFLogger initializeSDKWithMode:NFLOGManualCapture];
 * }
 * @endcode
 *
 * @since 1.0.0
 */
+(BOOL)initializeSDKWithMode:(NFLOGMODE)mode;

/*!
 * @brief Optinal Metod to set the time interval on which sdk should upload the collected metrics.
 * 
 * This optional method helps to set upload interval , to upload data (events)  at a specific interval only.
 * The more the upload interval is more data is batched together for upload, thus reducing number of network calls. 
 * For best performance default upload interval can be at 1 min.
 * 
 * @code
 * -(void)applicationDidFinishLaunching:(UIApplication *) application{
 *      [NFLogger initializeSDKWithMode:NFLOGManualCapture];
 *      [NFLogger setUploadInterval:60];
 * }
 * @endcode
 *
 * @param seconds number of seconds at which data should be uploaded.
 *
 * @note Default upload interval is set to 30 seconds.
 * @since 1.0.0
 */
+(void)setUploadInterval:(NSInteger)seconds;

/*!
 * 
 * @brief to get the NFLogger's library version..
 *
 * This method to get the version of NFLogger's library version.
 *
 * @code
 * -(void)applicationDidFinishLaunching:(UIApplication *) application{
 *      [NFLogger initializeSDKWithMode:NFLOGManualCapture];
 *      //To set the upload interval for 60 seconds.
 *      [NFLogger setUploadInterval:60];
 *      NSLog(@"%@",[NFLogger getNFLoggerVersion]);
 * }
 * @endcode
 * @since 1.0.0
 *
 *
 */
+(NSString *)getNFLoggerVersion;

/*!
 * @brief To set the logLevel of NFLogger library. 
 * 
 * This method helps to set the logLevel to get the logs of various level (DEBUG/VERBOSE/ERROR).
 * 
 * Following code snippet to demonstrate the use of this api.
 * @code
 * -(void)applicationDidFinishLaunching:(UIApplication *) application{
 *      [NFLogger initializeSDKWithMode:NFLOGManualCapture];
 *      //To set the upload interval for 60 seconds.
 *      [NFLogger setUploadInterval:60];
 *      [NFLogger setLogLevelOfNFLog:NFLOG_LEVEL_DEBUG];
 * }
 * @endcode
 * 
 * Alternatively, this api can also be used to set logLevel of two Level's simulatenously through OR operation.
 * @code
 * -(void)applicationDidFinishLaunching:(UIApplication *) application{
 *      [NFLogger initializeSDKWithMode:NFLOGManualCapture];
 *      //To set the upload interval for 60 seconds.
 *      [NFLogger setUploadInterval:60];
 *      [NFLogger setLogLevelOfNFLog:NFLOG_LEVEL_DEBUG|NFLOG_LEVEL_VERBOSE];
 * }
 * @endcode
 * @param logLevel  set different logLevels for NFLogger library
 * @note
 * Default Logger Level Mode is NFLOG_LEVEL_NONE. 
 * @since 1.0.0
 */
+(void)setLogLevelOfNFLog:(NFLogLevel)logLevel;

/*!
 * @brief Logs an event
 * Logs an event which is collected at the timestamp, when it is called. Users are suggested to have a eventName which 
 * defines certain business purpose, so that members of non technical team working on app, can also understand when the
 * event is logged.
 * 
 * @code
 * -(IBAction)buttonClicked:(id)sender{
 *  [NFLogger logEvent:@"Add to Cart"];
 * }
 * @endcode
 * @param  eventName eventName is a unique key defining your event to be logged.
 * @note 
 * eventName cannot be nil or empty string.
 * eventName should be unique for a particular type of event.
 * @since 1.0.0
 */
+(void)logEvent:(NSString *)eventName;

/*!
 * @brief Logs an event,as well as add optional parameters.
 *
 * Logs an event which is collected at the specific timestamp, when it is called. 
 * This api also helps to add information in the form of dictionary. Users are suggested to have a eventName
 * which defines certain business purpose, so that members of non technical team working on app, can also understand when
 * the event is logged.
 *
 * @code
 * -(IBAction)buttonClicked:(id)sender{
 *  NSDictionary *dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:@"CarModel",@"Audi", nil];
 *  [NFLogger logEvent:@"PurchaseCar" withParameters:dictionary];
 * }
 * @endcode
 * @param  eventName eventName is a unique key defining your event to be logged.
 * @param  parameters dictionary to add extra information, along with the logged event.
 * 
 * @note
 * eventName cannot be nil or empty string.
 * eventName should be unique for a particular type of event.
 * parameter can be optionally nil.
 * @since 1.0.0
 */
+(void)logEvent:(NSString *)eventName withParameters:(NSDictionary *)parameters;

/*!
 * @brief Logs an event,as well as add optional parameters , provides completionHandler for user to get status of logged event.
 *
 * Logs an event which is collected at the specific timestamp, when it is called.
 * This api also helps to add information in the form of dictionary.
 * Completion Handler provides the status of event logged. 
 *
 * Users are suggested to have a eventName which defines certain business purpose, so that members of non technical team 
 * working on app, can also understand when the event is logged.
 *
 * Event logging is async task, hence, any action scheduled after the status is received in completion handler, should be
 * placed in main queue, to display on UI.
 * 
 * @code
 * -(IBAction)buttonClicked:(id)sender{
 *  NSDictionary *dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:@"CarModel",@"Audi", nil];
 *  [NFLogger logEvent:@"PurchaseCar" withParameters:dictionary completionBlock:^(NFLOGRecordStatus recordStatus) {
 *       dispatch_async(dispatch_get_main_queue(), ^{
 *           NSLog(@"Sucess Status Received in main Queue");
 *           });
 *   }];
 * }
 * @endcode
 *
 * @param  eventName eventName is a unique key defining your event to be logged.
 * @param  parameters dictionary to add extra information, along with the logged event.
 *
 * @note
 * eventName cannot be nil or empty string.
 * eventName should be unique for a particular type of event.
 * parameter can be optionally nil.
 * completion handler can be optionally nil.
 * @since 1.0.0
 */
+(void)logEvent:(NSString *)eventName withParameters:(NSDictionary *)parameters completionBlock:(void (^)(NFLOGRecordStatus recordStatus))completionBlock;
/*!
 * @brief starts Logging an actively spanning event
 * Logs an event which has end time associated with it, hence event will be logged when end time api is called with same
 * eventName. Users are suggested to have a eventName which defines certain business purpose, so that members of
 * non technical team working on app, can also understand when the event is logged.
 * 
 * The api also helps to know time for which the event has spanned. 
 *
 * @code
 * -(IBAction)buttonClicked:(id)sender{
 *  [NFLogger startActiveEvent:@"Add to Cart"];
 * }
 * @endcode
 * @param  eventName eventName is a unique key defining your event to be logged.
 * @note
 * eventName cannot be nil or empty string.
 * eventName should be unique for a particular type of event.
 * @since 1.0.0
 */
+(void)startActiveEvent:(NSString *)eventName;

/*!
 * @brief starts Logging an actively spanning event, as well as add optional parameters.
 * Logs an event which has end time associated with it, hence event will be logged when end time api is called with same
 * eventName. Users are suggested to have a eventName which defines certain business purpose, so that members of
 * non technical team working on app, can also understand when the event is logged.
 *
 * This api also helps to add information in the form of dictionary.
 * The api also helps to know time for which the event has spanned.
 *
 * @code
 * -(IBAction)buttonClicked:(id)sender{
 *  NSDictionary *dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:@"CarModel",@"Audi", nil];
 *  [NFLogger startActiveEvent:@"Add to Cart" withParameters:dictionary];
 * }
 * @endcode
 * @param  eventName eventName is a unique key defining your event to be logged.
 * @note
 * eventName cannot be nil or empty string.
 * eventName should be unique for a particular type of event.
 * @param  paramters dictionary to add extra information, along with the logged event.
 * parameter can be optionally nil.
 * @since 1.0.0
 */
+(void)startActiveEvent:(NSString *)eventName withParameters:(NSDictionary *)paramters;

/*!
 * @brief starts Logging an actively spanning event, as well as add optional parameters. provides completionHandler for user to get
 * status of logged event.
 * Logs an event which has end time associated with it, hence event will be logged when end time api is called with same
 * eventName. Users are suggested to have a eventName which defines certain business purpose, so that members of
 * non technical team working on app, can also understand when the event is logged.
 *
 * This api also helps to add information in the form of dictionary.
 * The api also helps to know time for which the event has spanned.
 *
 * Event logging is async task, hence, any action scheduled after the status is received in completion handler, should be
 * placed in main queue, to display on UI.
 *
 * @code
 * -(IBAction)buttonClicked:(id)sender{
 *  NSDictionary *dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:@"CarModel",@"Audi", nil];
 *  [NFLogger startActiveEvent:@"Add to Cart" withParameters:dictionary completionBlock:^(NFLOGRecordStatus recordStatus) {
 *       dispatch_async(dispatch_get_main_queue(), ^{
 *           NSLog(@"Sucess Status Received in main Queue");
 *        });
 *   }];
 * }
 * @endcode
 * @param  eventName eventName is a unique key defining your event to be logged.
 * @note
 * eventName cannot be nil or empty string.
 * eventName should be unique for a particular type of event.
 * @param  paramters dictionary to add extra information, along with the logged event.
 * parameter can be optionally nil.
 * completion handler can be optionally nil.
 * @since 1.0.0
 */
+(void)startActiveEvent:(NSString *)eventName withParameters:(NSDictionary *)paramters completionBlock:(void (^)(NFLOGRecordStatus recordStatus)) completionBlock;

/*!
 * @brief ends Logging an actively spanning event with eventName
 * Ends Logging an event with eventName. 
 * Users are suggested to have a eventName which defines certain business purpose, so that members of
 * non technical team working on app, can also understand when the event is logged.
 *
 * The api also helps to know time for which the event has spanned.
 *
 * @code
 * -(IBAction)buttonClicked:(id)sender{
 *  [NFLogger endActiveEvent:@"End Transaction"];
 * }
 * @endcode
 * @param  eventName eventName is a unique key defining your event to be logged.
 * @note
 * eventName cannot be nil or empty string.
 * eventName should be unique for a particular type of event.
 * @since 1.0.0
 */
+(void)endActiveEvent:(NSString *)eventName;

/*!
 * @brief ends Logging an actively spanning event with eventName provides completionHandler for user to get
 * status of logged event.
 *
 * Ends Logging an event with eventName.
 * Users are suggested to have a eventName which defines certain business purpose, so that members of
 * non technical team working on app, can also understand when the event is logged.
 *
 * The api also helps to know time for which the event has spanned.
 *
 * Event logging is async task, hence, any action scheduled after the status is received in completion handler, should be
 * placed in main queue, to display on UI.
 *
 * @code
 * -(IBAction)buttonClicked:(id)sender{
 *  [NFLogger endActiveEvent:@"End Transaction" completionBlock:^(NFLOGRecordStatus recordStatus) {
 *       dispatch_async(dispatch_get_main_queue(), ^{
 *           NSLog(@"Sucess Status Received in main Queue");
 *        });
 *   }];
 * }
 * @endcode
 * @param  eventName eventName is a unique key defining your event to be logged.
 * @note
 * eventName cannot be nil or empty string.
 * eventName should be unique for a particular type of event.
 * completion handler can be optionally nil.
 * @since 1.0.0
 */
+(void)endActiveEvent:(NSString *)eventName completionBlock:(void (^)(NFLOGRecordStatus recordStatus))completionBlock;

@end
