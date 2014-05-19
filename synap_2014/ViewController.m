//
//  ViewController.m
//  synap_2014
//
//  Created by Kabkee Moon on 2014. 5. 12..
//  Copyright (c) 2014년 Kabkee Moon. All rights reserved.
//

#import "ViewController.h"
#import "gameController.h"
#import "AppDelegate.h"

#define myAppDelegate (AppDelegate *) [[UIApplication sharedApplication]delegate]

@interface ViewController ()
@property gameController * gameCtr;
@property BOOL demoActivated;
@end

static NSString * pStartGreeting = @"startGreeting";
static NSString * pLadderInputAsk = @"ladderInputAsk";
static NSString * pSnakeInputAsk = @"snakeInputAsk";
static NSString * pReGameAsk = @"reGameAsk";
static NSString * pEndGreeting = @"endGreeting";
static NSString * pRetypeReminder = @"retypeReminder";

@implementation ViewController

@synthesize textFieldInput, textFieldPlayers;
@synthesize textViewScreen, textViewLadderPoint;
@synthesize btnInfo, btnNewGame;
@synthesize gameCtr;
@synthesize demoActivated;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.textFieldInput.delegate = self;
    [self gameInit];
    demoActivated = FALSE;
}

- (void)gameInit
{
    // Show player number on the screen
    textFieldPlayers.text = [NSString stringWithFormat:@"%@",[myAppDelegate players]];
    
    // Game controller setup
    gameCtr = [[gameController alloc]init];
    
    // Showing Initiaing messages
    [self logGameStatus:pStartGreeting];
    [self logGameStatus:pLadderInputAsk];
    textViewLadderPoint.text = @"(y,x)";
    
    // Reset demoActivated as FALSE
    demoActivated = FALSE;
}

- (void)logGameStatus : (NSString *)status
{
    if ([status isEqualToString: pStartGreeting]) {
        textViewScreen.text = @"";
        textViewScreen.text = [gameCtr startGreeting];
    }else if ([status isEqualToString:pLadderInputAsk]){
        textViewScreen.text = [textViewScreen.text stringByAppendingString: [gameCtr ladderInputAsk]];
    }else if ([status isEqualToString:pSnakeInputAsk]){
        textViewScreen.text = [textViewScreen.text stringByAppendingString: [gameCtr snakeInputAsk]];
    }else if ([status isEqualToString:pReGameAsk]){
        textViewScreen.text = [textViewScreen.text stringByAppendingString: [gameCtr reGameAsk]];
    }else if ([status isEqualToString:pEndGreeting]){
        textViewScreen.text = [textViewScreen.text stringByAppendingString: [gameCtr endGreeting]];
    }else if ([status isEqualToString:pRetypeReminder]){
        textViewScreen.text = [textViewScreen.text stringByAppendingString: [gameCtr retypeReminder]];
    }
    NSRange bottom = NSMakeRange(textViewScreen.text.length -1, 1);
    [textViewScreen scrollRangeToVisible:bottom];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    __unused NSArray *gameStage = @[@"1.사다리 정보 입력", @"2.출발지점입력", @"3.다시하시겠습니까?", @"4.게임종료"];
    // 1: (y,x), 2: player number, 3: Restart?, 4: End
    
    // Detecting 'x'
    if ( [textField.text isEqualToString:@"x"] || [textField.text isEqualToString:@"X"]) {
        [self textViewToBottomAndAppendInput:textViewScreen :textField.text :TRUE];
        // Detecting 'x' to end putting (y,x) for letter bar
        if ([gameCtr gameStage] == 1) {
            [self logGameStatus:pSnakeInputAsk];
            gameCtr.gameStage ++; // gameStage = 2
            textField.text = @"";
            return YES;
        }
        // Detecting 'x' to end putting player number
        else if([gameCtr gameStage] == 2){
            [self logGameStatus:pReGameAsk];
            gameCtr.gameStage ++; // gameStage = 3
            textField.text = @"";
            return YES;
        }
    }
    
    // Validating (y,x), extracting numbers of (y,x), and appending to the right arrayView of (y,x)
    if ([gameCtr gameStage] == 1) {
        NSArray *tempNumbersArray = [gameCtr numberToStringArray:textField.text];
        NSString *tempIndex0 = tempNumbersArray[0];
        NSString *tempIndex1 = tempNumbersArray[1];
        int tempIndex0Int = [tempIndex0 intValue];
        int tempIndex1Int = [tempIndex1 intValue];
        NSString * tempStringForYX = [NSString stringWithFormat:@"(%@,%@)", tempIndex0, tempIndex1];

        [self textViewToBottomAndAppendInput:textViewScreen :tempStringForYX :TRUE];
        // Check if x and y is valid numbers
        if( tempIndex0Int > 10 || tempIndex0Int < 1 || tempIndex1Int > [textFieldPlayers.text intValue] || tempIndex1Int < 1 ){
            [self logGameStatus:pRetypeReminder];
            textField.text = @"";
            return YES;
        }else{
            // Recheck if there're neightborhoods beside of x
            __unused NSNumber * tempNsnX = [NSNumber numberWithInt:tempIndex1Int];
            __unused NSNumber * tempNsnY = [NSNumber numberWithInt:tempIndex0Int];
            if ([gameCtr ladderPointInsertPossibility:tempIndex0Int :tempIndex1Int]) {
                [self textViewToBottomAndAppendInput:textViewLadderPoint :tempStringForYX :FALSE];
                [gameCtr ladderPointInsert:tempIndex0Int :tempIndex1Int];
            }else{
                [self logGameStatus:pRetypeReminder];
            }
            textField.text = @"";
            return YES;
        }
    }else if([gameCtr gameStage] == 2){
        [self textViewToBottomAndAppendInput:textViewScreen :textField.text :TRUE];
        if ([textField.text intValue] <1 || [textField.text intValue] > [textFieldPlayers.text intValue]) {
            [self logGameStatus:pRetypeReminder];
            textField.text = @"";
        }else{
            int gameResult = [gameCtr searchingForResult:[textField.text intValue]];
            [self textViewToBottomAndAppendInput:textViewScreen :[NSString stringWithFormat:@"%d", gameResult] :FALSE];
            textField.text = @"";
        }
    }else if([gameCtr gameStage] == 3){
        [self textViewToBottomAndAppendInput:textViewScreen :textField.text :TRUE];
        if ([textField.text isEqualToString:@"y"] || [textField.text isEqualToString:@"Y"]) {
            gameCtr = [[gameController alloc]init];
            [self gameInit];
        }else if ([textField.text isEqualToString:@"n"] || [textField.text isEqualToString:@"N"]){
            [self logGameStatus:pEndGreeting];
            textFieldInput.enabled = NO;
        }
        textField.text = @"";
    }
    return YES;
}

