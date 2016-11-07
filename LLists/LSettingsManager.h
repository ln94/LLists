//
//  LSettingsManager.h
//  LLists
//
//  Created by Lana Shatonova on 4/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SettingsManager [LSettingsManager singleton]

@interface LSettingsManager : NSObject <Singleton>

@property (nonatomic) BOOL firstTimeUse;

@end
