//
//  NFLOGDatabaseManager.h
//  NFLogger
//
//  Created by Nilesh Agrawal on 1/25/17.
//  Copyright © 2017 Nilesh Agrawal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NFLOGEventTable.h"
#import "NFLOGEventTableRow.h"

/*!
    @brief Database Management Class. 
 
    This class handles the responsiblity of opening,closing, in sqlite, 
    and all the insertion/deletion/update in database, 
    just purely follows "Class Handles Single Responsiblity of DatabaseManagement"
 
 */
@interface NFLOGDatabaseManager : NSObject
/*!
    @brief reference of NFLOGEventTable. 
 
    [This helps in achieving "strategy design pattern"].
    NFLOGDatabaseManager has reference to the eventTable. 
    Thus we can set the table and change the implementation as per table.
 */
@property (nonatomic, strong) id<NFLOGEventTable> eventTable;
@property (nonatomic, strong) NSString* dbFilePath;

/*!
    @brief Singleton Object of DatabaseManager.
    This class is made singleton, as we want only one instance as an handle to operate on sqlite, to open/close/write/read database.
 */
+(NFLOGDatabaseManager *)sharedInstance;

/*!
    @brief CreateTable.
    Table creation happens only once.
 */
-(BOOL)createTable;
/*!
    @brief Insert Event.
    Opens Database - Insert event - Closes Database.
    if event is nil, return NO, hence we dont insert event.
 */
-(BOOL)insertEvent:(NFLOGEvent *)event;

/*!
    @brief Update Event.
    Opens Database - Update Event - Closes Database.
    if event is nil, return NO, hence we dont update event.
 */
-(BOOL)updateEvent:(NFLOGEvent *)event;

/*!
    @brief DeleteEvent.
    Opens database - delete event - closes database.
    if event is nil, return NO, hence we dont delete event.
 */
-(BOOL)deleteEvent:(id<NFLOGEventTableRow>)event;

/*!
    @brief Selects all events.
    Opens database - select all events - closes database
    if event is nil, return NO, hence we dont select all event.
 */
-(NSMutableArray<id<NFLOGEventTableRow>> *)selectAllEvent;

@end
