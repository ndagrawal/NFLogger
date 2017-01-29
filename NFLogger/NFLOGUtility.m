//
//  NFLOGUtility.m
//  NFLogger
//
//  Created by Nilesh Agrawal on 1/25/17.
//  Copyright © 2017 Nilesh Agrawal. All rights reserved.
//

#import "NFLOGUtility.h"
#import "NFLOGConstants.h"
#import <UIKit/UIKit.h>

@implementation NFLOGUtility

+(NSInteger)getUnixtimestamp{
    return [[NSDate date] timeIntervalSince1970] * 1000;
}

+(NSString *)getDeviceId{
    UIDevice *device = [UIDevice currentDevice];
    NSString  *currentDeviceId = [[device identifierForVendor]UUIDString];
    return currentDeviceId;
}

+(NSString *)getAppKey{
    return @"xyz123abc";
}

+(NSDictionary *)getJSONHeaderParams{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setObject:[NFLOGUtility getDeviceId] forKey:NFLOG_APP_KEY];
    [dictionary setObject:[NFLOGUtility getAppKey] forKey:NFLOG_DEVICE_ID_KEY];
    return [dictionary copy];
}

+(NSDictionary *)convertToJSON:(NSMutableArray<id<NFLOGEventTableRow>> *)eventRows{
    if(eventRows == nil || [eventRows count] == 0){
        return nil;
    }
    
    NSMutableDictionary *jsonDictionary = [[NSMutableDictionary alloc] init];
    [jsonDictionary setObject:[NFLOGUtility getJSONHeaderParams] forKey:NFLOG_JSON_KEY_HDR];
    NSMutableArray *eventArray = [[NSMutableArray alloc] init];
    for(id<NFLOGEventTableRow> event in eventRows){
        [eventArray addObject:[event toDictionary]];
    }
    [jsonDictionary setObject:eventArray forKey:NFLOG_JSON_KEY_EVENTS];
    return [jsonDictionary copy];
}

+(NSString *)convertToString:(NSDictionary *)dict{
    NSString *dictString = nil;
    if(dict !=nil){
        NSError * err;
        NSData * jsonData = [NSJSONSerialization  dataWithJSONObject:dict options:0 error:&err];
        dictString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return dictString;
}

+(NSDictionary *)convertToDictionary:(NSString *)string{
    NSError *jsonError;
    NSData *objectData = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                                         options:NSJSONReadingMutableContainers
                                                           error:&jsonError];
    return json;
}
@end
