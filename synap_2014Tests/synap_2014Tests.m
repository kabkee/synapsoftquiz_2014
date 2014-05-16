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
@property int tempY, tempX;

@end

@implementation synap_2014Tests
@synthesize gameCtr;
@synthesize tempX, tempY;

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
//    NSLog( greeting );
    XCTAssert([greeting isEqualToString:@"사다리게임 설정을 시작합니다.\r"], @"*** Greeting is not Equal!");
}

- (void)testGameCtrNumberToStringArray
{
    NSString * testInput = @"abc 123, 321abc";
    NSMutableArray * testStringArray = [[NSMutableArray alloc]init];
    
    testStringArray = [gameCtr numberToStringArray:testInput];
    XCTAssertEqual([testStringArray count], 2, @"*** TestStringArray Count is not equal!!");
    
    NSString * index0 = testStringArray[0];
    NSString * index1 = testStringArray[1];
    
    XCTAssert([index0 isEqualToString: @"123"], @"*** First index string is not equal!");
    tempY = [index0 intValue];
    XCTAssert([index1 isEqualToString: @"321"], @"*** Second index string is not equal!");
    tempX = [index1 intValue];
    
    // IntTurningBack validation
    XCTAssert( tempX > 300 , @"*** tempX is not above 100!");
    
    NSLog(@"test result : %@",testStringArray);
}

- (void)testGameCtrLadderPointsDicPerformance
{
    // To Be Confirmed
}

@end
