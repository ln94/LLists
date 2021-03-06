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

- (void)saveListWithTitle:(NSString *)title color:(UIColor *)color onPosition:(NSInteger)position {
    if (!title.isEmpty) {
        [self changeListIndexesFrom:position by:1];
        
        List *list = [List create];
        list.title = title;
        list.index = [NSNumber numberWithInteger:position];
        list.color = color;
        
        [DataStore save];
    }
}

- (void)deleteList:(List *)list {
    [self changeListIndexesFrom:[list.index integerValue]+1 by:-1];
    
    [list destroy];
    [DataStore save];
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


#pragma mark - Item

- (void)saveItemWithText:(NSString *)text onPosition:(NSInteger)position inList:(List *)list {
    if (!text.isEmpty) {
        [self changeItemIndexesFrom:position by:1 inList:list];
        
        Position *pos = [Position create];
        pos.index = [NSNumber numberWithInteger:position];
        pos.list = list;
        
        Item *item = [Item create];
        item.text = text;
        [item addPositionsObject:pos];
        [item addListsObject:list];
        
        [DataStore save];
    }
}

- (void)deleteItem:(Item *)item inList:(List *)list completion:(void (^)(BOOL finished))completion {
    [self changeItemIndexesFrom:[item.currentIndex integerValue]+1 by:-1 inList:list];
    
    [item destroy];
    [DataStore save];
}

- (void)changeItemIndexesFrom:(NSInteger)index by:(NSInteger)value inList:(List *)list {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntity:[Position class]];
    NSPredicate *predicate1 = [NSPredicate predicateWithKey:@"list" value:list];
    NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"index >= %@", [NSNumber numberWithInteger:index]];
    request.predicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[predicate1, predicate2]];
    request.sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"index" ascending:YES];
    
    NSFetchRequestController *frc = [NSFetchRequestController controllerWithFetchRequest:request];
    [frc performFetch];
    
    for (Position *object in frc.fetchedObjects) {
        object.index = [NSNumber numberWithInteger:(object.indexValue + value)];
    }
}

#pragma mark - Utils

- (NSString *)updateText:(NSString *)text {
    if (text.isEmpty) {
        return text;
    }
    
    // Beginning
    NSRange range = NSMakeRange(0, 1);
    while ([text characterAtIndex:0] == ' ' || [text characterAtIndex:0] == '\n') {
        text = [text stringByReplacingCharactersInRange:range withString:@""];
        if (text.isEmpty) {
            return text;
        }
    }
    
    // End
    while ([text characterAtIndex:text.length-1] == ' ' || [text characterAtIndex:text.length-1] == '\n') {
        range = NSMakeRange(text.length - 1, 1);
        text = [text stringByReplacingCharactersInRange:range withString:@""];
        if (text.isEmpty) {
            return text;
        }
    }
    
    return text;
}

@end










