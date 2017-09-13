//
//  SPTObject.h
//  Suning
//
//  Created by Louis Zhu on 15/3/31.
//  Copyright (c) 2015年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSArray (SPTObject)

- (NSArray *)modelsOfClass:(Class)modelClass;

@end


@protocol SPTExpressibleByDictionaryLiteral <NSObject>

- (instancetype)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary;

@end


@protocol SPTObject <SPTExpressibleByDictionaryLiteral>

+ (id)modelFromJSONObject:(id)JSONObject;

@end


@interface SPTObject : NSObject<SPTObject>

// 子类需要覆盖此方法，提供model和JSON无法对应到的成员
@property (nonatomic, strong, readonly) NSDictionary<NSString *, NSString *> *keyMap;
@property (nonatomic, strong, readonly) NSDictionary<NSString *, Class> *arrayElementTypeMap;

- (void)additionalConfigurationWithDictionary:(NSDictionary<NSString *, id> *)dictionary;

- (NSArray *)propertiesForCoding;
// equals to -propertiesForCoding by default
- (NSArray *)propertiesForDescription;

@end
