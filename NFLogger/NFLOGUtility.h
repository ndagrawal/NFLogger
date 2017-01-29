//
//  NFLOGUtility.h
//  NFLogger
//
//  Created by Nilesh Agrawal on 1/25/17.
//  Copyright © 2017 Nilesh Agrawal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NFLOGEventTableRow.h"

@interface NFLOGUtility : NSObject

+(NSInteger)getUnixtimestamp;
+(NSDictionary *)convertToJSON:(NSMutableArray<id<NFLOGEventTableRow>> *)eventRows;
+(NSString *)convertToString:(NSDictionary *)dict;
+(NSDictionary *)convertToDictionary:(NSString *)string;
@end
