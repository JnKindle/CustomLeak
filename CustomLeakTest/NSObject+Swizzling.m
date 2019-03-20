//
//  NSObject+Swizzling.m
//  CustomLeakTest
//
//  Created by Jn on 2019/3/20.
//  Copyright © 2019年 DaiMaZhenYa. All rights reserved.
//

#import "NSObject+Swizzling.h"
#import <objc/runtime.h>

@implementation NSObject (Swizzling)

- (void)willDelloc
{
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        __strong typeof(self) strongSelf = weakSelf;
        NSLog(@"willDelloc --- %@",strongSelf);
    });
}

- (void)swizzleSEL:(SEL)originalSEL withSEL:(SEL)swizzlingSEL
{
    Class class = [self class];
    //class_getInstanceMethod 获取类的实例方法
    Method originalMethod = class_getInstanceMethod(class, originalSEL);
    Method swizzlingMethod = class_getInstanceMethod(class, swizzlingSEL);
    /*
    method_getImplementation 获取一个方法的IMP
    method_getTypeEncoding 获取一个方法的type encoding
    class_addMethod
     如果发现方法已经存在，则返回NO，也用来做为检查，这里是为了避免源方法没有实现的情况；
     如果方法没有存在，则先尝试添加被替换的方法的实现
     */
    BOOL success = class_addMethod(class, originalSEL, method_getImplementation(swizzlingMethod), method_getTypeEncoding(swizzlingMethod));
    if (success) {
        /*
         如果返回成功：则说明被替换方法没有存在，也就是被替换的方法没有被实现。
         我们需要先把这个方法实现，然后再执行我们想要的效果，用我们自定义的方法去替换被替换的方法。
         这里使用到的是class_replaceMethod这个方法。
         class_replaceMethod本身会尝试调用class_addMethod和method_setImplementation，所以直接调用class_replaceMethod就可以了)
         */
        class_replaceMethod(class, swizzlingSEL, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else {
        //如果返回失败：则说明被替换方法已经存在。直接将两个方法的实现交换，即 method_exchangeImplementations
        method_exchangeImplementations(originalMethod, swizzlingMethod);
    }
}



































@end
