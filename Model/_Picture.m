// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Picture.m instead.

#import "_Picture.h"

const struct PictureAttributes PictureAttributes = {
	.pictureData = @"pictureData",
};

const struct PictureRelationships PictureRelationships = {
	.news = @"news",
};

const struct PictureFetchedProperties PictureFetchedProperties = {
};

@implementation PictureID
@end

@implementation _Picture

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Picture" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Picture";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Picture" inManagedObjectContext:moc_];
}

- (PictureID*)objectID {
	return (PictureID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic pictureData;






@dynamic news;

	






@end
