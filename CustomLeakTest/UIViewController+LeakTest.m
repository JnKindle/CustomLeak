//
//  UIViewController+LeakTest.m
//  CustomLeakTest
//
//  Created by Jn on 2019/3/20.
//  Copyright © 2019年 DaiMaZhenYa. All rights reserved.
//

#import "UIViewController+LeakTest.h"
#import <objc/runtime.h>
#import "NSObject+Swizzling.h"

const char *VCFLAG = "VCFLAG";

@implementation UIViewController (LeakTest)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleSEL:@selector(viewWillAppear:) withSEL:@selector(jn_viewWillAppear:)];
        [self swizzleSEL:@selector(viewDidDisappear:) withSEL:@selector(jn_viewDidDisappear:)];
    });
}

- (void)jn_viewWillAppear:(BOOL)animated
{
    [self jn_viewWillAppear:animated];
    objc_setAssociatedObject(self, VCFLAG, @(NO), OBJC_ASSOCIATION_ASSIGN);
    
}

-(void)jn_viewDidDisappear:(BOOL)animated
{
    [self jn_viewDidDisappear:animated];
    if ([objc_getAssociatedObject(self, VCFLAG) boolValue]) {
        [self willDelloc];
    }
}

@end
