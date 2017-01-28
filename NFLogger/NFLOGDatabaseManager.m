//
//  NFLOGDatabaseManager.m
//  NFLogger
//
//  Created by Nilesh Agrawal on 1/25/17.
//  Copyright © 2017 Nilesh Agrawal. All rights reserved.
//

#import "NFLOGDatabaseManager.h"
#import "NFLOGSqlite.h"

static NFLOGDatabaseManager* dbManager;

@implementation NFLOGDatabaseManager

+(id)sharedInstance{
    static dispatch_once_t queueOnceToken;
    dispatch_once(&queueOnceToken, ^{
        dbManager = [[NFLOGDatabaseManager alloc] init];
    });
    return dbManager;
}

-(id) init{
    self = [super init];
    if (self){
        self.dbFilePath = [self createDBFolder];
    }
    return self;
}

-(NSString*) createDBFolder{
    NSArray* libFolders = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* libFolder = [libFolders objectAtIndex:0];
    NSString* dbFolder = [libFolder stringByAppendingPathComponent:@"nflog"];
    if(![[NSFileManager defaultManager] fileExistsAtPath:dbFolder]){
        NSError* error = nil;
        if(![[NSFileManager defaultManager] createDirectoryAtPath:dbFolder withIntermediateDirectories:YES attributes:nil error:&error]){
            NSLog(@"cannot create folder for nflogfile %@",error);
            return nil;
        }
    }
    return [dbFolder stringByAppendingPathComponent:@"nflogfile.db"];
}

-(BOOL)createTable{
    if (self.dbFilePath == nil){
        return NO;
    }
    NFLOGSqlite* sqlite = [[NFLOGSqlite alloc] init];
    if(![sqlite openForCreateWithFileName:self.dbFilePath]){
        return NO;
    }
    BOOL ret = [_eventTable createTablewithSqlite:sqlite];
    [sqlite close];
    return ret;
}

-(BOOL)insertEvent:(NFLOGEvent *)event{
    if (self.dbFilePath == nil){
        return nil;
    }
    NFLOGSqlite* sqlite = [[NFLOGSqlite alloc] init];
    if(![sqlite openWithFileName:self.dbFilePath])
    {
        return nil;
    }
    BOOL ret = [_eventTable insertEvent:event withSqlite:sqlite];
    [sqlite close];
    return ret;
}

-(BOOL)updateEvent:(NFLOGEvent *)event{
    if (self.dbFilePath == nil)
    {
        return nil;
    }
    NFLOGSqlite* sqlite = [[NFLOGSqlite alloc] init];
    if(![sqlite openWithFileName:self.dbFilePath])
    {
        return nil;
    }
    if(sqlite == nil){
        return nil;
    }
    BOOL ret = [_eventTable updateEventRow:event withSqlite:sqlite];
    [sqlite close];
    return ret;
}

-(BOOL)deleteEvent:(id<NFLOGEventTableRow>)event{
    if (self.dbFilePath == nil){
        return nil;
    }
    NFLOGSqlite* sqlite = [[NFLOGSqlite alloc] init];
    if(![sqlite openWithFileName:self.dbFilePath]){
        return nil;
    }
    if(sqlite == nil){
        return nil;
    }
    BOOL ret = [_eventTable deleteEvent:event withSqlite:sqlite];
    [sqlite close];
    return ret;
}

-(NSMutableArray<id<NFLOGEventTableRow>> *)selectAllEvent{
    if (self.dbFilePath == nil){
        return nil;
    }
    NFLOGSqlite* sqlite = [[NFLOGSqlite alloc] init];
    if(![sqlite openForReadWithFileName:self.dbFilePath]){
        return nil;
    }
    if (sqlite == nil){
        return nil;
    }
    NSMutableArray<id<NFLOGEventTableRow>> *metrics = [_eventTable selectAllEventswithSqlite:sqlite];
    [sqlite close];
    return metrics;
    
}

@end
