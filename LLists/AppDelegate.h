//
//  AppDelegate.h
//  LLists
//
//  Created by Lana Shatonova on 7/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#define LLists ((AppDelegate *)[[UIApplication sharedApplication] delegate])

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, readonly) UIViewController *topViewController;

@end

