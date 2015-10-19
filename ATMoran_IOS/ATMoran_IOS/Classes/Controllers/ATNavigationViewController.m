//
//  ATNavigationViewController.m
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/15.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import "ATNavigationViewController.h"
#import "GlobalTool.h"

@implementation ATNavigationViewController

- (void)viewDidLoad
{

    self.navigationBar.barTintColor = UIColorFromRGB(0xee7f41);
    
    UIView *navigationline = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 0.5)];
    navigationline.backgroundColor = UIColorFromRGB(0xc76935);
    [self.view addSubview:navigationline];
    
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:UIColorFromRGB(0xffffff)};
    
    
}

@end
