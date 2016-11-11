// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Position.m instead.

#import "_Position.h"

@implementation PositionID
@end

@implementation _Position

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Position" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Position";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Position" inManagedObjectContext:moc_];
}

- (PositionID*)objectID {
	return (PositionID*)[super objectID];
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

@dynamic index;

- (int16_t)indexValue {
	NSNumber *result = [self index];
	return [result shortValue];
}

- (void)setIndexValue:(int16_t)value_ {
	[self setIndex:@(value_)];
}

- (int16_t)primitiveIndexValue {
	NSNumber *result = [self primitiveIndex];
	return [result shortValue];
}

- (void)setPrimitiveIndexValue:(int16_t)value_ {
	[self setPrimitiveIndex:@(value_)];
}

@dynamic item;

@dynamic list;

@end

@implementation PositionAttributes 
+ (NSString *)index {
	return @"index";
}
@end

@implementation PositionRelationships 
+ (NSString *)item {
	return @"item";
}
+ (NSString *)list {
	return @"list";
}
@end

