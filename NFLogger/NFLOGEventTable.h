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

@protocol NFLOGEventTable <NSObject>

-(BOOL)createTablewithSqlite:(NFLOGSqlite *)sqlite;
-(BOOL)insertEvent:(NFLOGEvent *) event withSqlite:(NFLOGSqlite *)sqlite;
-(BOOL)updateEventRow:(NFLOGEvent *)event withSqlite:(NFLOGSqlite *)sqlite;
-(NSMutableArray<id<NFLOGEventTableRow>> *)selectAllEventswithSqlite:(NFLOGSqlite *)sqlite;
-(BOOL)deleteEvent:(id<NFLOGEventTableRow>)event withSqlite:(NFLOGSqlite *)sqlite;

@end

