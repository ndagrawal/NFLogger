//
//  NFLOGAutomaticModeTest.m
//  NFLogger
//
//  Created by Nilesh Agrawal on 1/28/17.
//  Copyright © 2017 Nilesh Agrawal. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NFLogger.h"
#import "NFLOGAutoBehaviour.h"

@interface NFLOGAutomaticModeTest : XCTestCase
@property NFLOGAutoBehaviour *autoLogBehaviour;

@end

@implementation NFLOGAutomaticModeTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    [NFLogger initializeSDKWithMode:NFLOGAutoCapture];
    _autoLogBehaviour = [[NFLOGAutoBehaviour alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testLogEventWithCompletionHandler{
    [NFLogger logEvent:@"event" withParameters:nil completionBlock:^(NFLOGRecordStatus recordStatus) {
        dispatch_async(dispatch_get_main_queue(), ^{
           XCTAssertEqual(recordStatus,NFLOGEventRecorded);
        });
    }];
}

-(void)testLogEventWithCompletionHandlerwithNilEvent{
    [NFLogger logEvent:nil withParameters:nil completionBlock:^(NFLOGRecordStatus recordStatus) {
        dispatch_async(dispatch_get_main_queue(), ^{
            XCTAssertEqual(recordStatus,NFLOGEventRecorded);
        });
    }];
}

-(void)testLogEventWithCompletionHandlerwithValidParameters{
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"testObject1",@"key1",nil];
    [NFLogger logEvent:@"event" withParameters:dictionary completionBlock:^(NFLOGRecordStatus recordStatus) {
        dispatch_async(dispatch_get_main_queue(), ^{
            XCTAssertEqual(recordStatus,NFLOGEventRecorded);
        });
    }];
}
#pragma mark - Auto Behaviour
-(void)testAutoLogEventWithCompletionHandlerWithNilParameters{
    [_autoLogBehaviour logEvent:@"event" withParameters:nil completionBlock:^(NFLOGRecordStatus recordStatus) {
        dispatch_async(dispatch_get_main_queue(), ^{
            XCTAssertEqual(recordStatus,NFLOGEventRecorded);
        });
    }];
}

-(void)testAutoLogEventWithCompletionHandlerWithValidParameters{
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"testObject1",@"key1",nil];
    [_autoLogBehaviour logEvent:@"event" withParameters:dictionary completionBlock:^(NFLOGRecordStatus recordStatus) {
        dispatch_async(dispatch_get_main_queue(), ^{
            XCTAssertEqual(recordStatus,NFLOGEventRecorded);
        });

    }];
}


-(void)testStartActiveLogEventWithCompletionHandlerWithNilParameters{
    [_autoLogBehaviour startActiveEvent:@"event" withParameters:nil completionBlock:^(NFLOGRecordStatus recordStatus) {
        dispatch_async(dispatch_get_main_queue(), ^{
            XCTAssertEqual(recordStatus,NFLOGEventRecorded);
        });
    }];
}


-(void)testStartActiveLogEventWithCompletionHandlerWithValidParameters{
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"testObject1",@"key1",nil];
    [_autoLogBehaviour startActiveEvent:@"event" withParameters:dictionary completionBlock:^(NFLOGRecordStatus recordStatus) {
        dispatch_async(dispatch_get_main_queue(), ^{
            XCTAssertEqual(recordStatus,NFLOGEventRecorded);
        });
    }];
}

-(void)testEndActiveLogEventWithEventWithValidEvent{
    [_autoLogBehaviour endActiveEvent:@"event" completionBlock:^(NFLOGRecordStatus recordStatus) {
        dispatch_async(dispatch_get_main_queue(), ^{
            XCTAssertEqual(recordStatus,NFLOGEventRecorded);
        });
    }];
}

@end
