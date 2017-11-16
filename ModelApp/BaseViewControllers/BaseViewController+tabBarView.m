//
//  BaseViewController+deveceName.m
//  ModelProduct
//
//  Created by apple on 16/11/8.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "BaseViewController+tabBarView.h"
#import "TabBarView.h"
@implementation BaseViewController (tabBarView)

- (void)showTabBarViewWithAnimal {
    
    UIView *tabbarView = [self tabBarView];
    
    [UIView animateWithDuration:0.25 animations:^{
        tabbarView.frame = CGRectMake(0, kSCREEN_HEIGHT, kSCREEN_WIDTH, kTABBAR_HEIGHT);
    } completion:^(BOOL finished) {
        if (finished) {
            
        }
    }];
    
}


- (void)hiddenTabBarViewWithAnimal {
    UIView *tabbarView = [self tabBarView];
    [UIView animateWithDuration:0.25 animations:^{
        tabbarView.frame = CGRectMake(0, kSCREEN_HEIGHT - kTABBAR_HEIGHT, kSCREEN_WIDTH, kTABBAR_HEIGHT);
    } completion:^(BOOL finished) {
        if (finished) {
            
        }
    }];
}


/**
 获取tabbarView

 @return 返回tabbarView
 */
- (UIView *)tabBarView {
    
    TabBarView *tabbarView = (TabBarView *)[self.tabBarController.view viewWithTag:kTBABARVIEW_TAG];

    return tabbarView;
}

@end
