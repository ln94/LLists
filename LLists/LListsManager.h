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

- (void)createDefaultLists:(void (^)(BOOL success))completion;

- (void)saveListWithTitle:(NSString *)title onPosition:(NSInteger)position;
- (void)deleteList:(List *)list completion:(void (^)(BOOL success))completion;

- (void)saveItemWithText:(NSString *)text onPosition:(NSInteger)position inList:(List *)list;

- (NSString *)updateText:(NSString *)text;

@end
