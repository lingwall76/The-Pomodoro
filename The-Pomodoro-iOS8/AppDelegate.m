//
//  AppDelegate.m
//  The-Pomodoro-iOS8
//
//  Created by Taylor Mott on 18.2.2015.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "AppDelegate.h"
#import "TimerViewController.h"
#import "RoundsViewController.h"
#import "CustomTabBarController.h"
#import "AppearanceController.h"
#import <UIKit/UIKit.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    //CustomTabBarController *tabBarController = [[CustomTabBarController alloc] init];
    
    TimerViewController *timerVC = [[TimerViewController alloc] init];
    //timerVC.tabBarItem.title = @"Timer";
    timerVC.view.backgroundColor = [UIColor yellowColor];
    timerVC.tabBarItem.image = [UIImage imageNamed:@"Clock"];
    timerVC.tabBarItem.title = @"Timer";
    

    RoundsViewController *roundsVC = [[RoundsViewController alloc] init];
    //roundsVC.tabBarItem.title = @"Rounds";
    roundsVC.view.backgroundColor = [UIColor greenColor];
    roundsVC.tabBarItem.image = [UIImage imageNamed:@"Tomato"];
    roundsVC.tabBarItem.title = @"Rounds";
    roundsVC.title = @"Rounds";
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:roundsVC];
    nc.title = @"Rounds";
    [AppearanceController initializeAppearanceDefaults];
    
    //tabBarController.viewControllers = @[timerVC, roundsVC];
    tabBarController.viewControllers = @[timerVC, nc];
    self.window.rootViewController = tabBarController;
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                    UIUserNotificationTypeBadge |
                                                        UIUserNotificationTypeSound);
    
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes                                                                             categories:nil];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Timer Expired" message:@"nextRound?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *option1 = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [alertController dismissViewControllerAnimated:YES completion:^{}];
    }];
    [alertController addAction:option1];
    
    id rootViewController=[UIApplication sharedApplication].delegate.window.rootViewController;
    if([rootViewController isKindOfClass:[UITabBarController class]])
    {
        rootViewController=[((UITabBarController *)rootViewController).viewControllers objectAtIndex:0];
    }
    [rootViewController presentViewController:alertController animated:YES completion:nil];
}

@end
