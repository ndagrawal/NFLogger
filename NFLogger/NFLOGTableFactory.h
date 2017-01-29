//
//  NFLOGTableFactory.h
//  NFLogger
//
//  Created by Nilesh Agrawal on 1/25/17.
//  Copyright © 2017 Nilesh Agrawal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NFLOGEventTable.h"

/*!
    @brief Factory class to get table instance based on tableName.
    static factory design pattern.
 */
@interface NFLOGTableFactory : NSObject

+(id<NFLOGEventTable>)getTableInstance:(NSString *)tableName;

@end
