//
//  AppDelegate.m
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/13.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import "AppDelegate.h"
@interface AppDelegate ()

@property (nonatomic,strong)UITabBarController *tabBarController;


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
//    UIStoryboard *loginStoryboard = [UIStoryboard storyboardWithName:@"ATLoginAndRegister" bundle:[NSBundle mainBundle]];
//    self.window.rootViewController = [loginStoryboard instantiateInitialViewController];
    
//    UIStoryboard *myStroyboard = [UIStoryboard storyboardWithName:@"ATMy" bundle:[NSBundle mainBundle]];
//    self.window.rootViewController = [myStroyboard instantiateViewControllerWithIdentifier:@"ATMyTableViewController"];
//
    
    
//    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"ATMy" bundle:[NSBundle mainBundle]];
//    self.tabBarController = [mainStoryboard instantiateInitialViewController];
//    self.window.rootViewController = self.tabBarController;

    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    self.window.rootViewController = [mainStoryboard instantiateInitialViewController];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
   
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
   
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
   
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

@end
