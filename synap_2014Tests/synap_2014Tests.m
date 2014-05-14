//
//  synap_2014Tests.m
//  synap_2014Tests
//
//  Created by Kabkee Moon on 2014. 5. 12..
//  Copyright (c) 2014년 Kabkee Moon. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "gameController.h"

@interface synap_2014Tests : XCTestCase
@property gameController *gameCtr;

@end

@implementation synap_2014Tests
@synthesize gameCtr;

- (void)setUp
{
    [super setUp];
    gameCtr = [[gameController alloc] init];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testGameCtrInitiation
{
    NSString *greeting = [gameCtr startGreeting];
    NSLog( greeting );
}

- (void)testGameCtrNumberToStringArray
{

    NSString * testInput = @"abc 123, 321abc";
    NSMutableArray * testStringArray = [[NSMutableArray alloc]init];
    
    testStringArray = [gameCtr numberToStringArray:testInput];
    XCTAssertEqual([testStringArray count], 2, @"TestStringArray Count is not equal!!");
    XCTAssert([testStringArray[0] isEqualToString: @"123"], @"First index string is not equal!");
    XCTAssert([testStringArray[1] isEqualToString: @"321"], @"Second index string is not equal!");
    
    NSLog(@"test result : %@",testStringArray);
}

@end
