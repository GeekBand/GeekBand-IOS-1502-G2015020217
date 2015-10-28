//
//  ATMyTableViewController.m
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/14.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import "ATMyTableViewController.h"
#import "AppDelegate.h"
#import "ATGlobal.h"
#import "ATHeadImageViewController.h"
#import "ATNickNameViewController.h"


@interface ATMyTableViewController ()

@end

@implementation ATMyTableViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.nickNameLabel.text = [ATGlobal shareGloabl].user.username;
    
    [self.headImageButton setBackgroundImage:[ATGlobal shareGloabl].user.image forState:UIControlStateNormal];
    [self.headImageButton setImage:[ATGlobal shareGloabl].user.image forState:UIControlStateHighlighted];
    
    self.emailLabel.text = [ATGlobal shareGloabl].user.email;
    
}

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 2) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"确定注销吗？" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *enterAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                [self dismissViewControllerAnimated:YES completion:nil];
                [ATGlobal shareGloabl].user=nil;
                AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                [appDelegate loadLoginView];
            }];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:enterAction];
            [alert addAction:cancelAction];
            [self presentViewController:alert animated:true completion:nil];
            
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Storyboard segue methods
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"settingNickName"]) {
        ATNickNameViewController *nickNameVC = segue.destinationViewController;
        nickNameVC.nickName = [ATGlobal shareGloabl].user.username;
    } else if ([segue.identifier isEqualToString:@"settingHeadImage"] || [segue.identifier isEqualToString:@"settingHeadImage_btn"]) {
        ATHeadImageViewController *headImageVC = segue.destinationViewController;
        headImageVC.headImage = [ATGlobal shareGloabl].user.image;
    }
}





@end
