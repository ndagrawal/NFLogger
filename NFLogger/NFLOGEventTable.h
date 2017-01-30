//
//  NFLOGMetricTable.h
//  NFLogger
//
//  Created by Nilesh Agrawal on 1/25/17.
//  Copyright © 2017 Nilesh Agrawal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NFLOGEvent.h"
#import "NFLOGEventTableRow.h"
#import "NFLOGSqlite.h"
/*!
    @brief  An Interface to provide different types of implementation to eventTables.
 */
@protocol NFLOGEventTable <NSObject>

/*!
    @brief  Method to create table
 */
-(BOOL)createTablewithSqlite:(NFLOGSqlite *)sqlite;

/*!
    @brief  Method to insert table
 */
-(BOOL)insertEvent:(NFLOGEvent *) event withSqlite:(NFLOGSqlite *)sqlite;

/*!
    @brief Update Event in Table
 */
-(BOOL)updateEventRow:(NFLOGEvent *)event withSqlite:(NFLOGSqlite *)sqlite;

/*!
    @brief Select All Events With Sqlite.
 */
-(NSMutableArray<id<NFLOGEventTableRow>> *)selectAllEventswithSqlite:(NFLOGSqlite *)sqlite;

/*!
    @brief Delete Event With Sqlite.
 */
-(BOOL)deleteEvent:(id<NFLOGEventTableRow>)event withSqlite:(NFLOGSqlite *)sqlite;

@end

