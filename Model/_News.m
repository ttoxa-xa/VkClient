// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to News.m instead.

#import "_News.h"

const struct NewsAttributes NewsAttributes = {
	.date = @"date",
	.hasPicture = @"hasPicture",
	.id = @"id",
	.owner = @"owner",
	.ownersName = @"ownersName",
	.text = @"text",
};

const struct NewsRelationships NewsRelationships = {
	.avatar = @"avatar",
	.pictures = @"pictures",
	.user = @"user",
};

const struct NewsFetchedProperties NewsFetchedProperties = {
};

@implementation NewsID
@end

@implementation _News

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"News" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"News";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"News" inManagedObjectContext:moc_];
}

- (NewsID*)objectID {
	return (NewsID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"hasPictureValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"hasPicture"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"ownerValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"owner"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic date;






@dynamic hasPicture;



- (BOOL)hasPictureValue {
	NSNumber *result = [self hasPicture];
	return [result boolValue];
}

- (void)setHasPictureValue:(BOOL)value_ {
	[self setHasPicture:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveHasPictureValue {
	NSNumber *result = [self primitiveHasPicture];
	return [result boolValue];
}

- (void)setPrimitiveHasPictureValue:(BOOL)value_ {
	[self setPrimitiveHasPicture:[NSNumber numberWithBool:value_]];
}





@dynamic id;



- (int32_t)idValue {
	NSNumber *result = [self id];
	return [result intValue];
}

- (void)setIdValue:(int32_t)value_ {
	[self setId:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveIdValue {
	NSNumber *result = [self primitiveId];
	return [result intValue];
}

- (void)setPrimitiveIdValue:(int32_t)value_ {
	[self setPrimitiveId:[NSNumber numberWithInt:value_]];
}





@dynamic owner;



- (int32_t)ownerValue {
	NSNumber *result = [self owner];
	return [result intValue];
}

- (void)setOwnerValue:(int32_t)value_ {
	[self setOwner:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveOwnerValue {
	NSNumber *result = [self primitiveOwner];
	return [result intValue];
}

- (void)setPrimitiveOwnerValue:(int32_t)value_ {
	[self setPrimitiveOwner:[NSNumber numberWithInt:value_]];
}





@dynamic ownersName;






@dynamic text;






@dynamic avatar;

	

@dynamic pictures;

	
- (NSMutableSet*)picturesSet {
	[self willAccessValueForKey:@"pictures"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"pictures"];
  
	[self didAccessValueForKey:@"pictures"];
	return result;
}
	

@dynamic user;

	






@end
