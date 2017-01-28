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

@interface NFLOGSqlParam : NSObject

@property (nonatomic, strong) NSNumber* numberValue;
@property (nonatomic, strong) NSString* stringValue;
@property (nonatomic, assign) NFSQLParamType paramType;

+(instancetype) sqlParamWithInt:(NSInteger)intValue;
+(instancetype) sqlParamWithString:(NSString *)stringValue;
+(instancetype) sqlParamWithDouble:(double)dblValue;

@end
