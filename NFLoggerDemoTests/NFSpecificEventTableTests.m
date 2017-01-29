//
//  NFSpecificEventTableTests.m
//  NFLogger
//
//  Created by Nilesh Agrawal on 1/28/17.
//  Copyright © 2017 Nilesh Agrawal. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NFLOGDatabaseManager.h"
#import "NFLOGTableFactory.h"
#import "NFLOGConstants.h"
#import "NFLOGSpecificEventTable.h"
#import "NFLOGSpecificEventTableRow.h"
#import "NFLOGEventTableRow.h"
#import "NFLOGUtility.h"
#import "NFLOGEvent.h"

@interface NFSpecificEventTableTests : XCTestCase
@property (nonnull, nonatomic, strong) NFLOGDatabaseManager* db;
@end

@implementation NFSpecificEventTableTests

-(NFLOGDatabaseManager *)createInstance{
    return [[NFLOGDatabaseManager alloc] init];
}


- (void)setUp {
    [super setUp];
    self.db = [NFLOGDatabaseManager sharedInstance];
}

-(void)tearDown{
    [super tearDown];
}

#pragma mark - Test Singleton Method

-(void)testSingletonMethod{
    //TEST CASE 1: Test singleoton is not nil..
    XCTAssertNotNil([NFLOGDatabaseManager sharedInstance]);
    //TEST CASE 2 : TEST Singleton unique Instance Created
    XCTAssertNotNil([self createInstance]);
    NFLOGDatabaseManager *s1 = [NFLOGDatabaseManager sharedInstance];
    //TEST CASE 3 : Test singleton returns same shared instance twice
    XCTAssertEqual(s1, [NFLOGDatabaseManager  sharedInstance]);
    //TEST CASE 4 : Test Singleton Shared Instance is separate from unique instance
    XCTAssertNotEqual(s1, [self createInstance]);
    //TEST CASE 5 : Test that we get different unique instance, each time we call alloc init.
    NFLOGDatabaseManager *s2 = [self createInstance];
    XCTAssertNotEqual(s2, [self createInstance]);

}

#pragma mark - Create Method
-(void)testCreateTableForSpecificEvent{
    
    [_db setEventTable:[NFLOGTableFactory getTableInstance:NFLOG_SPECIFIC_TIME_EVENT]];
    XCTAssertTrue([[_db eventTable] isKindOfClass:[NFLOGSpecificEventTable class]],@"Could not get instance of type NFLOGSpecificEventTable ... from factory method");
    BOOL specificEventTableSucess = [_db createTable];
    XCTAssertTrue(specificEventTableSucess,@"Could not create specific event table");
}

#pragma mark - Insert Method
-(void)testInsertInSpecificEventTable{
    
    //TEST CASE 1 : Insertion into the network table
    double start1 = [NFLOGUtility getUnixtimestamp];
    NFLOGEvent *event1  = [[NFLOGEvent alloc] initWithEventName:@"SampleEventName" eventType:NFLOG_SPECIFIC_TIME_EVENT eventParameters:nil timeStamp:start1];
    XCTAssert(event1,@"event  is nil ... ");
    
    id<NFLOGEventTable> eventTable = [NFLOGTableFactory getTableInstance:[event1 eventType]];
    XCTAssert(eventTable,@"event Table is nil");
    
    [_db setEventTable:eventTable];
    XCTAssert([_db eventTable],@"event Table is not set properly");
    
    BOOL ret = [_db insertEvent:event1];
    XCTAssertTrue(ret,@"Insert Query failed in Specific Event Table");
}

-(void)testInsertingNilEventInSpecicEventTable{
    //TEST CASE 1 : Insertion into the network table
    double start1 = [NFLOGUtility getUnixtimestamp];
    NFLOGEvent *event1  = [[NFLOGEvent alloc] initWithEventName:@"SampleEventName" eventType:NFLOG_SPECIFIC_TIME_EVENT eventParameters:nil timeStamp:start1];
    XCTAssert(event1,@"event  is nil ... ");
    
    id<NFLOGEventTable> eventTable = [NFLOGTableFactory getTableInstance:[event1 eventType]];
    XCTAssert(eventTable,@"event Table is nil");
    
    [_db setEventTable:eventTable];
    XCTAssert([_db eventTable],@"event Table is not set properly");
               
    BOOL ret = [_db insertEvent:event1];
    XCTAssertTrue(ret,@"Insert Query failed in Specific Event Table");
    
}
               