- (void)textViewToBottomAndAppendInput: (UITextView *)textView :(NSString *)input :(BOOL)fromUser{
    if (textView == textViewScreen && fromUser) {
        textView.text = [textView.text stringByAppendingString:@"> "];
    }
    textView.text = [textView.text stringByAppendingString:input];
    textView.text = [textView.text stringByAppendingString:@"\r"];
    
    NSRange bottom = NSMakeRange(textView.text.length -1, 1);
    [textView scrollRangeToVisible:bottom];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (IBAction)actNewGame:(id)sender {
    [self gameInit];
    textFieldInput.enabled = TRUE;
}

- (IBAction)actDemoGame:(id)sender {
    if (!demoActivated) {
        NSMutableDictionary * ladderPointsDic = [gameCtr ladderPointsDic];
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
        
        [self textViewToBottomAndAppendInput:textViewScreen :@"사다리 설치가 자동으로 됩니다." :FALSE];
        [self textViewToBottomAndAppendInput:textViewScreen :@"채용퀴즈의 예제와 동일하게 설정됩니다." :FALSE];
        
        NSArray * ladderPointsString = @[@"(1,1)",@"(2,4)",@"(3,2)",@"(3,5)",@"(4,3)",@"(5,2)",@"(5,5)",@"(6,1)",@"(6,4)",@"(7,3)",
                                         @"(7,5)",@"(8,2)",@"(8,4)",@"(9,1)",@"(10,3)"];
        for (int i = 0; i < [ladderPointsString count]; i++) {
            [self textViewToBottomAndAppendInput:textViewLadderPoint :ladderPointsString[i] :FALSE];
        }
        gameCtr.gameStage ++; // stage2
        
        [self textViewToBottomAndAppendInput:textViewScreen :@"사다리를 타주세요." :FALSE];
        demoActivated = TRUE;
    }
}
@end


