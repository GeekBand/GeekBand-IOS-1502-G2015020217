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
    self.navigationBar.tintColor = [UIColor whiteColor];

    UIFont* font = [UIFont systemFontOfSize:19];
    NSDictionary* textAttributes = @{NSFontAttributeName:font,
                                     NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationBar.titleTextAttributes = textAttributes;
    
    UIView *navigationline = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 0.5)];
    navigationline.backgroundColor = UIColorFromRGB(0xc76935);
    [self.view addSubview:navigationline];

    
    NSDictionary* barTextAttributes = @{NSFontAttributeName:[UIFont fontWithName:@"Arial-ItalicMT" size:18.0],
                                     NSForegroundColorAttributeName:[UIColor whiteColor]};
    [[UIBarButtonItem appearance] setTitleTextAttributes:barTextAttributes forState:UIControlStateNormal];
    
    
}

@end
