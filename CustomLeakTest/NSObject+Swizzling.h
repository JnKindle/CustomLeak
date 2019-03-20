//
//  NSObject+Swizzling.h
//  CustomLeakTest
//
//  Created by Jn on 2019/3/20.
//  Copyright © 2019年 DaiMaZhenYa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Swizzling)

- (void)willDelloc;
- (void)swizzleSEL:(SEL)originalSEL withSEL:(SEL)swizzlingSEL;

@end
