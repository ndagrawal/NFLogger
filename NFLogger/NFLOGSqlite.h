//
//  NFLOGSqlite.h
//  NFLogger
//
//  Created by Nilesh Agrawal on 1/25/17.
//  Copyright © 2017 Nilesh Agrawal. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NFLOGSqlParam;


@interface NFLOGSqlite : NSObject
-(BOOL) openWithFileName:(NSString*)fileName;
-(BOOL) openForReadWithFileName:(NSString*)fileName;
-(BOOL) openForCreateWithFileName:(NSString*)fileName;
-(void) close;

/* Execute select sql */
-(NSArray*) queryWithSql:(NSString*)sql;

/* Execute insert/update/delete/create/drop sql */
-(BOOL) executeUpdateWithSql:(NSString*)sql;
-(BOOL) executeUpdateWithSql:(NSString*)sql withIntParam:(int)intParam;
-(BOOL) executeUpdateWithSql:(NSString*)sql withStringParam:(NSString*)stringParam;
-(BOOL) executeUpdateWithSql:(NSString*)sql withDoubleParam:(double)doubleParam;
-(BOOL) executeUpdateWithSql:(NSString*)sql withParam:(NSArray<NFLOGSqlParam *>*)params;

@end
