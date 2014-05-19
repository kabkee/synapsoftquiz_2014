//
//  gameController.m
//  synap_2014
//
//  Created by Kabkee Moon on 2014. 5. 12..
//  Copyright (c) 2014년 Kabkee Moon. All rights reserved.
//

#import "gameController.h"

@interface gameController()

@end


@implementation gameController
@synthesize startGreeting, endGreeting, reGameAsk, ladderInputAsk, snakeInputAsk, retypeReminder;
@synthesize gameStage;
@synthesize ladderPointsDic;

- (id) init
{
    startGreeting = @"사다리게임 설정을 시작합니다.\r";
    ladderInputAsk = @"사다리 정보를 입력하세요(x는 입력 완료).\r";
    snakeInputAsk = @"사다리 게임을 시작할 출발 지점을 입력하세요(x는 입력 완료).\r";
    reGameAsk = @"처음부터 다시 하시겠습니까?(y/n)\r";
    endGreeting = @"사다리게임을 종료합니다.\r";
    retypeReminder = @"다시 입력해주세요.\r";

    // 1: (y,x), 2: player number, 3: Restart?, 4: End
    gameStage = 1;
    ladderPointsDic = [[NSMutableDictionary alloc]init];
    
    return self;
}

// Stripped only Strings
- (NSMutableArray *)numberToStringArray: (NSString *)stringSet
{
	//NSString *stringSet = @"abc 123, 321 abc";
	NSMutableString *strippedString = [[NSMutableString alloc]init];
	
	NSScanner *scannerForInput = [NSScanner scannerWithString:stringSet];
	NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
	NSCharacterSet *commaSet = [NSCharacterSet characterSetWithCharactersInString:@","];
	
    NSMutableArray *stringArray = [[NSMutableArray alloc]init];

    NSString *frontBuffer;
    NSString *numbersBuffer;

    // Extract front strings from stringSet using commaSet
    [scannerForInput scanUpToCharactersFromSet:commaSet intoString:&frontBuffer];

    // Scan front numbers from extracted front strings
    NSScanner *scannerForFrontNumbers = [NSScanner scannerWithString:frontBuffer];
    while ([scannerForFrontNumbers isAtEnd] == NO) {
        if ([scannerForFrontNumbers scanCharactersFromSet:numbers intoString:&numbersBuffer]) {
            [strippedString appendString:numbersBuffer];
        }else{
            [scannerForFrontNumbers setScanLocation:([scannerForFrontNumbers scanLocation] + 1)];
        }
    }
    [stringArray addObject:strippedString];
    strippedString = [[NSMutableString alloc]init];
    
    // Rear numbers from the rest of 'scannerForInput'
	while ([scannerForInput isAtEnd] == NO) {
        if ([scannerForInput scanCharactersFromSet:numbers intoString:&numbersBuffer]) {
            [strippedString appendString:numbersBuffer];
        }else{
            [scannerForInput setScanLocation:([scannerForInput scanLocation] + 1)];
        }
    }
    [stringArray addObject:strippedString];
    
    //NSLog(@"%@", stringArray); // "(123, 321)"
	return stringArray;
}

-(BOOL)ladderPointInsertPossibility: (int)y : (int)x
{
    NSNumber * tempNsnY = [NSNumber numberWithInt:y];
    __unused NSNumber * tempNsnX = [NSNumber numberWithInt:x];
    if ([ladderPointsDic objectForKey: tempNsnY]) {
        if ([[ladderPointsDic objectForKey:tempNsnY] count] >=3) {
            return NO;
        }else{
            NSArray *tempLadderPointsArray = [ladderPointsDic objectForKey: tempNsnY];
            NSNumber * objectNumber;
            for (objectNumber in tempLadderPointsArray) {
                if ([objectNumber intValue] == x -1 || [objectNumber intValue] == x +1) {
                    return NO;
                }
            }
            return YES;
        }
    }else{
        return YES;
    }
    return NO;
}

-(BOOL)ladderPointInsert: (int)y : (int)x
{
    NSNumber * tempNsnY = [NSNumber numberWithInt:y];
    NSNumber * tempNsnX = [NSNumber numberWithInt:x];
    NSMutableArray * tempArray = [[NSMutableArray alloc]init];
    
    if ([ladderPointsDic objectForKey:tempNsnY]) {
        tempArray = [ladderPointsDic objectForKey:tempNsnY];
        [tempArray addObject:tempNsnX];
        [ladderPointsDic setObject:tempArray forKey:tempNsnY];
        return YES;
    }else{
        [tempArray addObject:tempNsnX];
        [ladderPointsDic setObject:tempArray forKey:tempNsnY];
        return YES;
    }
    return NO;
    
}

- (int)searchingForResult: (int)player
{
    int intY = 1;
    int intX = player;

    NSNumber * nsnY;
    NSNumber * nsnX;
    NSNumber * nsnPrevX;
    
    while (intY <=10) {
        nsnY = [NSNumber numberWithInt:intY];
        nsnX = [NSNumber numberWithInt:intX];
        nsnPrevX = [NSNumber numberWithInt:intX-1];
        NSArray * ladderPointsX = [ladderPointsDic objectForKey:nsnY];
        if ([ladderPointsX containsObject: nsnX]) {
            intX++;
        }else if ( [ladderPointsX containsObject: nsnPrevX] ) {
            intX--;
        }
        intY ++;
    }
    return intX;
}

@end
