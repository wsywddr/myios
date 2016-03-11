
//
//  HMTg.m
//  yzyw
//
//  Created by nnm on 16/2/25.
//  Copyright © 2016年 nnm. All rights reserved.
//

#import "HMTg.h"

@implementation HMTg
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self=[super init];
    if(self){
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)tgWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

+ (NSArray *)tgs
{
    NSArray *array=[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tgs.plist" ofType:nil]];
    NSMutableArray *arrayM=[NSMutableArray array];
    for(NSDictionary *dict in array){
        [arrayM addObject:[self tgWithDict:dict]];
    }
    return arrayM;
}
@end
