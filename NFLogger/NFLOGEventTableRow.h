//
//  NFLOGEventTableRow.h
//  NFLogger
//
//  Created by Nilesh Agrawal on 1/25/17.
//  Copyright © 2017 Nilesh Agrawal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NFLOGEvent.h"

@protocol NFLOGEventTableRow <NSObject>
-(id)initWithEvent:(NFLOGEvent *)event;
-(void)configWithDict:(NSDictionary *)dict;
-(NSDictionary *)toDictionary;
-(NSString *)toString;
-(NSString *)description;
@end
