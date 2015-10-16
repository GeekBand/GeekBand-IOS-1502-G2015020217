//
//  ATMyTableViewController.m
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/14.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import "ATMyTableViewController.h"

@interface ATMyTableViewController ()

@end

@implementation ATMyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   

    self.headImageButton.layer.cornerRadius = self.headImageButton.frame.size.width / 2.0;
    self.headImageButton.clipsToBounds = YES;
    
    self.tableView.scrollEnabled = NO;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 13;
    }
    return 10;
}
@end
