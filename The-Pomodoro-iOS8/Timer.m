//
//  Timer.m
//  The-Pomodoro-iOS8
//
//  Created by Sarah on 5/11/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "Timer.h"
#import "RoundsController.h"

@interface Timer ()

@property (nonatomic, readwrite) BOOL isOn;
@property (nonatomic, readwrite) NSDate *expirationDate;

@end


@implementation Timer

+ (instancetype)sharedInstance
{
    static Timer *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[Timer alloc] init];
        //sharedInstance.minutes = 0;
        //sharedInstance.seconds = 3;
        
        RoundsController *rc = [RoundsController new];
        sharedInstance.minutes = [rc.roundTimes[0] integerValue];
        sharedInstance.seconds = 0;
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
    int secondsInTheFuture = (int)((self.seconds*60) + self.minutes);
    self.expirationDate = [NSDate dateWithTimeIntervalSinceNow:secondsInTheFuture]; // time when timer when will expire
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = self.expirationDate;
    notification.timeZone = [NSTimeZone timeZoneWithName:@"MST"];
    notification.soundName = UILocalNotificationDefaultSoundName;
    notification.alertBody = @"Time's Up!";
    
/*    UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                    UIUserNotificationTypeBadge |
 UIUserNotificationTypeSound);

    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes                                                                             categories:nil];
    
 [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
*/
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    
    self.isOn = YES;
    [self checkActive];
}

- (void)endTimer  {
    self.isOn = NO;
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:(NSString *)timerCompletedNotification object:self userInfo:nil];
}

- (void)decreaseSecond  {
    if (self.isOn) {
        self.seconds--;
        if (self.seconds < 0) {
            self.minutes--;
            if (self.minutes < 0) {
                self.minutes = 0;
                self.seconds = 0;
                
                [self endTimer];
            } else {
                self.seconds = 59;
            }
        }
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc postNotificationName:(NSString *)secondTickNotification object:self userInfo:nil];
    }
}

- (void)cancelTimer  {
    self.isOn = NO;
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber: 0];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

- (void)prepareForBackground
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:[NSNumber numberWithInt:(int)self.minutes] forKey:@"minutesKey"];
    [defaults setObject:[NSNumber numberWithInt:(int)self.seconds] forKey:@"secondsKey"];
    
    [defaults synchronize];
}

- (void)loadFromBackground
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    self.minutes = [[defaults objectForKey:@"minutesKey"] integerValue];
    self.seconds = [[defaults objectForKey:@"secondsKey"] integerValue];
}


@end
