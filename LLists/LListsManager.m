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

- (void)setListsColors {
    
}

@end
