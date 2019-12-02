//
//  main.m
//  BetweenSessionAndConnectionDemo
//
//  Created by Yongpeng Zhu 朱永鹏 on 2019/12/2.
//  Copyright © 2019 Henry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
