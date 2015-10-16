//
//  ATNickNameViewController.m
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/16.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import "ATNickNameViewController.h"

@implementation ATNickNameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.navigationController) {
        
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(backButtonClicked:)];
        
        backButton.tintColor = [UIColor whiteColor];
        self.navigationItem.leftBarButtonItem = backButton;

    }
    
    
}


- (void)backButtonClicked:(UIBarButtonItem *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
