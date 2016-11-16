//
//  CMBaseViewController.m
//  ComeMoneyHere
//
//  Created by 李保东 on 16/11/15.
//  Copyright © 2016年 DaviD. All rights reserved.
//

#import "CMBaseViewController.h"

@interface CMBaseViewController ()

@end

@implementation CMBaseViewController

#pragma mark - Init
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
//    //导航栏背景图
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar.png"] forBarMetrics:UIBarMetricsDefault];
//    //背景颜色，
//    self.view.backgroundColor = [UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1];
    
    [self dependOnKindToViewShow];
    self.view.backgroundColor =[UIColor whiteColor];
}
#pragma mark - Private Methods
-(void)dependOnKindToViewShow {
   CMNavType navType =[self getNavType];
    switch (navType) {
        case CMNavTypeNone:
            DDLog(@"没有navbar");
            self.navigationController.navigationBar.hidden =YES;
            break;
        case CMNavTypeOnlyTitle:
            DDLog(@"只有中间item有");
            self.navigationController.navigationBar.hidden =NO;
            [self customNavigationTitleView];

            break;
        case CMNavTypeNoRightItem:
            DDLog(@"右item没有");
            self.navigationController.navigationBar.hidden =NO;
            [self customNavigationLeftItem];
            [self customNavigationTitleView];

            break;
        case CMNavTypeAll:
            DDLog(@"左中右item都有");
            self.navigationController.navigationBar.hidden =NO;
            [self customNavigationTitleView];
            [self customNavigationRighItem];
            [self customNavigationLeftItem];
            break;
            
        default:
            DDLog(@"未知Nav状态");
            break;
    }
    
}
// 在合适的位置改变NavBar的颜色
//-(UIStatusBarStyle)preferredStatusBarStyle {
//    return UIStatusBarStyleDefault;
//}

//定制导航栏上的titleView
- (void)customNavigationTitleView
{
    NSString *titleStr =[self customNavigationTitleViewTitleStr];
    UILabel *label = [CMCustomViewFactory createLabel:CGRectMake(0, 5, 100, 34) title:titleStr color:[UIColor colorWithRed:30/255.0f green:160/255.0f blue:230/255.0f alpha:1] font:[UIFont systemFontOfSize:22] textAlignment:NSTextAlignmentCenter];
    self.navigationItem.titleView = label;
}

//定制导航栏左边的按钮
- (void)customNavigationLeftItem
{
    UIButton * leftButton = [CMCustomViewFactory  createButton:CGRectMake(0, 0, 60, 34) title:@"分类" backgourdImage:[UIImage imageNamed:@"buttonbar_action.png"]];
    [leftButton addTarget:self action:@selector(navigationLeftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
}

//定制导航栏右边的按钮
- (void)customNavigationRighItem
{
    NSString *titleStr =[self customNavigationRightItemTitle];
    
    UIButton * rightButton = [CMCustomViewFactory  createButton:CGRectMake(0, 0, 60, 34) title:titleStr backgourdImage:[UIImage imageNamed:@"buttonbar_action.png"]];
    [rightButton addTarget:self action:@selector(navigationRightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark - 子类重写

-(CMNavType)getNavType {
    return CMNavTypeNoRightItem;
}
-(NSString *)customNavigationRightItemTitle {
    return @"设置";
}

-(NSString *)customNavigationTitleViewTitleStr {
    return self.title;
}


- (void)navigationLeftButtonClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)navigationRightButtonClick:(id)sender
{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
