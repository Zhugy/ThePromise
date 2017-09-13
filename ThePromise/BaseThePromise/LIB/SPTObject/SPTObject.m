//
//  SPTObject.m
//  Suning
//
//  Created by Louis Zhu on 15/3/31.
//  Copyright (c) 2015年 Suning. All rights reserved.
//

#import <objc/runtime.h>
#import "SPTObject.h"
#import "SPTObjectProperty.h"


@implementation NSArray (SPTObject)


- (NSArray *)modelsOfClass:(Class)modelClass {
    NSMutableArray *modelArray = [NSMutableArray array];
    for (id object in self) {
        if ([object isKindOfClass:[NSArray class]]) {
            [modelArray addObject:[object modelsOfClass:modelClass]];
        } else if ([object isKindOfClass:[NSDictionary class]]){
            [modelArray addObject:[[modelClass alloc] initWithDictionary:object]];
        } else {
            [modelArray addObject:object];
        }
    }
    return [modelArray copy];
}


@end


#pragma mark - NSDictionary+SPTObject


@interface NSDictionary (SPTObject)

- (NSDictionary *)modelDictionaryWithClass:(Class)modelClass;

@end


@implementation NSDictionary (SPTObject)


- (NSDictionary *)modelDictionaryWithClass:(Class)modelClass {
    NSMutableDictionary *modelDictionary = [NSMutableDictionary dictionary];
    for (NSString *key in self) {
        id object = self[key];
        if ([object isKindOfClass:[NSDictionary class]]) {
            modelDictionary[key] = [[modelClass alloc] initWithDictionary:object];
        } else if ([object isKindOfClass:[NSArray class]]) {
            modelDictionary[key] = [object modelsOfClass:modelClass];
        } else {
            modelDictionary[key] = object;
        }
    }
    return modelDictionary;
}


@end


#pragma mark - SPTObject


static const char *SPTObjectKeyMapKey;
static const char *SPTObjectPropertyKey;


@interface SPTObject()

- (void)setupCachedKeyMap;
- (void)setupCachedProperties;

@end


@implementation SPTObject


- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupCachedKeyMap];
        [self setupCachedProperties];
    }
    return self;
}


- (instancetype)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary {
    self = [self init];
    if (self) {
        [self injectJSONData:dictionary];
        [self additionalConfigurationWithDictionary:dictionary];
    }
    return self;
}


