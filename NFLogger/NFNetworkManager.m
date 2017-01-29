//
//  NFNetworkManager.m
//  NFLogger
//
//  Created by Nilesh Agrawal on 1/27/17.
//  Copyright © 2017 Nilesh Agrawal. All rights reserved.
//

#import "NFNetworkManager.h"

@implementation NFNetworkManager

/**
 
 Note :
 Prefreable choice would be to use "sync" NSURLConnection, but since the API is deprecated, we are using NSURLSession.
 
 Note that "sync"-ronization care is taken through NFRequestManager's uploadAndDeleteMethod while retrieving entries, 
 and then the entries are send to NSURLSession's operation queue to upload. This is to make sure, proper order is ensured .

 The completion block implementation in uploadAndDeleteAll method, 
 makes sure, that we are sending the results in the serialQueue,
 which takes care of deleting the entries from the database.

 **/

-(void)uploadAllEvents:(NSDictionary *) dictionary withCompletionBlock:(UploadCompletionBlock)completionBlock{
    
    // 1
    NSURL *url = [NSURL URLWithString:@"http://httpbin.org/post/"];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    // 2
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    
    // 3
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary
                                                   options:kNilOptions error:&error];
    request.HTTPBody = data;
    
    if (!error) {
        // 4
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * data, NSURLResponse *response, NSError * error) {
            if(error == nil){
                
            }
            
            completionBlock(data);
            
        }];
        // 5
        [dataTask resume];
    }
}

@end
