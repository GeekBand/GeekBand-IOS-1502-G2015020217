//
//  ATHomePageViewController.m
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/17.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import "ATHomePageViewController.h"

@interface ATHomePageViewController ()

@end

@implementation ATHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showHomePage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)showHomePage
{
    NSString *urlString = @"http://geekband.com";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

@end
