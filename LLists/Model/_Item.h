// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Item.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class List;

@interface ItemID : NSManagedObjectID {}
@end

@interface _Item : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) ItemID *objectID;

@property (nonatomic, strong, nullable) NSNumber* index;

@property (atomic) int16_t indexValue;
- (int16_t)indexValue;
- (void)setIndexValue:(int16_t)value_;

@property (nonatomic, strong, nullable) NSString* text;

@property (nonatomic, strong, nullable) NSSet<List*> *lists;
- (nullable NSMutableSet<List*>*)listsSet;

@end

@interface _Item (ListsCoreDataGeneratedAccessors)
- (void)addLists:(NSSet<List*>*)value_;
- (void)removeLists:(NSSet<List*>*)value_;
- (void)addListsObject:(List*)value_;
- (void)removeListsObject:(List*)value_;

@end

@interface _Item (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveIndex;
- (void)setPrimitiveIndex:(NSNumber*)value;

- (int16_t)primitiveIndexValue;
- (void)setPrimitiveIndexValue:(int16_t)value_;

- (NSString*)primitiveText;
- (void)setPrimitiveText:(NSString*)value;

- (NSMutableSet<List*>*)primitiveLists;
- (void)setPrimitiveLists:(NSMutableSet<List*>*)value;

@end

@interface ItemAttributes: NSObject 
+ (NSString *)index;
+ (NSString *)text;
@end

@interface ItemRelationships: NSObject
+ (NSString *)lists;
@end

NS_ASSUME_NONNULL_END
