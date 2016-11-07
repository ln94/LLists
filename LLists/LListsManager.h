//
//  LListsManager.h
//  LLists
//
//  Created by Lana Shatonova on 4/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ListsManager [LListsManager singleton]

@interface LListsManager : NSObject <Singleton>

- (void)createDefaultLists;

@end
