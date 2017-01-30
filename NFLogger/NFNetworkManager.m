//
//  NFNetworkManager.m
//  NFLogger
//
//  Created by Nilesh Agrawal on 1/27/17.
//  Copyright © 2017 Nilesh Agrawal. All rights reserved.
//

#import "NFNetworkManager.h"
#import "NFLOGLogger.h"

@implementation NFNetworkManager

/**
 
 Note :
 Prefreable choice would be to use "sync" NSURLConnection, but since the API is deprecated, we are using NSURLSession.
 
 Note that "sync"-ronization care is taken through NFRequestManager's uploadAndDeleteMethod while retrieving entries, 
 and then the entries are send to NSURLSession's operation queue to upload. This is to make sure, proper order is ensured .

 The completion block implementation in uploadAndDeleteAll method, 
 makes sure, that we are sending the results in the serialQueue,
 which takes care of deleting the entries from the database.

 Note : We are not using GZIP to avoid using 3rd party in this project.
 
 **/

+(void)uploadAllEvents:(NSDictionary *) dictionary withCompletionBlock:(UploadCompletionBlock)completionBlock{
    
    NSURL *url = [NSURL URLWithString:@"http://httpbin.org/post/"];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    //2 JSON Serialization
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary options:kNilOptions error:&error];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    //Note : We are not using GZIP to avoid using 3rd party in this project
    request.HTTPBody = data;
    request.timeoutInterval = 10.0f;
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    if (!error) {
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * data, NSURLResponse *response, NSError * error) {
            //Check Client Side Errors
            if(error){
                NFLogDebug(@"Error = %@ , Code = %d",error.description,(int)error.code);
                completionBlock(NO);
                return;
            }
            //Check server side error.
            if([response isKindOfClass:[NSHTTPURLResponse class]]){
                NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
                if(statusCode == 200){
                    completionBlock(YES);
                }else{
                    completionBlock(NO);
                }
            }
        }];
        [dataTask resume];
    }
}

@end
