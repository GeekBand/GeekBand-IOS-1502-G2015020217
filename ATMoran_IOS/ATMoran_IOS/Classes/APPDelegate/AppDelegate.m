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

    [self loadLoginView];
 
//    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
//    self.window.rootViewController = [mainStoryboard instantiateInitialViewController];
    
    
    return YES;
}

- (void)loadLoginView
{
    UIStoryboard *loginStoryboard = [UIStoryboard storyboardWithName:@"ATLoginAndRegister" bundle:[NSBundle mainBundle]];
    self.loginViewController = [loginStoryboard instantiateInitialViewController];
    self.window.rootViewController = self.loginViewController;
    
}

- (void)loadMainViewWithController:(UIViewController *)controller
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UITabBarController *tabBarController = [mainStoryboard instantiateInitialViewController];
    
    [controller presentViewController:tabBarController animated:YES completion:nil];
    
    self.loginViewController = nil;
    
//    [UIView animateWithDuration:0.3
//                     animations:^{
//                         self.loginViewController.view.alpha = 0;
//                     }
//                     completion:^(BOOL finished){
//                         
//                     }];
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
