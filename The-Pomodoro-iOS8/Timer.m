//
//  Timer.m
//  The-Pomodoro-iOS8
//
//  Created by Sarah on 5/11/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "Timer.h"

@interface Timer ()
@property (nonatomic, readwrite) BOOL isOn;


@end


@implementation Timer



+ (instancetype)sharedInstance

{
    static Timer *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[Timer alloc] init];
        sharedInstance.minutes = 2;
        sharedInstance.seconds = 1;
    });
    
    return sharedInstance;
    

    
}

- (void)checkActive  {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    if (self.isOn) {
        [self decreaseSecond];
        [self performSelector:@selector(checkActive) withObject:self afterDelay:1.0];
    }
}

- (void)startTimer {
    self.isOn = YES;
    [self checkActive];
    
}

- (void)endTimer  {
    self.isOn = NO;
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:(NSString *)timerCompletedNotification object:self userInfo:nil];
}

- (void)decreaseSecond  {
    self.seconds--;
    if (self.seconds < 0) {
        self.minutes--;
        if (self.minutes < 0) {
            [self endTimer];
            
            self.minutes = 0;
            self.seconds = 0;
            
            
        }else{
            self.seconds = 59;
            
        }
        
    }
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:(NSString *)secondTickNotification object:self userInfo:nil];
    
    
}

- (void)cancelTimer  {
    self.isOn = NO;
    
}

@end
