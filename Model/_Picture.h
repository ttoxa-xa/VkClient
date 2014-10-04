// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Picture.h instead.

#import <CoreData/CoreData.h>


extern const struct PictureAttributes {
	__unsafe_unretained NSString *pictureData;
} PictureAttributes;

extern const struct PictureRelationships {
	__unsafe_unretained NSString *news;
} PictureRelationships;

extern const struct PictureFetchedProperties {
} PictureFetchedProperties;

@class News;



@interface PictureID : NSManagedObjectID {}
@end

@interface _Picture : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (PictureID*)objectID;





@property (nonatomic, strong) NSData* pictureData;



//- (BOOL)validatePictureData:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) News *news;

//- (BOOL)validateNews:(id*)value_ error:(NSError**)error_;





@end

@interface _Picture (CoreDataGeneratedAccessors)

@end

@interface _Picture (CoreDataGeneratedPrimitiveAccessors)


- (NSData*)primitivePictureData;
- (void)setPrimitivePictureData:(NSData*)value;





- (News*)primitiveNews;
- (void)setPrimitiveNews:(News*)value;


@end
