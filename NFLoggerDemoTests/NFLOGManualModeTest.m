//
//  NFLOGManualModeTest.m
//  NFLogger
//
//  Created by Nilesh Agrawal on 1/28/17.
//  Copyright © 2017 Nilesh Agrawal. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NFLogger.h"
#import "NFLOGManualBehaviour.h"

@interface NFLOGManualModeTest : XCTestCase
@property NFLOGManualBehaviour *manualBehaviour;
@end

@implementation NFLOGManualModeTest
@synthesize manualBehaviour = _manualBehaviour;

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    [NFLogger initializeSDKWithMode:NFLOGManualCapture];
    _manualBehaviour = [[NFLOGManualBehaviour alloc] init];
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
#pragma mark - Manual Behaviour
-(void)testAutoLogEventWithCompletionHandlerWithNilParameters{
    [_manualBehaviour logEvent:@"event" withParameters:nil completionBlock:^(NFLOGRecordStatus recordStatus) {
        dispatch_async(dispatch_get_main_queue(), ^{
            XCTAssertEqual(recordStatus,NFLOGEventRecorded);
        });
    }];
}

-(void)testAutoLogEventWithCompletionHandlerWithValidParameters{
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"testObject1",@"key1",nil];
    [_manualBehaviour logEvent:@"event" withParameters:dictionary completionBlock:^(NFLOGRecordStatus recordStatus) {
        dispatch_async(dispatch_get_main_queue(), ^{
            XCTAssertEqual(recordStatus,NFLOGEventRecorded);
        });
        
    }];
}


-(void)testStartActiveLogEventWithCompletionHandlerWithNilParameters{
    [_manualBehaviour startActiveEvent:@"event" withParameters:nil completionBlock:^(NFLOGRecordStatus recordStatus) {
        dispatch_async(dispatch_get_main_queue(), ^{
            XCTAssertEqual(recordStatus,NFLOGEventRecorded);
        });
    }];
}


-(void)testStartActiveLogEventWithCompletionHandlerWithValidParameters{
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"testObject1",@"key1",nil];
    [_manualBehaviour startActiveEvent:@"event" withParameters:dictionary completionBlock:^(NFLOGRecordStatus recordStatus) {
        dispatch_async(dispatch_get_main_queue(), ^{
            XCTAssertEqual(recordStatus,NFLOGEventRecorded);
        });
    }];
}

-(void)testEndActiveLogEventWithEventWithValidEvent{
    [_manualBehaviour endActiveEvent:@"event" completionBlock:^(NFLOGRecordStatus recordStatus) {
        dispatch_async(dispatch_get_main_queue(), ^{
            XCTAssertEqual(recordStatus,NFLOGEventRecorded);
        });
    }];
}

@end
