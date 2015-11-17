//
//  ATBaseViewController.m
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/14.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import "ATBaseViewController.h"
#import "GlobalTool.h"

@interface ATBaseViewController ()

@end

@implementation ATBaseViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    UIView *navigationline = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 0.5)];
    navigationline.backgroundColor = UIColorFromRGB(0xc76935);
    [self.view addSubview:navigationline];

    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] init];
    backBarButton.title = @"返回";
    [self.navigationItem setBackBarButtonItem:backBarButton];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
