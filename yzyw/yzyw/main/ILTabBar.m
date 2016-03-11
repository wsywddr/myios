//
//  ILTabBar.m
//  caipiao
//
//  Created by nnm on 16/2/16.
//  Copyright © 2016年 nnm. All rights reserved.
//

#import "ILTabBar.h"

#import "ILTarBarButton.h"

@interface ILTabBar()
@property (nonatomic,weak) UIButton *selectbutton;

@end

@implementation ILTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //add button
        [self addBtns];
    }
    return self;
}

- (void)addBtns
{
    NSString *imageName=nil;
    NSString *imageSelName=nil;
    
    for(int i=0;i<4;i++)
    {
        ILTarBarButton *btn=[ILTarBarButton buttonWithType:UIButtonTypeCustom];
        
        imageName=[NSString stringWithFormat:@"t0%d",i+1];
        
        imageSelName=[NSString stringWithFormat:@"ts0%d",i+1];
    
        //set image
        [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        
        [btn setBackgroundImage:[UIImage imageNamed:imageSelName] forState:UIControlStateSelected];
        
        //set click
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        
        [self addSubview:btn];
        
        btn.tag=i;
        
        if(i==0){
            [self btnClick:btn];
        }
    
    }
}

// when click do
- (void)btnClick:(UIButton *)button
{
    _selectbutton.selected=NO;
    
    button.selected=YES;
    
    _selectbutton=button;
    
    //do delegate
    if([_delegate respondsToSelector:@selector(tabBar:didSelectedIndex:)])
    {
        [_delegate tabBar:self didSelectedIndex:button.tag];
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat btnW=self.bounds.size.width/self.subviews.count;
    CGFloat btnH=self.bounds.size.height;
    CGFloat btnX=0;
    CGFloat btnY=0;
    
    
    //set width height
    for(int i=0;i<self.subviews.count;i++){
        UIButton *btn=self.subviews[i];
        
        btnX=i*btnW;
        
        btn.frame=CGRectMake(btnX, btnY, btnW, btnH);
     
    }
}




@end
