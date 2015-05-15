//
//  Timer.h
//  The-Pomodoro-iOS8
//
//  Created by Sarah on 5/11/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static const NSString * newRoundNotification = @"NewRoundNotification";
static const NSString * secondTickNotification = @"SecondTickNotification";
static const NSString * timerCompletedNotification = @"TimerCompletedNotification";



@interface Timer : NSObject

@property (nonatomic) NSInteger minutes;
@property (nonatomic) NSInteger seconds;

@property (nonatomic, readonly) BOOL isOn;

+ (instancetype)sharedInstance;
- (void)startTimer;
- (void)cancelTimer;
- (void)enableButton;
- (void)prepareForBackground;
- (void)loadFromBackground;

@end
