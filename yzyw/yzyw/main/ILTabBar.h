//
//  ILTabBar.h
//  caipiao
//
//  Created by nnm on 16/2/16.
//  Copyright © 2016年 nnm. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  ILTabBar;

@protocol ILTabBarDelegate <NSObject>

@optional
- (void)tabBar:(ILTabBar *)tabBar didSelectedIndex:(int)index;

@end


@interface ILTabBar : UIView

@property (nonatomic,weak) id<ILTabBarDelegate> delegate;

@end
