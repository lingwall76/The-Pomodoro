//
//  RoundsController.m
//  The-Pomodoro-iOS8
//
//  Created by Sarah on 5/11/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "RoundsController.h"
#import "Timer.h"

@implementation RoundsController


- (NSArray *)roundTimes  {
    //return @[@25, @5, @25, @5, @25, @5, @25, @15];
    return @[@1, @2, @3, @4, @5, @6, @7, @8];
}

- (NSArray *)imageNames {
    return @[@"Work", @"Play", @"Work", @"Play", @"Work", @"Play", @"Work", @"Sleep"];
}

+ (instancetype)sharedInstance
{
    static RoundsController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[RoundsController alloc] init];
        sharedInstance.currentRound = 0;
    });
    
    return sharedInstance;
}

- (void)roundSelected  {
    Timer *currentTimer = [Timer sharedInstance];
    NSArray *newArray = [self roundTimes];
    //currentTimer.minutes = [newArray[self.currentRound] integerValue];
    //currentTimer.seconds = 0;
    currentTimer.minutes = 0;
    currentTimer.seconds = [newArray[self.currentRound] integerValue];
    NSNotificationCenter *vc = [NSNotificationCenter defaultCenter];
    [vc addObserver:self selector:@selector(updateTimerLabel) name:(NSString *)newRoundNotification object:nil];
}

-(void)updateTimerLabel
{
    Timer *currentTimer = [Timer sharedInstance];
    RoundsController *rc = [RoundsController sharedInstance];
    //currentTimer.minutes = [rc.roundTimes[rc.currentRound] integerValue];
    //currentTimer.seconds = 0;
    currentTimer.minutes = 0;
    currentTimer.seconds = [rc.roundTimes[rc.currentRound] integerValue];
}


@end
