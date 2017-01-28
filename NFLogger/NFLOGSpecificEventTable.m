//
//  NFLOGSpecificEventTable.m
//  NFLogger
//
//  Created by Nilesh Agrawal on 1/25/17.
//  Copyright © 2017 Nilesh Agrawal. All rights reserved.
//

#import "NFLOGSpecificEventTable.h"

@implementation NFLOGSpecificEventTable

-(BOOL)createTablewithSqlite:(NFLOGSqlite *)sqlite{
    
    return NO;
}

-(BOOL)insertEvent:(NFLOGEvent *) event withSqlite:(NFLOGSqlite *)sqlite{
    
    return NO;
}

-(BOOL)updateEventRow:(NFLOGEvent *)event withSqlite:(NFLOGSqlite *)sqlite{
    
    return NO;
}

-(NSMutableArray<id<NFLOGEventTableRow>> *)selectAllEventswithSqlite:(NFLOGSqlite *)sqlite{
    return nil;
}

-(BOOL)deleteEvent:(id<NFLOGEventTableRow>)event withSqlite:(NFLOGSqlite *)sqlite{
    
    return NO;
}

@end
