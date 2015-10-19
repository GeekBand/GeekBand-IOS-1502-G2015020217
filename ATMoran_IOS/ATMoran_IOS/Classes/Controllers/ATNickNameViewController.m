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
@interface ATNickNameViewController () <ATRenameRequestDelegate>


@end

@implementation ATNickNameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.nickNameTextField.text =  self.nickName;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



- (IBAction)DoneButtonClicked:(id)sender
{
    ATRenameRequest *reNameRequest=[[ATRenameRequest alloc]init];
    [reNameRequest sendReNameRequestWithName:self.nickNameTextField.text delegate:self];
}

-(void) renameRequestSuccess:(ATRenameRequest *)request{
    [ATGlobal shareGloabl].user.username = self.nickNameTextField.text;
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)renameRequestfail:(ATRenameRequest *)request error:(NSError *)error{
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
