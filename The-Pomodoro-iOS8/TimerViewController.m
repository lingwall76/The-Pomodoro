//
//  TimerViewController.m
//  The-Pomodoro-iOS8
//
//  Created by Sarah on 5/11/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "TimerViewController.h"
#import "Timer.h"

@interface TimerViewController ()

@end

@implementation TimerViewController

- (void)updateTimerLabel  {
    Timer *timer = [Timer sharedInstance];
    self.timerLabel.text = [NSString stringWithFormat:@"%d:%d", timer.minutes, timer.seconds];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSNotificationCenter *vc = [NSNotificationCenter defaultCenter];
                                [vc addObserver:self selector:@selector(updateTimerLabel) name:secondTickNotification object:nil];

}

- (void)dealloc {
    NSNotificationCenter *vc = [NSNotificationCenter defaultCenter];
    [vc removeObserver:self];
}

- (IBAction)timerTapped:(id)sender {
    Timer *timer = [Timer sharedInstance];
    
    if (!timer.isOn) {
    [timer startTimer];
}
    
    - (instancetype)init;  {
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self selector:@selector(newRound)
                   name:newRoundNotification
                 object:nil];
        
        
    }
    - (void)newRound  {
        
        Timer *newTimer = [Timer sharedInstance];
        newTimer.isOn = YES;
        
        
    }

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
