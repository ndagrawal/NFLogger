//
//  NFLOGSpecificEventTableRow.h
//  NFLogger
//
//  Created by Nilesh Agrawal on 1/25/17.
//  Copyright © 2017 Nilesh Agrawal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NFLOGEventTableRow.h"

@class NFLOGSqlParam;

@interface NFLOGSpecificEventTableRow : NSObject<NFLOGEventTableRow>

@property (nonatomic,assign) NSInteger rowId;
@property (nonatomic,strong) NSString * eventName;
@property (nonatomic,strong) NSString * eventParameters;
@property (nonatomic,assign) double timestamp;

-(NFLOGSqlParam *)eventNameParam;
-(NFLOGSqlParam *)eventTypeParam;
-(NFLOGSqlParam *)eventParametersParam;
-(NFLOGSqlParam *)eventTimeStampParam;

@end
