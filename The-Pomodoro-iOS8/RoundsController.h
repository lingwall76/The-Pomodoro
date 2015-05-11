//
//  RoundsController.h
//  The-Pomodoro-iOS8
//
//  Created by Sarah on 5/11/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoundsController : NSObject


@property (nonatomic, readonly) NSArray * roundTimes;
@property (nonatomic, readwrite) NSInteger currentRound;



+ (instancetype)sharedInstance;

@end
