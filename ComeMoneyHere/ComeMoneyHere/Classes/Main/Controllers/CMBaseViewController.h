//
//  CMBaseViewController.h
//  ComeMoneyHere
//
//  Created by 李保东 on 16/11/15.
//  Copyright © 2016年 DaviD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CMNavType) {
    CMNavTypeAll =0,      //左中右item都有
    CMNavTypeNoRightItem ,//右item没有
    CMNavTypeOnlyTitle ,  //只有中间item有
    CMNavTypeNone,        //没有navbar
    
};
@interface CMBaseViewController : UIViewController


//@property(nonatomic,assign)CMNavType navType;

-(CMNavType)getNavType;

//定制导航栏上的titleView
- (void)customNavigationTitleView;

//定制导航栏左边的按钮
- (void)customNavigationLeftItem;

//定制导航栏右边的按钮
- (void)customNavigationRighItem;


// 子类优先重写以下的方法
-(NSString *)customNavigationRightItemTitle;

-(NSString *)customNavigationTitleViewTitleStr;

- (void)navigationLeftButtonClick:(id)sender;
- (void)navigationRightButtonClick:(id)sender;
@end
