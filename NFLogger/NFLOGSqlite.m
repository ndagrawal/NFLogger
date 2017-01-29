//
//  NFLOGSqlite.m
//  NFLogger
//
//  Created by Nilesh Agrawal on 1/25/17.
//  Copyright © 2017 Nilesh Agrawal. All rights reserved.
//

#import "NFLOGSqlite.h"
#import "NFLOGSqlParam.h"
#import <sqlite3.h>
#import "NFLOGLogger.h"

@interface NFLOGSqlite(){
    struct sqlite3* sqlite;
}
@end

@implementation NFLOGSqlite

-(id) init
{
    self = [super init];
    if (self){
        /*Making structure null , this struct will get space allocated during openwithfilename.*/
        sqlite = NULL;
    }
    return self;
}

-(void) dealloc
{
    [self close];
}

-(BOOL) openWithFileName:(NSString*)fileName openFlags:(int)flags{
    
    if (fileName == nil || [fileName length] == 0){
        NFLogDebug(@"Cannot open sqlite database because file name is nil");
        return NO;
    }
    
    // Close previous connection if exists
    [self close];
    
    const char* file = [fileName UTF8String];
    int ret = sqlite3_open_v2(file, &sqlite, flags, NULL);
    if( ret != SQLITE_OK){
        NFLogError(@"%@",[NSString stringWithFormat:@"Cannot open sqlite database: %@, error code: %ld", fileName, (long)ret]);
        [self close];
        return NO;
    }
    return YES;
    
}

-(BOOL) openWithFileName:(NSString*)fileName{
    return [self openWithFileName:fileName openFlags:SQLITE_OPEN_READWRITE | SQLITE_OPEN_NOMUTEX ];
}

-(BOOL) openForReadWithFileName:(NSString*)fileName{
    return [self openWithFileName:fileName openFlags:SQLITE_OPEN_READONLY | SQLITE_OPEN_NOMUTEX];
}

-(BOOL) openForCreateWithFileName:(NSString*)fileName{
    return [self openWithFileName:fileName openFlags:SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE];
}

-(void) close{
    if (sqlite != NULL){
        sqlite3_close(sqlite);
        sqlite = NULL;
    }
}

int execCallback(void* arg1, int numOfColumn, char** columnValues, char** columnNames){
    if (numOfColumn == 0){
        return SQLITE_OK;
    }
    
    NSMutableArray* result = (__bridge NSMutableArray *)(arg1);
    
    NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithCapacity:numOfColumn];
    for (int i = 0; i < numOfColumn; ++i){
        char* columnName = columnNames[i];
        char* columnValue = columnValues[i];
        if (columnName == NULL){
            NFLogError(@"%@",[NSString stringWithFormat:@"Execute query sql failed because column name is NULL, column index: %ld",(long)i]);
            return SQLITE_ABORT;
        }
        NSString* key = [NSString stringWithUTF8String:columnName];
        NSString* value;
        if (columnValue == NULL){
            value = @"";
        }else{
            value = [NSString stringWithUTF8String:columnValue];
        }
        [dict setObject:value forKey:key];
    }
    [result addObject:dict];
    
    return SQLITE_OK;
}

-(NSArray*) queryWithSql:(NSString*)sql{
    if (sqlite == NULL){
        return nil;
    }
    
    if (sql == nil || [sql length] == 0){
        NFLogDebug(@"Cannot execute query sql because sql string is nil");
        return nil;
    }
    
    const char* querySql = [sql UTF8String];
    char* errmsg = NULL;
    NSMutableArray* result = [NSMutableArray array];
    int ret = sqlite3_exec(sqlite, querySql, execCallback, (__bridge void *)(result), &errmsg);
    if (errmsg != NULL){
        NFLogError(@"%@",[NSString stringWithFormat:@"Execute query sql failed: %@, error message: %@, error code: %ld", sql, [NSString stringWithUTF8String:errmsg], (long)ret]);
        sqlite3_free(errmsg);
        errmsg = NULL;
        return nil;
    }
    
    if (ret != SQLITE_OK && ret != SQLITE_ABORT){
        NFLogError(@"%@",[NSString stringWithFormat:@"Execute query sql failed: %@, error code: %ld", sql, (long)ret]);
        return nil;
    }
    return result;
}

