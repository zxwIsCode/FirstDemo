//
//  CMCustomViewFactory.m
//  ComeMoneyHere
//
//  Created by 李保东 on 16/11/15.
//  Copyright © 2016年 DaviD. All rights reserved.
//

#import "CMCustomViewFactory.h"

@implementation CMCustomViewFactory

+ (UIButton*)createButton:(CGRect)frame title:(NSString*)title backgourdImage:(UIImage*)backgroundImage
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.frame = frame;
    [button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    return button;
}

+ (UILabel*)createLabel:(CGRect)frame title:(NSString*)title color:(UIColor*)color font:(UIFont*)font textAlignment:(NSTextAlignment)alignment{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.text = title;
    UIColor *labelColor = (color == nil ? [UIColor blackColor]:color);
    label.textColor = labelColor;
    UIFont  *labelFont = (font == nil ? [UIFont systemFontOfSize:17] : font);
    label.font = labelFont;
    label.textAlignment = alignment;
    return label;
}

@end
