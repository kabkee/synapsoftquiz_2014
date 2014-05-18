//
//  gameController.h
//  synap_2014
//
//  Created by Kabkee Moon on 2014. 5. 12..
//  Copyright (c) 2014년 Kabkee Moon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface gameController : NSObject
@property NSString * startGreeting;
@property NSString * ladderInputAsk;
@property NSString * snakeInputAsk;
@property NSString * reGameAsk;
@property NSString * endGreeting;
@property NSString * retypeReminder;
@property NSMutableDictionary *ladderPointsDic;
@property int gameStage;

- (NSMutableArray *)numberToStringArray: (NSString *)stringSet;
- (BOOL)ladderPointInsertPossibility: (int)y : (int)x;
- (BOOL)ladderPointInsert: (int)y : (int)x;
@end
