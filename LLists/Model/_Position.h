// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Position.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class Item;
@class List;

@interface PositionID : NSManagedObjectID {}
@end

@interface _Position : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) PositionID *objectID;

@property (nonatomic, strong, nullable) NSNumber* index;

@property (atomic) int16_t indexValue;
- (int16_t)indexValue;
- (void)setIndexValue:(int16_t)value_;

@property (nonatomic, strong, nullable) Item *item;

@property (nonatomic, strong, nullable) List *list;

@end

@interface _Position (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveIndex;
- (void)setPrimitiveIndex:(NSNumber*)value;

- (int16_t)primitiveIndexValue;
- (void)setPrimitiveIndexValue:(int16_t)value_;

- (Item*)primitiveItem;
- (void)setPrimitiveItem:(Item*)value;

- (List*)primitiveList;
- (void)setPrimitiveList:(List*)value;

@end

@interface PositionAttributes: NSObject 
+ (NSString *)index;
@end

@interface PositionRelationships: NSObject
+ (NSString *)item;
+ (NSString *)list;
@end

NS_ASSUME_NONNULL_END
