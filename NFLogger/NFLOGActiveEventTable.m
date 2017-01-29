//
//  NFLOGActiveEventTable.m
//  NFLogger
//
//  Created by Nilesh Agrawal on 1/25/17.
//  Copyright © 2017 Nilesh Agrawal. All rights reserved.
//

#import "NFLOGActiveEventTable.h"
#import "NFLOGConstants.h"
#import "NFLOGActiveEventTableRow.h"


@implementation NFLOGActiveEventTable

-(BOOL)createTablewithSqlite:(NFLOGSqlite *)sqlite{
 
    NSString *createTableSql = [NSString
                                stringWithFormat:@"create table if not exists %@ ( %@ integer primary key autoincrement, %@ text, %@ text, %@ text, %@ double, %@ double )",
                                NFLOG_ACTIVE_EVENT_TABLE_NAME,
                                NFLOG_ACTIVE_TIME_EVENT_ROW_ID_COL,
                                NFLOG_ACTIVE_TIME_EVENT_NAME_COL,
                                NFLOG_ACTIVE_TIME_EVENT_TYPE_COL,
                                NFLOG_ACTIVE_TIME_EVENT_PARAMETERS_COL,
                                NFLOG_ACTIVE_TIME_EVENT_START_TIME_COL,
                                NFLOG_ACTIVE_TIME_EVENT_END_TIME_COL];
    return [sqlite executeUpdateWithSql:createTableSql];
}

/**
 Note : 
 The "ignore" clause is used for a purpose.
 **/

-(BOOL)insertEvent:(NFLOGEvent *) event withSqlite:(NFLOGSqlite *)sqlite{
    
    NSString *insertSql = [NSString stringWithFormat:@"Insert or ignore into %@ (%@, %@, %@, %@, %@) values(?, ?, ?, ?, ?)",        NFLOG_ACTIVE_EVENT_TABLE_NAME,
                           NFLOG_ACTIVE_TIME_EVENT_NAME_COL,
                           NFLOG_ACTIVE_TIME_EVENT_TYPE_COL,
                           NFLOG_ACTIVE_TIME_EVENT_PARAMETERS_COL,
                           NFLOG_ACTIVE_TIME_EVENT_START_TIME_COL,
                           NFLOG_ACTIVE_TIME_EVENT_END_TIME_COL];
    
    NFLOGActiveEventTableRow *eventRow = [[NFLOGActiveEventTableRow alloc] initWithEvent:event];
    return [sqlite executeUpdateWithSql:insertSql withParam:@[[eventRow eventNameParam],[eventRow eventType],[eventRow eventParametersParam],[eventRow eventStartTimeStampParam],[eventRow eventEndTimeStampParam]]];
}

-(BOOL)updateEventRow:(NFLOGEvent *)event withSqlite:(NFLOGSqlite *)sqlite{
    return NO;
}

-(NSMutableArray<id<NFLOGEventTableRow>> *)selectAllEventswithSqlite:(NFLOGSqlite *)sqlite{
    NSString *selectSql = [NSString stringWithFormat:@"select * from %@ where %@!=0",NFLOG_ACTIVE_EVENT_TABLE_NAME,NFLOG_ACTIVE_TIME_EVENT_END_TIME_COL];
    NSArray *result = [sqlite queryWithSql:selectSql];
    NSMutableArray<id<NFLOGEventTableRow>> *eventRows = [[NSMutableArray alloc] init];
    for(NSDictionary *dict in result){
        id<NFLOGEventTableRow> eventRow = [[NFLOGActiveEventTableRow alloc] init];
        [eventRow configWithDict:dict];
        [eventRows addObject:eventRow];
    }
    return eventRows;
}

-(BOOL)deleteEvent:(id<NFLOGEventTableRow>)eventRow withSqlite:(NFLOGSqlite *)sqlite{
    NSString* deleteSql = [NSString stringWithFormat:@"delete from %@ where %@ = ?",NFLOG_SPECIFIC_TIME_EVENT_TABLE_NAME,NFLOG_SPECIFIC_TIME_EVENT_ROW_ID_COL];
    //Downcasting to specific type.
    NFLOGActiveEventTableRow * activeEventRow = (NFLOGActiveEventTableRow *)eventRow;
    return [sqlite executeUpdateWithSql:deleteSql withIntParam:(int)[activeEventRow rowId]];
}


@end
