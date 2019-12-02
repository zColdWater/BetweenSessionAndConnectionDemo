//
//  NSURLSession+HookSession.m
//  BetweenSessionAndConnectionDemo
//
//  Created by Yongpeng Zhu 朱永鹏 on 2019/12/2.
//  Copyright © 2019 Henry. All rights reserved.
//

#import "NSURLSession+HookSession.h"
#import <objc/runtime.h>

// 这里我们用运行时，hook住系统的ULRSession的两个便利构造器的初始化方法，然后利用NSURLConnection来进行一次网络请求，看下是否会走到下面两个交换方法的breakpoint上面来。

@implementation NSURLSession (HookSession)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originMethod = class_getClassMethod([NSURLSession class], @selector(sessionWithConfiguration:));
        Method swizzleMethod = class_getClassMethod([self class], @selector(swizzle_sessionWithConfiguration:));
        if (originMethod && swizzleMethod) {
            method_exchangeImplementations(originMethod, swizzleMethod);
        }
        originMethod = class_getClassMethod([NSURLSession class], @selector(sessionWithConfiguration:delegate:delegateQueue:));
        swizzleMethod = class_getClassMethod([self class], @selector(swizzle_sessionWithConfiguration:delegate:delegateQueue:));
        if (originMethod && swizzleMethod) {
            method_exchangeImplementations(originMethod, swizzleMethod);
        }
    });
}

+ (NSURLSession *)swizzle_sessionWithConfiguration:(NSURLSessionConfiguration *)configuration {
    NSURLSessionConfiguration *newConfiguration = configuration;
    if (!newConfiguration) {
        return nil;
    }
    return [self swizzle_sessionWithConfiguration:configuration];
}

+ (NSURLSession *)swizzle_sessionWithConfiguration:(NSURLSessionConfiguration *)configuration delegate:(id<NSURLSessionDelegate>)delegate delegateQueue:(NSOperationQueue *)queue {
    NSURLSessionConfiguration *newConfiguration = configuration;
    if (!newConfiguration) {
        return nil;
    }
    return [self swizzle_sessionWithConfiguration:configuration delegate:delegate delegateQueue:queue];
}

@end
