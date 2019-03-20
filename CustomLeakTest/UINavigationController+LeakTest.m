//
//  UINavigationController+LeakTest.m
//  CustomLeakTest
//
//  Created by Jn on 2019/3/20.
//  Copyright © 2019年 DaiMaZhenYa. All rights reserved.
//

#import "UINavigationController+LeakTest.h"
#import <objc/runtime.h>
#import "NSObject+Swizzling.h"


@implementation UINavigationController (LeakTest)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleSEL:@selector(popViewControllerAnimated:) withSEL:@selector(jn_popViewControllerAnimated:)];
    });
}

- (UIViewController *)jn_popViewControllerAnimated:(BOOL)animated
{
    UIViewController *popVC = [self jn_popViewControllerAnimated:animated];
    extern const char *VCFLAG;
    objc_setAssociatedObject(popVC, VCFLAG, @(YES), OBJC_ASSOCIATION_ASSIGN);
    return popVC;
}

@end
