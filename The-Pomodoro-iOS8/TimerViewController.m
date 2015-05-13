//
//  TimerViewController.m
//  The-Pomodoro-iOS8
//
//  Created by Sarah on 5/11/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "TimerViewController.h"
#import "Timer.h"
#import "RoundsController.h"

@interface TimerViewController ()

@end

@implementation TimerViewController

- (void)updateTimerLabel  {
    Timer *timer = [Timer sharedInstance];
    self.timerLabel.text = [NSString stringWithFormat:@"%.2d:%.2d", (int)timer.minutes, (int)timer.seconds];
    //self.timerLabel.font = [[UIFont alloc] fontWithName:@"Chalkduster"];    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSNotificationCenter *vc = [NSNotificationCenter defaultCenter];
                                [vc addObserver:self selector:@selector(updateTimerLabel) name:(NSString *)secondTickNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    self.timerLabel.font = [UIFont fontWithName:@"Chalkduster" size:48.0];
    
    RoundsController *rc = [RoundsController sharedInstance];
    
    if (rc) {
        self.timerLabel.text = [NSString stringWithFormat:@"%.2d:%.2d", [rc.roundTimes[rc.currentRound] integerValue], 0];
    } else {
        self.timerLabel.text = @"00:00";
    }
    self.timerLabel.textColor = [UIColor blackColor];

    self.timerButton.titleLabel.font = [UIFont fontWithName:@"Chalkduster" size:32.0];
    self.timerButton.titleLabel.textColor = [UIColor blackColor];
    [self.timerButton setTitle:@"Start Timer" forState:UIControlStateNormal];
    [self.timerButton setTitle:@"Start Timer" forState:UIControlStateHighlighted];
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
}

- (instancetype)init {
    self = [super init];
    NSLog(@"init got called");
    if (self) {
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self selector:@selector(newRound)
                   name:(NSString *)newRoundNotification
                 object:nil];
        
        NSLog(@"inside self");
    }
    return self;
}

- (void)newRound  {
   Timer *newTimer = [Timer sharedInstance];
    RoundsController *rc = [RoundsController sharedInstance];
    NSArray *roundTimesArr = [rc roundTimes];
    newTimer.minutes = [roundTimesArr[rc.currentRound] integerValue];
    newTimer.seconds = 0;
    [newTimer startTimer];
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
