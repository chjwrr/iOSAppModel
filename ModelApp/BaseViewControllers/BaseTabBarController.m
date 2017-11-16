//
//  BaseTabBarController.m
//  ModelProduct
//
//  Created by Mac on 2017/9/29.
//  Copyright © 2017年 chj. All rights reserved.
//

#import "BaseTabBarController.h"

#import "BaseNavigationController.h"
#import "HomeViewController.h"
#import "SecondViewController.h"

#import "TabBarView.h"

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 隐藏状态栏
    self.tabBar.hidden = YES;

    [self addChildVCtrl];
    
    
    NSLog(@"%@",self.view);
    
}
- (void)addChildVCtrl {

    
    HomeViewController *vc1 = [[HomeViewController alloc]init];
    BaseNavigationController *homeNav = [[BaseNavigationController alloc]initWithRootViewController:vc1];
    
    SecondViewController *vc2 = [[SecondViewController alloc]init];
    BaseNavigationController *secondNav = [[BaseNavigationController alloc]initWithRootViewController:vc2];
    
    self.viewControllers = @[homeNav,secondNav];
    
    
    [self addTabbarView];
    
}

- (void)addTabbarView {
    TabBarView *tabBarView=[[TabBarView alloc]init];
    tabBarView.tag = kTBABARVIEW_TAG;
    [self.view addSubview:tabBarView];
    tabBarView.frame = CGRectMake(0, kSCREEN_HEIGHT - kTABBAR_HEIGHT, kSCREEN_WIDTH, kTABBAR_HEIGHT);

}


- (UIImage *)imageFromColor:(UIColor *)color andFrame:(CGRect)frame{
    
    CGRect rect = frame;
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
