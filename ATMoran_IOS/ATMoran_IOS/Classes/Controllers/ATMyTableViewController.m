//
//  ATMyTableViewController.m
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/14.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import "ATMyTableViewController.h"
#import "ATGlobal.h"
#import "ATHeadImageViewController.h"
#import "ATNickNameViewController.h"


@interface ATMyTableViewController ()

@end

@implementation ATMyTableViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.nickNameLabel.text = [ATGlobal shareGlobal].user.username;
    [self.headImageButton setBackgroundImage:[ATGlobal shareGlobal].user.image forState:UIControlStateNormal];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.headImageButton.layer.cornerRadius = self.headImageButton.frame.size.width / 2.0;
    self.headImageButton.clipsToBounds = YES;
    self.emailLabel.text = [ATGlobal shareGlobal].user.email;
    
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
                [ATGlobal shareGlobal].user=nil;
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
        nickNameVC.nickName = [ATGlobal shareGlobal].user.username;
    } else if ([segue.identifier isEqualToString:@"settingHeadImage"] || [segue.identifier isEqualToString:@"settingHeadImage_btn"]) {
        ATHeadImageViewController *headImageVC = segue.destinationViewController;
        headImageVC.headImage = [ATGlobal shareGlobal].user.image;
    }
}





@end
