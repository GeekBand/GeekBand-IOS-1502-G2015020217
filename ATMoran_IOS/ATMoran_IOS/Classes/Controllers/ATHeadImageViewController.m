//
//  ATHeadImageViewController.m
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/16.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import "ATHeadImageViewController.h"

@interface ATHeadImageViewController ()

@end

@implementation ATHeadImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.navigationController) {
        
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(backButtonClicked:)];
        
        backButton.tintColor = [UIColor whiteColor];
        self.navigationItem.leftBarButtonItem = backButton;
        
    }
    
    self.selectImageButton.layer.cornerRadius = 5.0;
    self.selectImageButton.clipsToBounds = YES;
}

- (void)backButtonClicked:(UIBarButtonItem *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
