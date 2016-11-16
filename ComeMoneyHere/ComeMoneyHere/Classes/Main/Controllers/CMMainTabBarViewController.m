//
//  CMMainTabBarViewController.m
//  ComeMoneyHere
//
//  Created by 李保东 on 16/11/15.
//  Copyright © 2016年 DaviD. All rights reserved.
//

#import "CMMainTabBarViewController.h"
#import "CMNavViewController.h"
#import "CMHomeViewController.h"
#import "CMCommondViewController.h"
#import "CMMeViewController.h"

@interface CMMainTabBarViewController ()

@property(nonatomic,strong)CMHomeViewController *homeVC;

@property(nonatomic,strong)CMCommondViewController *commondVC;

@property(nonatomic,strong)CMMeViewController *meVC;

@end

@implementation CMMainTabBarViewController

#pragma mark - Init
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupTabBarBackground];
    
    [self setupAllChildViewControllers];

    // Do any additional setup after loading the view.
}

#pragma mark - Private Methods

-(void)setupTabBarBackground {
    
    self.tabBar.accessibilityIdentifier = @"tabbar";
    self.tabBar.backgroundImage = [[UIImage imageNamed:@"tabbarBackground"] stretchableImageWithLeftCapWidth:25 topCapHeight:25];
    self.tabBar.selectionIndicatorImage = [[UIImage imageNamed:@"tabbarSelectBg"] stretchableImageWithLeftCapWidth:25 topCapHeight:25];
}

/**
 *  初始化所有的子控制器
 */
- (void)setupAllChildViewControllers
{
    // 1.首页
    [self setupChildViewController:self.homeVC title:@"首页" imageName:@"tabbar_chats" selectedImageName:@"tabbar_chatsHL"];
    
    // 2.推广
    [self setupChildViewController:self.commondVC title:@"推广" imageName:@"tabbar_contacts" selectedImageName:@"tabbar_contactsHL"];
    
    // 3.我的
    [self setupChildViewController:self.meVC title:@"我的" imageName:@"tabbar_setting" selectedImageName:@"tabbar_settingHL"];
    
}

/**
 *  初始化一个子控制器
 
 */
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 1.设置控制器的属性
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 2.包装一个导航控制器
    CMNavViewController *nav = [[CMNavViewController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}
#pragma mark - Setter & Getter
-(CMHomeViewController *)homeVC {
    if (!_homeVC) {
        _homeVC =[[CMHomeViewController alloc]init];
    }
    return _homeVC;
}
-(CMCommondViewController *)commondVC {
    if (!_commondVC) {
        _commondVC =[[CMCommondViewController alloc]init];
    }
    return _commondVC;
}
-(CMMeViewController *)meVC {
    if (!_meVC) {
        _meVC =[[CMMeViewController alloc]init];
    }
    return _meVC;
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
