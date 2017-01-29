//
//  NFLOGSqlParam.h
//  NFLogger
//
//  Created by Nilesh Agrawal on 1/25/17.
//  Copyright © 2017 Nilesh Agrawal. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum _nflog_sql_param_type {
    NFLOGSQLParamTypeInt = 0,
    NFLOGSQLParamTypeInt64 = 1,
    NFLOGSQLParamTypeDouble = 2,
    NFLOGSQLParamTypeText = 3,
    NFLOGSQLParamTypeNull = 4,
} NFSQLParamType;

/*!
    @brief Class acts as interpretor to convert the properties as SQLParam to store objects in sqlite.
 */
@interface NFLOGSqlParam : NSObject

@property (nonatomic, strong) NSNumber* numberValue;
@property (nonatomic, strong) NSString* stringValue;
@property (nonatomic, assign) NFSQLParamType paramType;

/*!
    @brief Convert Int to SQLParam
 */
+(instancetype) sqlParamWithInt:(NSInteger)intValue;

/*!
    @brief Convert String to SQLParam
 */
+(instancetype) sqlParamWithString:(NSString *)stringValue;

/*!
    @brief Convert Double to SQLParam
 */
+(instancetype) sqlParamWithDouble:(double)dblValue;

@end
