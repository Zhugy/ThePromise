//
//  SearchService.m
//  ThePromise
//
//  Created by zhugy on 2017/9/12.
//  Copyright © 2017年 zhugy. All rights reserved.
//

#import "SearchService.h"
#import "ThePromise-Swift.h"

@implementation SearchService

+ (NSArray <SearchModel *> *)loadSearchHome {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"search" ofType:@"txt"];
    NSString *filename = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    NSData *data = [filename dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *resutDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    NSArray *arr = resutDict[@"data"];
    
    NSMutableArray *resoutArr = [NSMutableArray array];
    
    for (NSDictionary *dict in arr) {
        SearchModel *resp = [[SearchModel alloc] initWithDictionary:dict];
        [resoutArr addObject:resp];
    }
    return resoutArr;
}

@end
