//
//  NFLOGSqlite.h
//  NFLogger
//
//  Created by Nilesh Agrawal on 1/25/17.
//  Copyright © 2017 Nilesh Agrawal. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NFLOGSqlParam;
/*!
    @brief Class that handles sqlite database. 
    - Open Sqlite database for insert/update/delete/create/drop
    - Close Sqlite database for insert/update/delete/create/drop
 */
@interface NFLOGSqlite : NSObject
/*!
    @brief Open file for writing.
 */
-(BOOL) openWithFileName:(NSString*)fileName;
/*!
    @brief Open file for reading
 */
-(BOOL) openForReadWithFileName:(NSString*)fileName;
/*!
    @brief Open file for creating tables.
 */
-(BOOL) openForCreateWithFileName:(NSString*)fileName;
/*!
    @brief close the sqlite.
 */
-(void) close;

/* Execute select sql */
-(NSArray*) queryWithSql:(NSString*)sql;

/*!
    @brief Execute insert/update/delete/create/drop sql
 */
-(BOOL) executeUpdateWithSql:(NSString*)sql;

/*!
    @brief Execute insert/update/delete/create/drop sql with Int Param.
 */
-(BOOL) executeUpdateWithSql:(NSString*)sql withIntParam:(int)intParam;
/*!
    @brief Execute insert/update/delete/create/drop sql with String Param.
 */
-(BOOL) executeUpdateWithSql:(NSString*)sql withStringParam:(NSString*)stringParam;
/*!
    @brief Execute insert/update/delete/create/drop sql with double Param.
 */
-(BOOL) executeUpdateWithSql:(NSString*)sql withDoubleParam:(double)doubleParam;
/*!
    @brief Execute insert/update/delete/create/drop sql with NSarray Params.
 */
-(BOOL) executeUpdateWithSql:(NSString*)sql withParam:(NSArray<NFLOGSqlParam *>*)params;

@end
