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

	if ([key isEqualToString:@"editingValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"editing"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"indexValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"index"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic editing;

- (BOOL)editingValue {
	NSNumber *result = [self editing];
	return [result boolValue];
}

- (void)setEditingValue:(BOOL)value_ {
	[self setEditing:@(value_)];
}

- (BOOL)primitiveEditingValue {
	NSNumber *result = [self primitiveEditing];
	return [result boolValue];
}

- (void)setPrimitiveEditingValue:(BOOL)value_ {
	[self setPrimitiveEditing:@(value_)];
}

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

@end

@implementation ListAttributes 
+ (NSString *)editing {
	return @"editing";
}
+ (NSString *)index {
	return @"index";
}
+ (NSString *)title {
	return @"title";
}
@end

