// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to List.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class Item;

@class NSObject;

@interface ListID : NSManagedObjectID {}
@end

@interface _List : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) ListID *objectID;

@property (nonatomic, strong, nullable) id color;

@property (nonatomic, strong, nullable) NSNumber* editing;

@property (atomic) BOOL editingValue;
- (BOOL)editingValue;
- (void)setEditingValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSNumber* index;

@property (atomic) uint16_t indexValue;
- (uint16_t)indexValue;
- (void)setIndexValue:(uint16_t)value_;

@property (nonatomic, strong, nullable) NSString* title;

@property (nonatomic, strong, nullable) NSSet<Item*> *items;
- (nullable NSMutableSet<Item*>*)itemsSet;

@end

@interface _List (ItemsCoreDataGeneratedAccessors)
- (void)addItems:(NSSet<Item*>*)value_;
- (void)removeItems:(NSSet<Item*>*)value_;
- (void)addItemsObject:(Item*)value_;
- (void)removeItemsObject:(Item*)value_;

@end

@interface _List (CoreDataGeneratedPrimitiveAccessors)

- (id)primitiveColor;
- (void)setPrimitiveColor:(id)value;

- (NSNumber*)primitiveEditing;
- (void)setPrimitiveEditing:(NSNumber*)value;

- (BOOL)primitiveEditingValue;
- (void)setPrimitiveEditingValue:(BOOL)value_;

- (NSNumber*)primitiveIndex;
- (void)setPrimitiveIndex:(NSNumber*)value;

- (uint16_t)primitiveIndexValue;
- (void)setPrimitiveIndexValue:(uint16_t)value_;

- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;

- (NSMutableSet<Item*>*)primitiveItems;
- (void)setPrimitiveItems:(NSMutableSet<Item*>*)value;

@end

@interface ListAttributes: NSObject 
+ (NSString *)color;
+ (NSString *)editing;
+ (NSString *)index;
+ (NSString *)title;
@end

@interface ListRelationships: NSObject
+ (NSString *)items;
@end

NS_ASSUME_NONNULL_END
