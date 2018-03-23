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
#import "CMSendTaskViewController.h"

#import "CMCustomTabBar.h"

@interface CMMainTabBarViewController ()<CMCustomTabBarDelegate>

@property(nonatomic,strong)CMHomeViewController *homeVC;

@property(nonatomic,strong)CMSendTaskViewController *sendTaskVC;

@property(nonatomic,strong)CMCommondViewController *commondVC;

@property(nonatomic,strong)CMMeViewController *meVC;

@property(nonatomic,strong)CMCustomTabBar *customTabBar;

@end

@implementation CMMainTabBarViewController

#pragma mark - Init
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupCustomTabBar];
    
    [self setupAllChildViewControllers];

    // Do any additional setup after loading the view.
}

// iOS11之后下面这种方式不管用了，因为一旦切换界面就会有系统tabBar的再次刷新显示
//-(void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    for (UIView *child in self.tabBar.subviews) {
//        if ([child isKindOfClass:[UIControl class]]) {
//            [child removeFromSuperview];
//        }
//    }
//}

#pragma mark - Private Methods


-(void)setupCustomTabBar {
    CMCustomTabBar *customTabBar =[[CMCustomTabBar alloc]init];
    
    //    CGFloat tabBarHeight =84 *kAppScale;
#warning 此处更改的高度后在CMCustomTabBar.m中的#warning此处更改也要改一下
    CGFloat tabBarHeight =49.0;
    customTabBar.frame =CGRectMake(0, 49.0 -tabBarHeight, SCREEN_WIDTH, tabBarHeight);
    //    [self.tabBar addSubview:customTabBar];
    self.customTabBar =customTabBar;
    self.customTabBar.delegate =self;
    // 下面这句话相当于把它加到系统tabBar上，有个好处是因为系统tabBar属性是readonly，但可以通过KVC方式去更改，且在iOS11之后必须以覆盖形式放到tabBar上面
    [self setValue:self.customTabBar forKeyPath:@"tabBar"];
    
    
}

/**
 *  初始化所有的子控制器
 */
- (void)setupAllChildViewControllers
{
    // 1.首页
    [self setupChildViewController:self.homeVC title:@"首页" imageName:@"tabbar_setting" selectedImageName:@"tabbar_settingHL" andIndex:0];
    
    // 2.发布任务
    [self setupChildViewController:self.sendTaskVC title:@"聊天" imageName:@"tabbar_chats" selectedImageName:@"tabbar_chatsHL" andIndex:1];
    
    // 3.推荐码
    [self setupChildViewController:self.commondVC title:@"联系人" imageName:@"tabbar_contacts" selectedImageName:@"tabbar_contactsHL" andIndex:2];
    
    // 4.用户信息
    [self setupChildViewController:self.meVC title:@"设置" imageName:@"tabbar_setting" selectedImageName:@"tabbar_settingHL" andIndex:3];
    
}

/**
 *  初始化一个子控制器
 
 */
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName andIndex:(NSInteger)index
{
    // 1.设置控制器的属性
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];

    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 2.包装一个导航控制器
    CMNavViewController *nav = [[CMNavViewController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
    
    // 自定义TabBar的SubViews
    [self.customTabBar creatAllTabBarSubViews:childVc.tabBarItem andIndex:index];
    
    
}
#pragma mark - CMCustomTabBarDelegate

-(void)tabBar:(CMCustomTabBar *)tabBar didSelectVC:(NSInteger)lastIndex andNext:(NSInteger)nextIndex {
    self.selectedIndex =nextIndex -kTabBarButtonBaseTag;
}

#pragma mark - Setter & Getter
-(CMHomeViewController *)homeVC {
    if (!_homeVC) {
        _homeVC =[[CMHomeViewController alloc]init];
    }
    return _homeVC;
}
-(CMSendTaskViewController *)sendTaskVC {
    if (!_sendTaskVC) {
        _sendTaskVC =[[CMSendTaskViewController alloc]init];
    }
    return _sendTaskVC;
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


@end
