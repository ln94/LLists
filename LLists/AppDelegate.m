//
//  AppDelegate.m
//  LLists
//
//  Created by Lana Shatonova on 7/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "AppDelegate.h"
#import "LAllListsViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //DEBUG:
//    SettingsManager.firstTimeUse = YES;
    
    if (SettingsManager.firstTimeUse) {
        [self firstTimeLaunch];
    }
    else {
        [self launchWithRootViewController:[[UINavigationController alloc] initWithRootViewController:[[LAllListsViewController alloc] init]]];
    }
    
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [DataStore save];
}

- (void)firstTimeLaunch {
    
    [ListsManager createDefaultLists:^(BOOL success) {
        SettingsManager.firstTimeUse = NO;
        if (success) {
            [self launchWithRootViewController:[[UINavigationController alloc] initWithRootViewController:[[LAllListsViewController alloc] init]]];
        }
        else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"-_-" message:@"\nFailed to create default lists...\nYou still can create your own!" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
            [LLists.topViewController presentViewController:alert animated:YES completion:nil];
        }
    }];
}

- (void)launchWithRootViewController:(UIViewController *)viewController {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = C_WHITE;
    self.window.rootViewController =viewController;
    [self.window makeKeyAndVisible];
}

- (UIViewController *)topViewController {
    
    UIViewController *topVC = self.window.rootViewController;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    
    return topVC;
}

@end
