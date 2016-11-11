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
@class Position;

@interface ItemID : NSManagedObjectID {}
@end

@interface _Item : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) ItemID *objectID;

@property (nonatomic, strong, nullable) NSNumber* currentIndex;

@property (atomic) uint16_t currentIndexValue;
- (uint16_t)currentIndexValue;
- (void)setCurrentIndexValue:(uint16_t)value_;

@property (nonatomic, strong, nullable) NSString* text;

@property (nonatomic, strong, nullable) NSSet<List*> *lists;
- (nullable NSMutableSet<List*>*)listsSet;

@property (nonatomic, strong, nullable) NSSet<Position*> *positions;
- (nullable NSMutableSet<Position*>*)positionsSet;

@end

@interface _Item (ListsCoreDataGeneratedAccessors)
- (void)addLists:(NSSet<List*>*)value_;
- (void)removeLists:(NSSet<List*>*)value_;
- (void)addListsObject:(List*)value_;
- (void)removeListsObject:(List*)value_;

@end

@interface _Item (PositionsCoreDataGeneratedAccessors)
- (void)addPositions:(NSSet<Position*>*)value_;
- (void)removePositions:(NSSet<Position*>*)value_;
- (void)addPositionsObject:(Position*)value_;
- (void)removePositionsObject:(Position*)value_;

@end

@interface _Item (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveCurrentIndex;
- (void)setPrimitiveCurrentIndex:(NSNumber*)value;

- (uint16_t)primitiveCurrentIndexValue;
- (void)setPrimitiveCurrentIndexValue:(uint16_t)value_;

- (NSString*)primitiveText;
- (void)setPrimitiveText:(NSString*)value;

- (NSMutableSet<List*>*)primitiveLists;
- (void)setPrimitiveLists:(NSMutableSet<List*>*)value;

- (NSMutableSet<Position*>*)primitivePositions;
- (void)setPrimitivePositions:(NSMutableSet<Position*>*)value;

@end

@interface ItemAttributes: NSObject 
+ (NSString *)currentIndex;
+ (NSString *)text;
@end

@interface ItemRelationships: NSObject
+ (NSString *)lists;
+ (NSString *)positions;
@end

NS_ASSUME_NONNULL_END
