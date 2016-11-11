//
//  LListsManager.m
//  LLists
//
//  Created by Lana Shatonova on 4/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LListsManager.h"

@implementation LListsManager

- (void)createDefaultLists:(void (^)(BOOL success))completion {
    
    [DataStore clearAllData:^(BOOL success) {
        if (success) {
            for (int i = 0; i < 4; i++) {
                List *list = [List create];
                list.index = [NSNumber numberWithInt:i];
                switch (i) {
                    case 0: {
                        list.title = @"Today";
//                        list.color = RGB(99, 70, 59);
                    }
                        break;
                        
                    case 1: {
                        list.title = @"Tomorrow";
//                        list.color = RGB(0.35, 0.45, 0.88);
                    }
                        break;
                        
                    case 2: {
                        list.title = @"This Weekend";
//                        list.color = RGB(0.94, 0.44, 0.8);
                    }
                        break;
                        
                    case 3: {
                        list.title = @"Next Week";
//                        list.color = RGB(0.99, 0.7, 0.9);
                    }
                        break;
                        
                    default:
                        break;
                }
                list.color = C_RANDOM;
            }
            [DataStore save];
        }
        
        if (completion) completion(success);
    }];
}

#pragma mark - List

- (void)saveListWithTitle:(NSString *)title onPosition:(NSInteger)position {
    [self changeListIndexesFrom:position by:1];
    
    List *list = [List create];
    list.title = title;
    list.index = [NSNumber numberWithInteger:position];
    list.color = C_RANDOM;
}

- (void)deleteList:(List *)list completion:(void (^)(BOOL))completion {
    [self changeListIndexesFrom:[list.index integerValue]+1 by:-1];
    
    [list destroy];
}

- (void)changeListIndexesFrom:(NSInteger)index by:(NSInteger)value {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntity:[List class]];
    request.predicate = [NSPredicate predicateWithFormat:@"index >= %@", [NSNumber numberWithInteger:index]];
    request.sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"index" ascending:YES];
    
    NSFetchRequestController *frc = [NSFetchRequestController controllerWithFetchRequest:request];
    [frc performFetch];
    
    for (List *object in frc.fetchedObjects) {
        object.index = [NSNumber numberWithInteger:(object.indexValue + value)];
    }
}

@end
