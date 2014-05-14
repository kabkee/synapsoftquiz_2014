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
@property (strong, nonatomic) IBOutlet UIButton *buttonGetResult;
@property (strong, nonatomic) IBOutlet UITextField *textFieldResult;


@end
