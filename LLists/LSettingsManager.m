//
//  LSettingsManager.m
//  LLists
//
//  Created by Lana Shatonova on 4/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LSettingsManager.h"

#define Defaults [NSUserDefaults standardUserDefaults]

// Keys
static NSString *const L_FIRST_TIME_USE_KEY = @"L_FIRST_TIME_USE";

@implementation LSettingsManager

- (void)setup {
    
    NSDictionary *defaultPreferences = @{
                                         L_FIRST_TIME_USE_KEY: @(YES)
                                         };
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultPreferences];
}

- (void)save {
    [Defaults synchronize];
}

#pragma mark - First Time Use

- (void)setFirstTimeUse:(BOOL)firstTimeUse {
    [Defaults setBool:firstTimeUse forKey:L_FIRST_TIME_USE_KEY];
    [self save];
}

- (BOOL)firstTimeUse {
    return [Defaults boolForKey:L_FIRST_TIME_USE_KEY];
}

@end
