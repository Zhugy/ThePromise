//
//  SPTObjectProperty.h
//  Suning
//
//  Created by Louis Zhu on 15/3/31.
//  Copyright (c) 2015年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 相关知识请参见Runtime文档
 Type Encodings https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html#//apple_ref/doc/uid/TP40008048-CH100-SW1
 Property Type String https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtPropertyIntrospection.html#//apple_ref/doc/uid/TP40008048-CH101-SW6
 */
typedef NS_ENUM(NSUInteger, SPTObjectPropertyType) {
    SPTObjectPropertyTypeNone = 0,
    SPTObjectPropertyTypeChar,
    SPTObjectPropertyTypeInt,
    SPTObjectPropertyTypeShort,
    SPTObjectPropertyTypeLong,
    SPTObjectPropertyTypeLongLong,
    SPTObjectPropertyTypeUnsignedChar,
    SPTObjectPropertyTypeUnsignedInt,
    SPTObjectPropertyTypeUnsignedShort,
    SPTObjectPropertyTypeUnsignedLong,
    SPTObjectPropertyTypeUnsignedLongLong,
    SPTObjectPropertyTypeFloat,
    SPTObjectPropertyTypeDouble,
    SPTObjectPropertyTypeBool,
    SPTObjectPropertyTypeVoid,
    SPTObjectPropertyTypeCharString,
    SPTObjectPropertyTypeObject,
    SPTObjectPropertyTypeClassObject,
    SPTObjectPropertyTypeSelector,
    SPTObjectPropertyTypeArray,
    SPTObjectPropertyTypeStruct,
    SPTObjectPropertyTypeUnion,
    SPTObjectPropertyTypeBitField,
    SPTObjectPropertyTypePointer,
    SPTObjectPropertyTypeUnknown,
};


@interface SPTObjectProperty : NSObject
@property (nonatomic, copy) NSString *name;

@property (nonatomic) SPTObjectPropertyType propertyType;
@property (nonatomic, copy) NSString *typeName;
@property (nonatomic, assign) Class objectClass;
@property (nonatomic, strong) NSArray *objectProtocols;
@property (nonatomic) BOOL isReadonly;

- (instancetype)initWithName:(NSString *)name typeString:(NSString *)typeString;

@end
