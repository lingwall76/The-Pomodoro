//
//  TimerViewController.h
//  The-Pomodoro-iOS8
//
//  Created by Sarah on 5/11/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import <UIKit/UIKit.h>





@interface TimerViewController : UIViewController


@property (weak, nonatomic) IBOutlet UILabel *timerLabel;

@property (weak, nonatomic) IBOutlet UIButton *timerButton;



- (IBAction)timerTapped:(id)sender;

- (void)updateTimerLabel;




@end
