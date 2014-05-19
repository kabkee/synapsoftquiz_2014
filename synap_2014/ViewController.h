//
//  ViewController.h
//  synap_2014
//
//  Created by Kabkee Moon on 2014. 5. 12..
//  Copyright (c) 2014년 Kabkee Moon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *textFieldPlayers;
@property (strong, nonatomic) IBOutlet UITextView *textViewScreen;
@property (strong, nonatomic) IBOutlet UITextView *textViewLadderPoint;
@property (strong, nonatomic) IBOutlet UITextField *textFieldInput;
@property (strong, nonatomic) IBOutlet UIButton *btnInfo;
@property (strong, nonatomic) IBOutlet UIButton *btnNewGame;
@property (strong, nonatomic) IBOutlet UIButton *btnAutoDemoGame;
- (IBAction)actNewGame:(id)sender;
- (IBAction)actDemoGame:(id)sender;



@end
