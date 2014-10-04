// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to User.m instead.

#import "_User.h"

const struct UserAttributes UserAttributes = {
	.first_name = @"first_name",
	.last_name = @"last_name",
	.photo_medium = @"photo_medium",
	.token = @"token",
	.uid = @"uid",
};

const struct UserRelationships UserRelationships = {
	.news = @"news",
};

const struct UserFetchedProperties UserFetchedProperties = {
};

@implementation UserID
@end

@implementation _User

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"User";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"User" inManagedObjectContext:moc_];
}

- (UserID*)objectID {
	return (UserID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"uidValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"uid"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic first_name;






@dynamic last_name;






@dynamic photo_medium;






@dynamic token;






@dynamic uid;



- (int16_t)uidValue {
	NSNumber *result = [self uid];
	return [result shortValue];
}

- (void)setUidValue:(int16_t)value_ {
	[self setUid:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveUidValue {
	NSNumber *result = [self primitiveUid];
	return [result shortValue];
}

- (void)setPrimitiveUidValue:(int16_t)value_ {
	[self setPrimitiveUid:[NSNumber numberWithShort:value_]];
}





@dynamic news;

	
- (NSMutableSet*)newsSet {
	[self willAccessValueForKey:@"news"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"news"];
  
	[self didAccessValueForKey:@"news"];
	return result;
}
	






@end
