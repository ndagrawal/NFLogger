//
//  NFLOGSpecificEventTable.m
//  NFLogger
//
//  Created by Nilesh Agrawal on 1/25/17.
//  Copyright © 2017 Nilesh Agrawal. All rights reserved.
//

#import "NFLOGSpecificEventTable.h"
#import "NFLOGConstants.h"
#import "NFLOGSpecificEventTableRow.h"

@implementation NFLOGSpecificEventTable

-(BOOL)createTablewithSqlite:(NFLOGSqlite *)sqlite{
    NSString *createTableSql = [NSString
                                stringWithFormat:@"create table if not exists %@ ( %@ integer primary key autoincrement, %@ text, %@ text, %@ text, %@ double )",
                                NFLOG_SPECIFIC_TIME_EVENT_TABLE_NAME,
                                NFLOG_SPECIFIC_TIME_EVENT_ROW_ID_COL,
                                NFLOG_SPECIFIC_TIME_EVENT_NAME_COL,
                                NFLOG_SPECIFIC_TIME_EVENT_TYPE_COL,
                                NFLOG_SPECIFIC_TIME_EVENT_PARAMETERS_COL,
                                NFLOG_SPECIFIC_TIME_EVENT_TIMESTAMP_COL];
    return [sqlite executeUpdateWithSql:createTableSql];
}

-(BOOL)insertEvent:(NFLOGEvent *) event withSqlite:(NFLOGSqlite *)sqlite{
    NSString *insertSql = [NSString stringWithFormat:@"Insert into %@ (%@, %@, %@, %@ ) values(?, ?, ?, ?)",      NFLOG_SPECIFIC_TIME_EVENT_TABLE_NAME,
                           NFLOG_SPECIFIC_TIME_EVENT_NAME_COL,
                           NFLOG_SPECIFIC_TIME_EVENT_TYPE_COL,
                           NFLOG_SPECIFIC_TIME_EVENT_PARAMETERS_COL,
                           NFLOG_SPECIFIC_TIME_EVENT_TIMESTAMP_COL];
    
    NFLOGSpecificEventTableRow *eventRow = [[NFLOGSpecificEventTableRow alloc] initWithEvent:event];
    return [sqlite executeUpdateWithSql:insertSql withParam:@[[eventRow eventNameParam],[eventRow eventTypeParam],[eventRow eventParametersParam],[eventRow eventTimeStampParam]]];
}

-(BOOL)updateEventRow:(NFLOGEvent *)event withSqlite:(NFLOGSqlite *)sqlite{
    /*There is nothing to update here.... so keeping this method with empty implementation
     As we dont actually update anythhing , returning NO on purpose.*/
    
    return NO;
}

-(NSMutableArray<id<NFLOGEventTableRow>> *)selectAllEventswithSqlite:(NFLOGSqlite *)sqlite{
    NSString *selectSql = [NSString stringWithFormat:@"select * from %@",NFLOG_SPECIFIC_TIME_EVENT_TABLE_NAME];
    NSArray *result = [sqlite queryWithSql:selectSql];
    NSMutableArray<id<NFLOGEventTableRow>> *eventRows = [[NSMutableArray alloc] init];
    for(NSDictionary *dict in result){
        id<NFLOGEventTableRow> eventRow = [[NFLOGSpecificEventTableRow alloc] init];
        [eventRow configWithDict:dict];
        [eventRows addObject:eventRow];
    }
    return eventRows;
}

-(BOOL)deleteEvent:(id<NFLOGEventTableRow>)eventRow withSqlite:(NFLOGSqlite *)sqlite{
    NSString* deleteSql = [NSString stringWithFormat:@"delete from %@ where %@ = ?",NFLOG_SPECIFIC_TIME_EVENT_TABLE_NAME,NFLOG_SPECIFIC_TIME_EVENT_ROW_ID_COL];
    //Downcasting to specific type.
    NFLOGSpecificEventTableRow * specificTimeEventRow = (NFLOGSpecificEventTableRow *)eventRow;
    return [sqlite executeUpdateWithSql:deleteSql withIntParam:(int)[specificTimeEventRow rowId]];
}

@end
