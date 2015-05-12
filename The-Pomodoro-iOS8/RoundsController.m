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
    return @[@25, @5, @25, @5, @25, @5, @25, @15];
    
}

+ (instancetype)sharedInstance
{
    static RoundsController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[RoundsController alloc] init];
    });
    
    return sharedInstance;
    
}

- (void)roundSelected  {
    Timer *currentTimer = [Timer sharedInstance];
    NSArray *newArray = [self roundTimes];
    currentTimer.minutes = newArray[self.currentRound];
    currentTimer.seconds = 0;
    NSNotificationCenter *vc = [NSNotificationCenter defaultCenter];
    [vc addObserver:self selector:@selector(updateTimerLabel) name:newRoundNotification object:nil];
    

}




@end
