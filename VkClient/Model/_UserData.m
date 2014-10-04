// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserData.m instead.

#import "_UserData.h"

const struct UserDataAttributes UserDataAttributes = {
        .city = @"city",
        .country = @"country",
        .first_name = @"first_name",
        .last_name = @"last_name",
        .photo_url = @"photo_url",
        .sex = @"sex",
        .token = @"token",
        .user_id = @"user_id",
};

const struct UserDataRelationships UserDataRelationships = {
};

const struct UserDataFetchedProperties UserDataFetchedProperties = {
};

@implementation UserDataID
@end

@implementation _UserData

+ (id)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
    NSParameterAssert(moc_);
    return [NSEntityDescription insertNewObjectForEntityForName:@"UserData" inManagedObjectContext:moc_];
}

+ (NSString *)entityName {
    return @"UserData";
}

+ (NSEntityDescription *)entityInManagedObjectContext:(NSManagedObjectContext *)moc_ {
    NSParameterAssert(moc_);
    return [NSEntityDescription entityForName:@"UserData" inManagedObjectContext:moc_];
}

- (UserDataID *)objectID {
    return (UserDataID *) [super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
    NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

    if ([key isEqualToString:@"sexValue"]) {
        NSSet *affectingKey = [NSSet setWithObject:@"sex"];
        keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
        return keyPaths;
    }

    return keyPaths;
}


@dynamic city;


@dynamic country;


@dynamic first_name;


@dynamic last_name;


@dynamic photo_url;


@dynamic sex;


- (int32_t)sexValue {
    NSNumber *result = [self sex];
    return [result intValue];
}

- (void)setSexValue:(int32_t)value_ {
    [self setSex:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveSexValue {
    NSNumber *result = [self primitiveSex];
    return [result intValue];
}

- (void)setPrimitiveSexValue:(int32_t)value_ {
    [self setPrimitiveSex:[NSNumber numberWithInt:value_]];
}


@dynamic token;


@dynamic user_id;


@end
