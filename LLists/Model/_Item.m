// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Item.m instead.

#import "_Item.h"

@implementation ItemID
@end

@implementation _Item

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Item";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Item" inManagedObjectContext:moc_];
}

- (ItemID*)objectID {
	return (ItemID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"currentIndexValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"currentIndex"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic currentIndex;

- (uint16_t)currentIndexValue {
	NSNumber *result = [self currentIndex];
	return [result unsignedShortValue];
}

- (void)setCurrentIndexValue:(uint16_t)value_ {
	[self setCurrentIndex:@(value_)];
}

- (uint16_t)primitiveCurrentIndexValue {
	NSNumber *result = [self primitiveCurrentIndex];
	return [result unsignedShortValue];
}

- (void)setPrimitiveCurrentIndexValue:(uint16_t)value_ {
	[self setPrimitiveCurrentIndex:@(value_)];
}

@dynamic text;

@dynamic lists;

- (NSMutableSet<List*>*)listsSet {
	[self willAccessValueForKey:@"lists"];

	NSMutableSet<List*> *result = (NSMutableSet<List*>*)[self mutableSetValueForKey:@"lists"];

	[self didAccessValueForKey:@"lists"];
	return result;
}

@dynamic positions;

- (NSMutableSet<Position*>*)positionsSet {
	[self willAccessValueForKey:@"positions"];

	NSMutableSet<Position*> *result = (NSMutableSet<Position*>*)[self mutableSetValueForKey:@"positions"];

	[self didAccessValueForKey:@"positions"];
	return result;
}

@end

@implementation ItemAttributes 
+ (NSString *)currentIndex {
	return @"currentIndex";
}
+ (NSString *)text {
	return @"text";
}
@end

@implementation ItemRelationships 
+ (NSString *)lists {
	return @"lists";
}
+ (NSString *)positions {
	return @"positions";
}
@end

