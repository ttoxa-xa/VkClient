// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to News.h instead.

#import <CoreData/CoreData.h>


extern const struct NewsAttributes {
	__unsafe_unretained NSString *date;
	__unsafe_unretained NSString *hasPicture;
	__unsafe_unretained NSString *id;
	__unsafe_unretained NSString *owner;
	__unsafe_unretained NSString *ownersName;
	__unsafe_unretained NSString *text;
} NewsAttributes;

extern const struct NewsRelationships {
	__unsafe_unretained NSString *avatar;
	__unsafe_unretained NSString *pictures;
	__unsafe_unretained NSString *user;
} NewsRelationships;

extern const struct NewsFetchedProperties {
} NewsFetchedProperties;

@class Picture;
@class Picture;
@class User;








@interface NewsID : NSManagedObjectID {}
@end

@interface _News : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (NewsID*)objectID;





@property (nonatomic, strong) NSDate* date;



//- (BOOL)validateDate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* hasPicture;



@property BOOL hasPictureValue;
- (BOOL)hasPictureValue;
- (void)setHasPictureValue:(BOOL)value_;

//- (BOOL)validateHasPicture:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* id;



@property int32_t idValue;
- (int32_t)idValue;
- (void)setIdValue:(int32_t)value_;

//- (BOOL)validateId:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* owner;



@property int32_t ownerValue;
- (int32_t)ownerValue;
- (void)setOwnerValue:(int32_t)value_;

//- (BOOL)validateOwner:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* ownersName;



//- (BOOL)validateOwnersName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* text;



//- (BOOL)validateText:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) Picture *avatar;

//- (BOOL)validateAvatar:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet *pictures;

- (NSMutableSet*)picturesSet;




@property (nonatomic, strong) User *user;

//- (BOOL)validateUser:(id*)value_ error:(NSError**)error_;





@end

@interface _News (CoreDataGeneratedAccessors)

- (void)addPictures:(NSSet*)value_;
- (void)removePictures:(NSSet*)value_;
- (void)addPicturesObject:(Picture*)value_;
- (void)removePicturesObject:(Picture*)value_;

@end

@interface _News (CoreDataGeneratedPrimitiveAccessors)


- (NSDate*)primitiveDate;
- (void)setPrimitiveDate:(NSDate*)value;




- (NSNumber*)primitiveHasPicture;
- (void)setPrimitiveHasPicture:(NSNumber*)value;

- (BOOL)primitiveHasPictureValue;
- (void)setPrimitiveHasPictureValue:(BOOL)value_;




- (NSNumber*)primitiveId;
- (void)setPrimitiveId:(NSNumber*)value;

- (int32_t)primitiveIdValue;
- (void)setPrimitiveIdValue:(int32_t)value_;




- (NSNumber*)primitiveOwner;
- (void)setPrimitiveOwner:(NSNumber*)value;

- (int32_t)primitiveOwnerValue;
- (void)setPrimitiveOwnerValue:(int32_t)value_;




- (NSString*)primitiveOwnersName;
- (void)setPrimitiveOwnersName:(NSString*)value;




- (NSString*)primitiveText;
- (void)setPrimitiveText:(NSString*)value;





- (Picture*)primitiveAvatar;
- (void)setPrimitiveAvatar:(Picture*)value;



- (NSMutableSet*)primitivePictures;
- (void)setPrimitivePictures:(NSMutableSet*)value;



- (User*)primitiveUser;
- (void)setPrimitiveUser:(User*)value;


@end
