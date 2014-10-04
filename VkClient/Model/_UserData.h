// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserData.h instead.

#import <CoreData/CoreData.h>


extern const struct UserDataAttributes {
    __unsafe_unretained NSString *city;
    __unsafe_unretained NSString *country;
    __unsafe_unretained NSString *first_name;
    __unsafe_unretained NSString *last_name;
    __unsafe_unretained NSString *photo_url;
    __unsafe_unretained NSString *sex;
    __unsafe_unretained NSString *token;
    __unsafe_unretained NSString *user_id;
} UserDataAttributes;

extern const struct UserDataRelationships {
} UserDataRelationships;

extern const struct UserDataFetchedProperties {
} UserDataFetchedProperties;


@interface UserDataID : NSManagedObjectID {
}
@end

@interface _UserData : NSManagedObject {
}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;

+ (NSString *)entityName;

+ (NSEntityDescription *)entityInManagedObjectContext:(NSManagedObjectContext *)moc_;

- (UserDataID *)objectID;


@property(nonatomic, strong) NSString *city;



//- (BOOL)validateCity:(id*)value_ error:(NSError**)error_;





@property(nonatomic, strong) NSString *country;



//- (BOOL)validateCountry:(id*)value_ error:(NSError**)error_;





@property(nonatomic, strong) NSString *first_name;



//- (BOOL)validateFirst_name:(id*)value_ error:(NSError**)error_;





@property(nonatomic, strong) NSString *last_name;



//- (BOOL)validateLast_name:(id*)value_ error:(NSError**)error_;





@property(nonatomic, strong) NSString *photo_url;



//- (BOOL)validatePhoto_url:(id*)value_ error:(NSError**)error_;





@property(nonatomic, strong) NSNumber *sex;


@property int32_t sexValue;

- (int32_t)sexValue;

- (void)setSexValue:(int32_t)value_;

//- (BOOL)validateSex:(id*)value_ error:(NSError**)error_;





@property(nonatomic, strong) NSString *token;



//- (BOOL)validateToken:(id*)value_ error:(NSError**)error_;





@property(nonatomic, strong) NSString *user_id;



//- (BOOL)validateUser_id:(id*)value_ error:(NSError**)error_;






@end

@interface _UserData (CoreDataGeneratedAccessors)

@end

@interface _UserData (CoreDataGeneratedPrimitiveAccessors)


- (NSString *)primitiveCity;

- (void)setPrimitiveCity:(NSString *)value;


- (NSString *)primitiveCountry;

- (void)setPrimitiveCountry:(NSString *)value;


- (NSString *)primitiveFirst_name;

- (void)setPrimitiveFirst_name:(NSString *)value;


- (NSString *)primitiveLast_name;

- (void)setPrimitiveLast_name:(NSString *)value;


- (NSString *)primitivePhoto_url;

- (void)setPrimitivePhoto_url:(NSString *)value;


- (NSNumber *)primitiveSex;

- (void)setPrimitiveSex:(NSNumber *)value;

- (int32_t)primitiveSexValue;

- (void)setPrimitiveSexValue:(int32_t)value_;


- (NSString *)primitiveToken;

- (void)setPrimitiveToken:(NSString *)value;


- (NSString *)primitiveUser_id;

- (void)setPrimitiveUser_id:(NSString *)value;


@end
