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

@interface NFLOGDatabaseManager : NSObject

@property (nonatomic, strong) id<NFLOGEventTable> eventTable;
@property (nonatomic, strong) NSString* dbFilePath;

+(NFLOGDatabaseManager *)sharedInstance;

-(BOOL)createTable;
-(BOOL)insertEvent:(NFLOGEvent *)event;
-(BOOL)updateEvent:(NFLOGEvent *)event;
-(BOOL)deleteEvent:(id<NFLOGEventTableRow>)event;
-(NSMutableArray<id<NFLOGEventTableRow>> *)selectAllEvent;

@end
