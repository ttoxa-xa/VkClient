// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to User.h instead.

#import <CoreData/CoreData.h>


extern const struct UserAttributes {
	__unsafe_unretained NSString *first_name;
	__unsafe_unretained NSString *last_name;
	__unsafe_unretained NSString *photo_medium;
	__unsafe_unretained NSString *token;
	__unsafe_unretained NSString *uid;
} UserAttributes;

extern const struct UserRelationships {
	__unsafe_unretained NSString *news;
} UserRelationships;

extern const struct UserFetchedProperties {
} UserFetchedProperties;

@class News;







@interface UserID : NSManagedObjectID {}
@end

@interface _User : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (UserID*)objectID;





@property (nonatomic, strong) NSString* first_name;



//- (BOOL)validateFirst_name:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* last_name;



//- (BOOL)validateLast_name:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* photo_medium;



//- (BOOL)validatePhoto_medium:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* token;



//- (BOOL)validateToken:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* uid;



@property int16_t uidValue;
- (int16_t)uidValue;
- (void)setUidValue:(int16_t)value_;

//- (BOOL)validateUid:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *news;

- (NSMutableSet*)newsSet;





@end

@interface _User (CoreDataGeneratedAccessors)

- (void)addNews:(NSSet*)value_;
- (void)removeNews:(NSSet*)value_;
- (void)addNewsObject:(News*)value_;
- (void)removeNewsObject:(News*)value_;

@end

@interface _User (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveFirst_name;
- (void)setPrimitiveFirst_name:(NSString*)value;




- (NSString*)primitiveLast_name;
- (void)setPrimitiveLast_name:(NSString*)value;




- (NSString*)primitivePhoto_medium;
- (void)setPrimitivePhoto_medium:(NSString*)value;




- (NSString*)primitiveToken;
- (void)setPrimitiveToken:(NSString*)value;




- (NSNumber*)primitiveUid;
- (void)setPrimitiveUid:(NSNumber*)value;

- (int16_t)primitiveUidValue;
- (void)setPrimitiveUidValue:(int16_t)value_;





- (NSMutableSet*)primitiveNews;
- (void)setPrimitiveNews:(NSMutableSet*)value;


@end
