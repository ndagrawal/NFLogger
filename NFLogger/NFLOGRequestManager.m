//
//  NFLOGRequestManager.m
//  NFLogger
//
//  Created by Nilesh Agrawal on 1/26/17.
//  Copyright © 2017 Nilesh Agrawal. All rights reserved.
//

#import "NFLOGRequestManager.h"
#import "NFLOGLogger.h"
#import "NFLOGEvent.h"
#import "NFLOGDatabaseManager.h"
#import "NFLOGTableFactory.h"
#import "NFLOGConstants.h"
#import "NFLOGActiveEventTableRow.h"
#import "NFNetworkManager.h"
#import "NFLOGUtility.h"
#import "NFLOGLogger.h"
#import <UIKit/UIKit.h>

static NFLOGRequestManager *logRequestMaanger;
static dispatch_queue_t serialQueue;

@interface NFLOGRequestManager()
@property NSTimer *timer;
@end

@implementation NFLOGRequestManager

@synthesize uploadInterval = _uploadInterval;

+(id)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        logRequestMaanger = [[NFLOGRequestManager alloc] init];
    });
    return logRequestMaanger;
}

-(id)init{
    self = [super init];
    if(self){
        serialQueue = dispatch_queue_create("com.nflogger.databaseSerialQueue", DISPATCH_QUEUE_SERIAL);
        _uploadInterval = 1.0;
        [self registerNotifications];
    }
    return self;
}

-(void)registerNotifications{
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(validateTimer)
     name:UIApplicationDidBecomeActiveNotification
     object:nil];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(stopTimer)
     name:UIApplicationDidEnterBackgroundNotification
     object:nil];
    
}
-(void)validateTimer{
    NFLogDebug(@"Start Timer");
    _timer = [NSTimer scheduledTimerWithTimeInterval:_uploadInterval target:self selector:@selector(uploadAndDelete) userInfo:nil repeats:YES];
}

-(void)stopTimer{
    NFLogDebug(@"Stop Timer");
    [_timer invalidate];
}

//TODO: make a initializer Queue....
-(void)createTableforEventType:(NSString *)eventType {
    __block BOOL success = NO;
    dispatch_async(serialQueue, ^{
        [[NFLOGDatabaseManager sharedInstance] setEventTable:[NFLOGTableFactory getTableInstance:eventType]];
        success = [[NFLOGDatabaseManager sharedInstance] createTable];
        NFLogDebug(@"Tables created for %@ with success %@",eventType,booleanString(success));
    });
}

-(void)record:(NFLOGEvent *)event withCompletionBlock:(RequestCompletionBlock) completionBlock{
    __block BOOL success = NO;
    dispatch_async(serialQueue, ^{
        [[NFLOGDatabaseManager sharedInstance] setEventTable:[NFLOGTableFactory getTableInstance:[event eventType]]];
        success = [[NFLOGDatabaseManager sharedInstance] insertEvent:event];
        if(completionBlock){
            if(success){
                NFLogDebug(@"Event = %@ Recorded Successfully ",event);
                completionBlock(NFLOGEventRecorded);
            }else{
                NFLogDebug(@"Event = %@ Recording Failed ",event);
                completionBlock(NFLOGEventRecordFailed);
            }
        }
    });
}

-(void)update:(NFLOGEvent *)event withCompletionBlock:(RequestCompletionBlock) completionBlock{
    __block BOOL success = NO;
    dispatch_async(serialQueue, ^{
        [[NFLOGDatabaseManager sharedInstance] setEventTable:[NFLOGTableFactory getTableInstance:[event eventType]]];
        success = [[NFLOGDatabaseManager sharedInstance] updateEvent:event];
        if(completionBlock){
            if(success){
                NFLogDebug(@"Event = %@ Updated Successfully ",event);
                completionBlock(NFLOGEventRecorded);
            }else{
                NFLogDebug(@"Event = %@ Updating Failed",event);
                completionBlock(NFLOGEventRecordFailed);
            }
        }
    });
}


/**
 
 Note :
 Prefreable choice would be to use "sync" NSURLConnection, but since the API is deprecated, we are using NSURLSession.
 
 Note that "sync"-ronization care is taken through NFRequestManager's uploadAndDeleteMethod while retrieving entries,
 and then the entries are send to NSURLSession's operation queue to upload. This is to make sure, proper order is ensured .
 
 The completion block implementation in uploadAndDeleteAll method,
 makes sure, that we are sending the results in the serialQueue,
 which takes care of deleting the entries from the database.
 
 **/

-(void)uploadAndDelete{
    /**
     We have to make this "sync",
     since we want upload to happen only after all the entries are retrived, and a proper json is formed.
     "sync" dispatch will make sure, that network manager upload action happens only after sync thread is completely executed.
     **/
    __block NSMutableArray<id<NFLOGEventTableRow>> *events = [[NSMutableArray alloc] init];
    __block NSDictionary *dictionary = nil;
    
    dispatch_sync(serialQueue, ^{
        //Select All Events.
        [[NFLOGDatabaseManager sharedInstance] setEventTable:[NFLOGTableFactory getTableInstance:NFLOG_SPECIFIC_TIME_EVENT]];
        [events addObjectsFromArray:[[NFLOGDatabaseManager sharedInstance] selectAllEvent]];
        [[NFLOGDatabaseManager sharedInstance] setEventTable:[NFLOGTableFactory getTableInstance:NFLOG_START_ACTIVE_TIME_EVENT]];
        [events addObjectsFromArray:[[NFLOGDatabaseManager sharedInstance] selectAllEvent]];
        dictionary = [NFLOGUtility convertToJSON:events];
    });
    
    if(dictionary != nil){
        //NSURLSession and inside that create an async task for deleting all the data.
        NFLogDebug(@"Data to be uploaded %@",dictionary);
        NFNetworkManager *networkManager = [[NFNetworkManager alloc] init];
        [networkManager uploadAllEvents:dictionary withCompletionBlock:^(NSData *data) {
            dispatch_async(serialQueue, ^{
                /*Deleting all the events that were sent.We are avoiding use of deleteAll Query, since, delete All also iterates through multiple entries inside,also, iterating through the retrived rows and deleting them, will be ensured that no entries other than the retrived once are deleted.
                 */
                for(id<NFLOGEventTableRow> eventRow in events){
                    [[NFLOGDatabaseManager sharedInstance] setEventTable:[NFLOGTableFactory getTableInstance:[eventRow eventType]]];
                    [[NFLOGDatabaseManager sharedInstance] deleteEvent:eventRow];
                }
                
            });
        }];
    }
}


@end
