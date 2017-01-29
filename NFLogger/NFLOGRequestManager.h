//
//  NFLOGRequestManager.h
//  NFLogger
//
//  Created by Nilesh Agrawal on 1/26/17.
//  Copyright © 2017 Nilesh Agrawal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NFLogger.h"

@class NFLOGEvent;

typedef void (^RequestCompletionBlock) (NFLOGRecordStatus recordStatus);
/*!
    @brief Singleton class that cares of thread management and timer for uploading.

    This class thus acts a Mediator between user api, database and networking.
    The class also acts as an observer for getting events like app goes foreground/background to start and stop timers
 */
@interface NFLOGRequestManager : NSObject

/*!
    @brief upload interval determines the time interval when the events should be uploaded.
    We have considered this to be in seconds, for convenince.
 */
@property NSInteger uploadInterval;

/*!
    @brief Singleton Object for the NFLOGRequestManager
    We want only one single instance to take care of threading and logging events to database as per the event types.
 */
+(id)sharedInstance;

#pragma mark - Database Related Methods.
/*!
    @brief Create Table for a particular event type. 
    Note that we are creating two types of table: 
    1. Table for Storing Specific Time Events. 
    2. Table for Storing events that span for a particular period , this events have start and end time associated with them.
    Table creation is also done in async thread, in serial queue. 
 */
-(void)createTableforEventType:(NSString *)eventType;
/*!
    @brief Recording the event in the table.
    Note that whenever a logEvent or startActiveEvent APIs are called this method is invoked and we do 
    "insertion" operation inside the database.
    Insertion is again an async operation.
 */
-(void)record:(NFLOGEvent *)event withCompletionBlock:(RequestCompletionBlock) completionBlock;

/*!
    @brief Updating the event in activeEventTable.
    Note that whenever endActiveEvent API is called this method is invoked and we
    "update" operation inside the database.
    Updation is again an async operation.
 */
-(void)update:(NFLOGEvent *)event withCompletionBlock:(RequestCompletionBlock) completionBlock;

/*!
    @brief Method retrives all the entries from database, converts in suitable JSON format and uploads it. 
    Note :
    Prefreable choice would be to use "sync" NSURLConnection, but since the API is deprecated, we are using NSURLSession.
 
    Note that "sync"-ronization care is taken through NFRequestManager's uploadAndDelete method while retrieving entries,
    and then the entries are send to NSURLSession's operation queue to upload. This is to make sure, proper order is ensured .
 
    The completion block implementation in method, makes sure, that we are sending the results in the serialQueue, which takes care of deleting the entries from the database.
 */
-(void)uploadAndDelete;

#pragma mark - Timer Based Methods.
/*!
    @brief Starting the timer. 
    The timer is started whenever the user comes in foreground.
 */
-(void)validateTimer;

/*!
    @brief Ending the timer. 
    The timer is ended whenever the user goes to background.
 */
-(void)stopTimer;

@end
