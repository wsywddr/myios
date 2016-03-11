//
//  HMTg.h
//  yzyw
//
//  Created by nnm on 16/2/25.
//  Copyright © 2016年 nnm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMTg : NSObject
//title icon 和tgs.plist保持一致
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *sectitle;
@property (nonatomic,copy) NSString *icon;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)tgWithDict:(NSDictionary *)dict;

+ (NSArray *)tgs;
@end