-(BOOL) executeUpdateWithSql:(NSString*)sql{
    if (sqlite == NULL){
        return NO;
    }
    
    if (sql == nil || [sql length] == 0){
          NFLogDebug(@"Cannot execute update sql because sql string is nil");
        return NO;
    }
    
    const char* updateSql = [sql UTF8String];
    char* errmsg = NULL;
    int ret = sqlite3_exec(sqlite, updateSql, NULL, NULL, &errmsg);
    if (errmsg != NULL){
        NFLogError(@"%@",[NSString stringWithFormat:@"Execute update sql failed: %@, error message: %@, error code: %ld", sql, [NSString stringWithUTF8String:errmsg], (long)ret]);
        sqlite3_free(errmsg);
        errmsg = NULL;
        return NO;
    }
    
    if (ret != SQLITE_OK){
        NFLogError(@"%@",[NSString stringWithFormat:@"Execute update sql failed: %@, error code: %ld", sql, (long)ret]);
        return NO;
    }
    return YES;
}

-(BOOL) executeUpdateWithSql:(NSString *)sql withIntParam:(int)intParam{
    return [self executeUpdateWithSql:sql withParam:@[ [NFLOGSqlParam sqlParamWithInt:intParam] ]];
}

-(BOOL) executeUpdateWithSql:(NSString *)sql withStringParam:(NSString*)stringParam{
    return [self executeUpdateWithSql:sql withParam:@[ [NFLOGSqlParam sqlParamWithString:stringParam] ]];
}

-(BOOL) executeUpdateWithSql:(NSString *)sql withDoubleParam:(double)doubleParam{
    return [self executeUpdateWithSql:sql withParam:@[ [NFLOGSqlParam sqlParamWithDouble:doubleParam] ]];
}


-(BOOL) executeUpdateWithSql:(NSString *)sql withParam:(NSArray<NFLOGSqlParam*>*)params{
    if (sqlite == NULL){
        return NO;
    }
    
    if (sql == nil || [sql length] == 0){
        NFLogDebug(@"Cannot execute update sql because sql string is nil");
        return NO;
    }
    
    const char* updateSql = [sql UTF8String];
    struct sqlite3_stmt* stmt = NULL;
    int ret = sqlite3_prepare_v2(sqlite, updateSql, -1, &stmt, NULL);
    if (ret != SQLITE_OK || stmt == NULL){
        NFLogDebug(@"%@",[NSString stringWithFormat:@"Execute update sql with parameters failed, prepare sql return error code: %ld", (long)ret]);
        return NO;
    }
    
    int index = 1;
    for (NFLOGSqlParam* param in params){
        switch (param.paramType){
            case NFLOGSQLParamTypeInt:
                ret = sqlite3_bind_int(stmt, index, [param.numberValue intValue]);
                break;
            case NFLOGSQLParamTypeDouble:
                ret = sqlite3_bind_double(stmt, index, [param.numberValue doubleValue]);
                break;
            case NFLOGSQLParamTypeText:
                ret = sqlite3_bind_text(stmt, index, [param.stringValue UTF8String], -1, NULL);
                break;
            case NFLOGSQLParamTypeNull:
                ret = sqlite3_bind_null(stmt, index);
                break;
            default:
                break;
        }
        
        index++;
        
        if (ret != SQLITE_OK){
            NFLogDebug(@"%@",[NSString stringWithFormat:@"Execute update sql with parameters failed, bind %ld parameter return error code: %ld", (long)index, (long)ret]);
            sqlite3_finalize(stmt);
            return NO;
        }
    }
    ret = sqlite3_step(stmt);
    if (ret != SQLITE_OK && ret != SQLITE_DONE){
        NFLogDebug(@"%@",[NSString stringWithFormat:@"Execut update sql with paramters failed, step return error code: %ld", (long)ret]);
        sqlite3_finalize(stmt);
        return NO;
    }
    
    sqlite3_finalize(stmt);
    return YES;
}

@end
