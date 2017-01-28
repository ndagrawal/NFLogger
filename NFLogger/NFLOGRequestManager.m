//
//  NFLOGRequestManager.m
//  NFLogger
//
//  Created by Nilesh Agrawal on 1/26/17.
//  Copyright © 2017 Nilesh Agrawal. All rights reserved.
//

#import "NFLOGRequestManager.h"
#import "NFLOGEvent.h"
#import "NFLOGDatabaseManager.h"
#import "NFLOGTableFactory.h"
#import "NFLOGConstants.h"
#import "NFLOGActiveEventTableRow.h"

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
    }
    return self;
}

-(void)validateTimer{
    NSTimeInterval interval = 1.0;
    _timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(uploadAndDelete) userInfo:nil repeats:YES];
}

-(void)createTableforEventType:(NSString *)eventType withCompletionBlock:(TableCreateCompletionBlock)completionBlock{
    __block BOOL success = NO;
    dispatch_async(serialQueue, ^{
        [[NFLOGDatabaseManager sharedInstance] setEventTable:[NFLOGTableFactory getTableInstance:eventType]];
        success = [[NFLOGDatabaseManager sharedInstance] createTable];
        dispatch_async(dispatch_get_main_queue(),^{
            completionBlock(success);
        });
    });
    completionBlock(success);
}

-(void)record:(NFLOGEvent *)event withCompletionBlock:(RequestCompletionBlock) completionBlock{
    __block BOOL success = NO;
    dispatch_async(serialQueue, ^{
        [[NFLOGDatabaseManager sharedInstance] setEventTable:[NFLOGTableFactory getTableInstance:[event eventType]]];
        success = [[NFLOGDatabaseManager sharedInstance] insertEvent:event];
        dispatch_async(dispatch_get_main_queue(),^{
            completionBlock(success);
        });
    });
    completionBlock(success);
}

-(void)update:(NFLOGEvent *)event withCompletionBlock:(RequestCompletionBlock) completionBlock{
    __block BOOL success = NO;
    dispatch_async(serialQueue, ^{
         [[NFLOGDatabaseManager sharedInstance] setEventTable:[NFLOGTableFactory getTableInstance:[event eventType]]];
         success = [[NFLOGDatabaseManager sharedInstance] updateEvent:event];
         dispatch_async(dispatch_get_main_queue(),^{
            completionBlock(success);
        });
    });
    completionBlock(success);
}

-(void)stopTimer{
    [_timer invalidate];
}

-(void)deleteRecord:(id<NFLOGEventTableRow>)eventTableRow{
    dispatch_async(serialQueue, ^{
        //[[NFLOGDatabaseManager sharedInstance] setEventTable:[NFLOGTableFactory getTableInstance:[eventTableRow eventType]]];
        [[NFLOGDatabaseManager sharedInstance] deleteEvent:eventTableRow];
    });
}

-(void)uploadAndDelete{

    dispatch_sync(serialQueue, ^{
        //Select All Events.
        
    });
    //NSURLSession and inside that create an async task for deleting all the data.
    
}


@end
