//
//  ATNickNameViewController.m
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/16.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import "ATNickNameViewController.h"
#import "ATRenameRequest.h"
#import "ATGlobal.h"
#import "SVProgressHUD.h"

@interface ATNickNameViewController () <ATRenameRequestDelegate>


@end

@implementation ATNickNameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.nickNameTextField.text =  self.nickName;
    
//    [self.doneButton.titleLabel setFont:[UIFont fontWithName:@"Arial-ItalicMT" size:18.0]];
    
}

- (IBAction)doneButtonClicked:(id)sender
{
    ATRenameRequest *reNameRequest=[[ATRenameRequest alloc]init];
    [reNameRequest sendReNameRequestWithName:self.nickNameTextField.text delegate:self];
    [SVProgressHUD show];
}

-(void) renameRequestSuccess:(ATRenameRequest *)request{
    [SVProgressHUD showSuccessWithStatus:@"更新成功"];
    [ATGlobal shareGlobal].user.username = self.nickNameTextField.text;
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)renameRequestfail:(ATRenameRequest *)request error:(NSError *)error{
    NSString *errorString = [NSString stringWithFormat:@"更新失败:%@",error];
    [SVProgressHUD showErrorWithStatus:errorString];
}


@end
