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
@end

static NSString * pStartGreeting = @"startGreeting";
static NSString * pLadderInputAsk = @"ladderInputAsk";
static NSString * pSnakeInputAsk = @"snakeInputAsk";
static NSString * pReGameAsk = @"reGameAsk";
static NSString * pEndGreeting = @"endGreeting";
static NSString * pretypeReminder = @"retypeReminder";

@implementation ViewController

@synthesize textFieldInput, textFieldPlayers, textFieldResult;
@synthesize textViewScreen, textViewLadderPoint;
@synthesize buttonGetResult;
@synthesize gameCtr;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.textFieldInput.delegate = self;

    // Show player number on the screen
    textFieldPlayers.text = [NSString stringWithFormat:@"%@",[myAppDelegate players]];
    
    // Game controller setup
    gameCtr = [[gameController alloc]init];
    
    // Showing Initiaing messages
    [self logGameStatus:pStartGreeting];
    [self logGameStatus:pLadderInputAsk];
    textViewLadderPoint.text = @"(y,x)";
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
    }else if ([status isEqualToString:pretypeReminder]){
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
        // Detecting 'x' to end putting (y,x) for letter bar
        if ([gameCtr gameStage] == 1) {
            [self logGameStatus:pSnakeInputAsk];
            gameCtr.gameStage ++; // gameStage = 2
        }
        // Detecting 'x' to end putting player number
        else if([gameCtr gameStage] == 2){
            [self logGameStatus:pReGameAsk];
            gameCtr.gameStage ++; // gameStage = 3
        }
        
    }
    
    // Validating (y,x), extracting numbers of (y,x), and appending to the right arrayView of (y,x)
    if ([gameCtr gameStage] == 1) {
        NSArray *tempNumbersArray = [gameCtr numberToStringArray:textField.text];
        NSString *tempIndex0 = tempNumbersArray[0];
        NSString *tempIndex1 = tempNumbersArray[1];
        NSString * tempStringForYX = [NSString stringWithFormat:@"(%@,%@)", tempIndex0, tempIndex1];
        
        // Check if x and y is valid numbers
        if( [tempIndex0 intValue] > 10 || [tempIndex0 intValue] < 1 || [tempIndex1 intValue] > [textFieldPlayers.text intValue] || [tempIndex1 intValue] < 1 ){
            [self textViewToBottomAndAppendInput:textViewScreen :tempStringForYX];
            [self logGameStatus:pretypeReminder];
            textField.text = @"";
            return YES;
        }else{
            // Recheck if there're neightborhoods beside of x
            [self textViewToBottomAndAppendInput:textViewScreen :tempStringForYX];
            [self textViewToBottomAndAppendInput:textViewLadderPoint :tempStringForYX];
            textField.text = @"";
        }
    }else if([gameCtr gameStage] == 3){
        if ([textField.text isEqualToString:@"y"] || [textField.text isEqualToString:@"Y"]) {
            
        }else if ([textField.text isEqualToString:@"n"] || [textField.text isEqualToString:@"N"]){
            [self logGameStatus:pEndGreeting];
            textFieldInput.enabled = NO;
        }
    }
    

        
    NSRange pointsBottom = NSMakeRange(self.textViewLadderPoint.text.length -1, 1);
    [self.textViewLadderPoint scrollRangeToVisible:pointsBottom];
    
    
    
    // Appending textField.text to the screen
    
    
    textField.text = @"";
    return YES;
}

-(void)textViewToBottomAndAppendInput: (UITextView *)textView :(NSString *)input{
    textView.text = [textView.text stringByAppendingString:input];
    textView.text = [textView.text stringByAppendingString:@"\r"];
    
    NSRange bottom = NSMakeRange(textView.text.length -1, 1);
    [textView scrollRangeToVisible:bottom];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}



@end