+ (id)modelFromJSONObject:(id)JSONObject {
    if ([JSONObject isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dictionary = (NSDictionary *)JSONObject;
        if (dictionary.count == 0) {
            return nil;
        }
        return [[self alloc] initWithDictionary:dictionary];
    }
    
    if ([JSONObject isKindOfClass:[NSArray class]]) {
        NSArray *array = (NSArray *)JSONObject;
        if (array.count == 0) {
            return [NSArray array];
        }
        return [JSONObject modelsOfClass:[self class]];
    }
    
    return nil;
}


#pragma mark - SPTObject Configuration


- (void)setupCachedKeyMap {
    if (objc_getAssociatedObject(self.class, &SPTObjectKeyMapKey) == nil) {
        NSDictionary *keyMap = self.keyMap;
        if (keyMap.count) {
            objc_setAssociatedObject(self.class, &SPTObjectKeyMapKey, keyMap, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
}


- (void)setupCachedProperties {
    if (objc_getAssociatedObject(self.class, &SPTObjectPropertyKey) == nil) {
        NSMutableDictionary *propertyMap = [NSMutableDictionary dictionary];
        Class class = [self class];
        while (class != [SPTObject class]) {
            unsigned int propertyCount;
            objc_property_t *properties = class_copyPropertyList(class, &propertyCount);
            for (unsigned int i = 0; i < propertyCount; i++) {
                
                objc_property_t property = properties[i];
                const char *propertyName = property_getName(property);
                NSString *name = [NSString stringWithUTF8String:propertyName];
                const char *propertyAttrs = property_getAttributes(property);
                NSString *typeString = [NSString stringWithUTF8String:propertyAttrs];
                SPTObjectProperty *modelProperty = [[SPTObjectProperty alloc] initWithName:name typeString:typeString];
                if (!modelProperty.isReadonly) {
                    [propertyMap setValue:modelProperty forKey:modelProperty.name];
                }
            }
            free(properties);
            
            class = [class superclass];
        }
        objc_setAssociatedObject(self.class, &SPTObjectPropertyKey, propertyMap, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}


#pragma mark - SPTObject Runtime Injection


- (void)injectJSONData:(id)dataObject {
    NSDictionary *keyMap = objc_getAssociatedObject(self.class, &SPTObjectKeyMapKey);
    NSDictionary *properties = objc_getAssociatedObject(self.class, &SPTObjectPropertyKey);
    
    if ([dataObject isKindOfClass:[NSArray class]]) { // TODO: Louis: remove this branch? or reimplement it?
        SPTObjectProperty *arrayProperty = nil;
        Class class = NULL;
        for (SPTObjectProperty *property in [properties allValues]) {
            NSString *valueProtocol = [property.objectProtocols firstObject];
            class = NSClassFromString(valueProtocol);
            if ([valueProtocol isKindOfClass:[NSString class]] && [class isSubclassOfClass:[SPTObject class]]) {
                arrayProperty = property;
                break;
            }
        }
        
        if (arrayProperty && class) {
            id value = [(NSArray *) dataObject modelsOfClass:class];
            [self setValue:value forKey:arrayProperty.name];
        }
    }
    else if ([dataObject isKindOfClass:[NSDictionary class]]) {
        for (SPTObjectProperty *property in [properties allValues]) {
            NSString *jsonKey = property.name;
            NSString *mapKey = keyMap[jsonKey];
            jsonKey = mapKey ?: jsonKey;
            
            id jsonValue = [dataObject objectForKey:jsonKey];
            id propertyValue = [self valueForProperty:property withJSONValue:jsonValue];
            
            if (propertyValue) {
                [self setValue:propertyValue forKey:property.name];
            }
            else {
                // Louis: never reset a nil value (parsed from JSON data) to property, subclasses should handle nil value (or default value) all by self
//                id resetValue = (property.propertyType == SPTObjectPropertyTypeObject) ? nil : @(0);
//                [self setValue:resetValue forKey:property.name];
            }
        }
    }
}


- (id)valueForProperty:(SPTObjectProperty *)property withJSONValue:(id)value {
    id resultValue = value;
    if (value == nil || [value isKindOfClass:[NSNull class]]) {
        resultValue = nil;
    }
    else {
        if (property.propertyType != SPTObjectPropertyTypeObject) {
            if ([value isKindOfClass:[NSString class]]) {
                if (property.propertyType == SPTObjectPropertyTypeInt ||
                    property.propertyType == SPTObjectPropertyTypeUnsignedInt||
                    property.propertyType == SPTObjectPropertyTypeShort||
                    property.propertyType == SPTObjectPropertyTypeUnsignedShort) {
                    resultValue = @([(NSString *) value intValue]);
                }
                if (property.propertyType == SPTObjectPropertyTypeLong ||
                    property.propertyType == SPTObjectPropertyTypeUnsignedLong ||
                    property.propertyType == SPTObjectPropertyTypeLongLong ||
                    property.propertyType == SPTObjectPropertyTypeUnsignedLongLong){
                    resultValue = @([(NSString *) value longLongValue]);
                }
                if (property.propertyType == SPTObjectPropertyTypeFloat) {
                    resultValue = @([(NSString *) value floatValue]);
                }
                if (property.propertyType == SPTObjectPropertyTypeDouble) {
                    resultValue = @([(NSString *) value doubleValue]);
                }
                if (property.propertyType == SPTObjectPropertyTypeChar) {
                    //对于BOOL而言，@encode(BOOL) 为 c 也就是signed char
                    resultValue = @([(NSString *) value boolValue]);
                }
            }
        }
        else {
            Class valueClass = property.objectClass;
            if ([valueClass isSubclassOfClass:[SPTObject class]] && [value isKindOfClass:[NSDictionary class]]) {
                resultValue = [[valueClass alloc] initWithDictionary:value];
            }
            
            if ([valueClass isSubclassOfClass:[NSString class]] &&
                ![value isKindOfClass:[NSString class]]) {
                resultValue = [NSString stringWithFormat:@"%@",value];
            }
            
            if ([valueClass isSubclassOfClass:[NSNumber class]] &&
                [value isKindOfClass:[NSString class]]) {
                NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
                [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
                resultValue = [numberFormatter numberFromString:value];
            }
            
            if ([valueClass isSubclassOfClass:[NSArray class]] && [value isKindOfClass:[NSArray class]]) {
                NSDictionary *arrayElementTypeMap = self.arrayElementTypeMap;
                Class arrayElementType = arrayElementTypeMap[property.name];
                if (arrayElementType != nil) {
                    if ([arrayElementType isSubclassOfClass:[SPTObject class]]) {
                        resultValue = [(NSArray *) value modelsOfClass:arrayElementType];
                    }
                }
            }
            
            NSString *valueProtocol = [property.objectProtocols lastObject];
            if ([valueProtocol isKindOfClass:[NSString class]]) {
                Class valueProtocolClass = NSClassFromString(valueProtocol);
                if (valueProtocolClass != nil) {
                    if ([valueProtocolClass isSubclassOfClass:[SPTObject class]]) {
                        //array of models
                        if ([value isKindOfClass:[NSArray class]]) {
                            resultValue = [(NSArray *) value modelsOfClass:valueProtocolClass];
                        }
                        //dictionary of models
                        if ([value isKindOfClass:[NSDictionary class]]) {
                            resultValue = [(NSDictionary *)value modelDictionaryWithClass:valueProtocolClass];
                        }
                    }
                }
            }
        }
    }
    return resultValue;
}


- (void)additionalConfigurationWithDictionary:(NSDictionary<NSString *, id> *)dictionary {
    
}


- (NSArray *)propertiesForCoding {
    return nil;
}


- (NSArray *)propertiesForDescription {
    return [self propertiesForCoding];
}


- (NSString *)description {
    NSMutableString *result = [NSMutableString string];
    
    [result appendString:[super description]];
    [result appendString:@": "];
    
    NSArray *properties = [self propertiesForDescription];
    for (NSString *key in properties) {
        id value = [self valueForKey:key];
        [result appendFormat:@"%@ = %@, ", key, value];
    }
    
    return result;
}


@end
