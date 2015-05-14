//
//  AppearanceController.m
//  The-Pomodoro-iOS8
//
//  Created by Douglas Voss on 5/13/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "AppearanceController.h"

@implementation AppearanceController

+ (void)initializeAppearanceDefaults
{
    // Update navigationBar color
    // Update navigationBar title font and text color
    // Update the tint color on the tab bar
    [[UINavigationBar appearance] setBarTintColor:[UIColor orangeColor]];
    [UINavigationBar appearance].titleTextAttributes = @{NSFontAttributeName:[UIFont fontWithName:@"Chalkduster" size:20.0]};
}

@end
