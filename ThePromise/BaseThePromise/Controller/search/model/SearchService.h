//
//  SearchService.h
//  ThePromise
//
//  Created by zhugy on 2017/9/12.
//  Copyright © 2017年 zhugy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SearchModel;

@interface SearchService : NSObject

+ (NSArray <SearchModel *> *)loadSearchHome;

@end
