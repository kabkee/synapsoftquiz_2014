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
@property NSMutableDictionary * ladderPointsDic;
@property NSMutableArray * temp1Array;
@property NSMutableArray * temp2Array;
@property NSMutableArray * temp3Array;
@property NSMutableArray * temp4Array;


@end

@implementation synap_2014Tests
@synthesize gameCtr;
@synthesize tempX, tempY;
@synthesize ladderPointsDic;
@synthesize temp1Array, temp2Array, temp3Array, temp4Array;

- (void)setUp
{
    [super setUp];
    gameCtr = [[gameController alloc] init];
    
    ladderPointsDic = gameCtr.ladderPointsDic;
    
    // Setting up a default ladders
    temp1Array = [[NSMutableArray alloc]init];
    temp2Array = [[NSMutableArray alloc]init];
    temp3Array = [[NSMutableArray alloc]init];
    temp4Array = [[NSMutableArray alloc]init];
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

- (void)test_Simulator_GameCtrLadderPointsDicPerformance
{
    [temp1Array addObject:@1]; // 1,1
    [temp2Array addObject:@4]; // 2,4
    [temp3Array addObject:@2]; // 3,2
    [temp3Array addObject:@5]; // 3,5
    [temp4Array addObject:@1]; // 4,1
    [temp4Array addObject:@3]; // 4,3
    [temp4Array addObject:@5]; // 4,5
    
    [ladderPointsDic setObject: temp1Array forKey:@1];
    [ladderPointsDic setObject: temp1Array forKey:@1];
    [ladderPointsDic setObject: temp3Array forKey:@3];
    [ladderPointsDic setObject: temp4Array forKey:@4];
    
    // Checking if there's contants objects, and checking its count max is 3
    if ([ladderPointsDic objectForKey:@1]) {
        NSArray * temp = [ladderPointsDic objectForKey:@1];
        XCTAssert([temp count] == 1, @"*** temp count is not Equal!!");
    };
    
    BOOL canAdd;
    // Checking if its array count is over 3 or not.
    if ([ladderPointsDic objectForKey:@4]) {
        if ([[ladderPointsDic objectForKey:@4] count] >= 3) {
            canAdd = false;
        }else{
            canAdd = true;
        }
    }
    XCTAssert(!canAdd, @"*** canAdd is not False!!");
    
    // Checking if there's room. If there is, add some, or drop it.
    // Ladderpints cannot constanly increased - 1,3,5 or 2,4, or 2,5 or 1,4

    // ladderPoint Y=2 has its object X=[4], There's room for 1,2
//    int tempX = 2;
    if ([ladderPointsDic objectForKey:@2]) {


    }
    
    // ladderPoint Y=3 has its object X=[2,5]. It cannot add more
}

- (void)testGameCtrLadderPointsInsertPossibility
{
    // Simple example
    if ([ladderPointsDic objectForKey:@1]) {
        NSArray * temp = [ladderPointsDic objectForKey:@1];
        XCTAssert([temp count] == 1, @"*** temp count is not Equal!!");
    }else{
        XCTAssertNil([ladderPointsDic objectForKey:@1], @"*** ladderPointsDic object @1 is Not Nil");
    };

    temp1Array = [gameCtr numberToStringArray:@"1,1"];
    tempY = [temp1Array[0] intValue];
    tempX = [temp1Array[1] intValue];
    if ([gameCtr ladderPointInsertPossibility:tempY:tempX]) {
        [gameCtr ladderPointInsert:tempY:tempX];
    };
    
    if ([ladderPointsDic objectForKey:@1]) {
        NSArray * temp = [ladderPointsDic objectForKey:@1];
        NSLog(@"temp Count = %lu",(unsigned long)[temp count]  );
        XCTAssert([temp count] == 1, @"*** temp count is not Equal!!");
    }else{
        XCTAssertNil([ladderPointsDic objectForKey:@1], @"*** ladderPointsDic object @1 is Not Nil");
    };
    
    // Advanced excample
    temp2Array = [gameCtr numberToStringArray:@"2,3"];
    temp3Array = [gameCtr numberToStringArray:@"3,4"];
    NSArray * tempArray = @[@1,@3,@5];
    [ladderPointsDic setObject:tempArray forKey:@3];
    
    // Trying to add "2,3"
    tempY = [temp2Array[0] intValue];
    tempX = [temp2Array[1] intValue];
    if ([gameCtr ladderPointInsertPossibility:tempY:tempX]) {
        [gameCtr ladderPointInsert:tempY:tempX];
    };
    if ([ladderPointsDic objectForKey:@2]) {
        NSArray * temp = [ladderPointsDic objectForKey:@2];
        XCTAssert([temp count] == 1, @"*** temp count is not Equal!!");
        XCTAssert([temp[0] isEqualToNumber:@3], @"*** temp[0] is not Equal!!");
    }else{
        XCTAssertNil([ladderPointsDic objectForKey:@2], @"*** ladderPointsDic object @2 is Not Nil");
    };
    
    // Trying to add "3,4", CANNOT Possible since there're already X=[1,3,5]
    tempY = [temp3Array[0] intValue];
    tempX = [temp3Array[1] intValue];
    if ([gameCtr ladderPointInsertPossibility:tempY:tempX]) {
        [gameCtr ladderPointInsert:tempY:tempX];
    };
    if ([ladderPointsDic objectForKey:@2]) {
        NSArray * temp = [ladderPointsDic objectForKey:@3];
        XCTAssert([temp count] == 3, @"*** temp count is not Equal!!");
        XCTAssert(![temp containsObject:@4], @"*** temp contains object 4!!");
    }
}

- (void)testGameCtrSearchingForResult
{
    NSArray * tempArray = @[@1];
    [ladderPointsDic setObject:tempArray forKey:@1];
    
    int resultFrom1 = [gameCtr searchingForResult:1];
    int resultFrom2 = [gameCtr searchingForResult:2];
    int resultFrom3 = [gameCtr searchingForResult:3];
    int resultFrom4 = [gameCtr searchingForResult:4];
    
    XCTAssert(resultFrom1 == 2, @"*** resultFrom1 == 2 is NOT True!!");
    XCTAssert(resultFrom2 == 1, @"*** resultFrom2 == 1 is NOT True!!");
    XCTAssert(resultFrom3 == 3, @"*** resultFrom3 == 3 is NOT True!!");
    XCTAssert(resultFrom4 == 4, @"*** resultFrom3 == 4 is NOT True!!");
}

- (void)testGameCtrRealSimulator
{
    [ladderPointsDic setObject:@[@1] forKey:@1];
    [ladderPointsDic setObject:@[@4] forKey:@2];
    [ladderPointsDic setObject:@[@2,@5] forKey:@3];
    [ladderPointsDic setObject:@[@3] forKey:@4];
    [ladderPointsDic setObject:@[@2,@5] forKey:@5];
    [ladderPointsDic setObject:@[@1,@4] forKey:@6];
    [ladderPointsDic setObject:@[@3,@5] forKey:@7];
    [ladderPointsDic setObject:@[@2,@4] forKey:@8];
    [ladderPointsDic setObject:@[@1] forKey:@9];
    [ladderPointsDic setObject:@[@3] forKey:@10];
    
    int resultFrom1 = [gameCtr searchingForResult:1];
    int resultFrom2 = [gameCtr searchingForResult:3];
    int resultFrom3 = [gameCtr searchingForResult:6];

    XCTAssert(resultFrom1 == 6, @"*** resultFrom1 == 2 is NOT True!!");
    XCTAssert(resultFrom2 == 5, @"*** resultFrom2 == 1 is NOT True!!");
    XCTAssert(resultFrom3 == 3, @"*** resultFrom3 == 3 is NOT True!!");
}

@end
