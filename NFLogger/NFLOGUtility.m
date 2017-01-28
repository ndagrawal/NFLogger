//
//  NFLOGUtility.m
//  NFLogger
//
//  Created by Nilesh Agrawal on 1/25/17.
//  Copyright © 2017 Nilesh Agrawal. All rights reserved.
//

#import "NFLOGUtility.h"

@implementation NFLOGUtility

+(NSInteger)getUnixtimestamp{
    return [[NSDate date] timeIntervalSince1970] * 1000;
}

@end