-(void)testInsertInNetworkTableWithNilSqlite{
    
    double start1 = [NFLOGUtility getUnixtimestamp];
    NFLOGEvent *event1  = [[NFLOGEvent alloc] initWithEventName:@"SampleEventName" eventType:NFLOG_SPECIFIC_TIME_EVENT eventParameters:nil timeStamp:start1];
    XCTAssert(event1,@"event  is nil ... ");
    
    NFLOGSpecificEventTable *eventTable = [NFLOGTableFactory getTableInstance:[event1 eventType]];
    XCTAssert(eventTable,@"event Table is nil");
    
    BOOL ret = [eventTable insertEvent:event1 withSqlite:nil];
    XCTAssertFalse(ret,@"Insert Query should not store inspite of nil sqlite");
}

-(void)testInsertOfNilEvent{
    NFLOGEvent *event = nil;
    NFLOGSpecificEventTable *eventTable = [NFLOGTableFactory getTableInstance:NFLOG_SPECIFIC_TIME_EVENT];
    XCTAssert(eventTable,@"event Table is nil");
    
    BOOL ret = [_db insertEvent:event];
    XCTAssertFalse(ret,@"Insert Query should not store inspite of nil sqlite");
}
            
               
#pragma mark - SelectAllEvents
-(void)testSelectAllEventsAferRemovingAllEvents{
    //Removing all the events
     NFLOGSpecificEventTable *eventTable = [NFLOGTableFactory getTableInstance:NFLOG_SPECIFIC_TIME_EVENT];
     [_db setEventTable:eventTable];
    
    NSMutableArray<id<NFLOGEventTableRow>> *events = [_db selectAllEvent];
    for(id<NFLOGEventTableRow> event in events){
        [_db deleteEvent:event];
    }
    events = [_db selectAllEvent];
    XCTAssertEqual([events count], 0);
}

-(void)testSelectAllEventsInSpecificEventTableAfterInsertion{
    //Removing all the events..
    NFLOGSpecificEventTable *eventTable = [NFLOGTableFactory getTableInstance:NFLOG_SPECIFIC_TIME_EVENT];
    [_db setEventTable:eventTable];
    
    NSMutableArray<id<NFLOGEventTableRow>> *events = [_db selectAllEvent];
    for(id<NFLOGEventTableRow> event in events){
        [_db deleteEvent:event];
    }
    events = [_db selectAllEvent];
    XCTAssertEqual([events count], 0);
    
    //Adding one entry to the specific event table
    double start1 = [NFLOGUtility getUnixtimestamp];
    NFLOGEvent *event1  = [[NFLOGEvent alloc] initWithEventName:@"SampleEventName" eventType:NFLOG_SPECIFIC_TIME_EVENT eventParameters:nil timeStamp:start1];
    XCTAssert(event1,@"event  is nil ... ");
    
    [_db setEventTable:eventTable];
    XCTAssert([_db eventTable],@"event Table is not set properly");
               
    BOOL ret = [_db insertEvent:event1];
    XCTAssertTrue(ret,@"Insert Query failed in Specific Event Table");
              
    events = [_db selectAllEvent];
    XCTAssertEqual([events count], 1);
}
               
#pragma mark - Delete Method...
-(void)testDeleteEventMethod{
    //Removing all the events..
    NFLOGSpecificEventTable *eventTable = [NFLOGTableFactory getTableInstance:NFLOG_SPECIFIC_TIME_EVENT];
    [_db setEventTable:eventTable];
    
    NSMutableArray<id<NFLOGEventTableRow>> *events = [_db selectAllEvent];
    for(id<NFLOGEventTableRow> event in events){
        [_db deleteEvent:event];
    }
    events = [_db selectAllEvent];
    XCTAssertEqual([events count], 0);
}

-(void)testDeleteEventMethodWithNilEvent{
    //Removing all the events..
    NFLOGSpecificEventTable *eventTable = [NFLOGTableFactory getTableInstance:NFLOG_SPECIFIC_TIME_EVENT];
    [_db setEventTable:eventTable];
    XCTAssertFalse([_db deleteEvent:nil],@"No event to delete");
}

@end
