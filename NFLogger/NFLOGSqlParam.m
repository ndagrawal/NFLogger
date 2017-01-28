//
//  NFLOGSqlParam.m
//  NFLogger
//
//  Created by Nilesh Agrawal on 1/25/17.
//  Copyright © 2017 Nilesh Agrawal. All rights reserved.
//

#import "NFLOGSqlParam.h"

@implementation NFLOGSqlParam
@synthesize numberValue = _numberValue;
@synthesize stringValue = _stringValue;
@synthesize paramType = _paramType;


-(instancetype) initWithInt:(int)intValue
{
    self = [super init];
    if (self)
    {
        self.numberValue = [NSNumber numberWithInt:intValue];
        self.paramType = NFLOGSQLParamTypeInt;
    }
    return self;
}

-(instancetype) initWithString:(NSString *)stringValue
{
    self = [super init];
    if (self)
    {
        self.stringValue = stringValue;
        self.paramType = NFLOGSQLParamTypeText;
    }
    return self;
}

-(instancetype) initWithDouble:(double)dblValue
{
    self = [super init];
    if (self)
    {
        self.numberValue = [NSNumber numberWithDouble:dblValue];
        self.paramType = NFLOGSQLParamTypeDouble;
    }
    return self;
}

+(instancetype) sqlParamWithInt:(NSInteger) intValue
{
    return [[NFLOGSqlParam alloc] initWithInt:(int)intValue];
}

+(instancetype) sqlParamWithDouble:(double)dblValue
{
    return [[NFLOGSqlParam alloc] initWithDouble:dblValue];
}

+(instancetype) sqlParamWithString:(NSString *)stringValue
{
    return [[NFLOGSqlParam alloc] initWithString:stringValue];
}

@end
