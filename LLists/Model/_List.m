// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to List.m instead.

#import "_List.h"

@implementation ListID
@end

@implementation _List

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"List" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"List";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"List" inManagedObjectContext:moc_];
}

- (ListID*)objectID {
	return (ListID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"indexValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"index"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic color;

@dynamic index;

- (uint16_t)indexValue {
	NSNumber *result = [self index];
	return [result unsignedShortValue];
}

- (void)setIndexValue:(uint16_t)value_ {
	[self setIndex:@(value_)];
}

- (uint16_t)primitiveIndexValue {
	NSNumber *result = [self primitiveIndex];
	return [result unsignedShortValue];
}

- (void)setPrimitiveIndexValue:(uint16_t)value_ {
	[self setPrimitiveIndex:@(value_)];
}

@dynamic title;

@dynamic items;

- (NSMutableSet<Item*>*)itemsSet {
	[self willAccessValueForKey:@"items"];

	NSMutableSet<Item*> *result = (NSMutableSet<Item*>*)[self mutableSetValueForKey:@"items"];

	[self didAccessValueForKey:@"items"];
	return result;
}

@end

@implementation ListAttributes 
+ (NSString *)color {
	return @"color";
}
+ (NSString *)index {
	return @"index";
}
+ (NSString *)title {
	return @"title";
}
@end

@implementation ListRelationships 
+ (NSString *)items {
	return @"items";
}
@end

