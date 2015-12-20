//
//  ATHeadImageViewController.m
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/16.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import "ATHeadImageViewController.h"
#import "ATGlobal.h"
#import "ATReImageRequest.h"
#import "SVProgressHUD.h"
#import "GlobalTool.h"
@interface ATHeadImageViewController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate, UIActionSheetDelegate,ATReImageRequestDelegate>


@end

@implementation ATHeadImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.selectImageButton.layer.cornerRadius = 5.0;
    self.selectImageButton.clipsToBounds = YES;
    self.headImageView.image = self.headImage;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (IBAction)doneButtonClicked:(id)sender {
    
    if (self.headImage == [ATGlobal shareGlobal].user.image) {
        [SVProgressHUD showSuccessWithStatus:@"图片相同"];
    }else {
        [SVProgressHUD showWithStatus:@"提交中" maskType:SVProgressHUDMaskTypeClear];
        ATReImageRequest * request= [[ATReImageRequest alloc]init];
        [request sendReImageRequestWithImage:self.headImageView.image delegate:self];
    }
    
}

- (IBAction)selectImageButtonClicked:(id)sender {
    [self addActionSheet];
}

- (void)addActionSheet
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照", @"从手机相册选择", nil];
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    if (buttonIndex == 0) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            [self presentViewController:imagePicker animated:YES completion:nil];

        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"无法获取相机"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    } else if (buttonIndex == 1) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.delegate = self;
        imagePicker.navigationBar.barTintColor = UIColorFromRGB(0xee7f41);
        imagePicker.navigationBar.tintColor = [UIColor whiteColor];
        UIFont* font = [UIFont systemFontOfSize:19];
        NSDictionary* textAttributes = @{NSFontAttributeName:font,
                                         NSForegroundColorAttributeName:[UIColor whiteColor]};
        imagePicker.navigationBar.titleTextAttributes = textAttributes;
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
    
    
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.headImage = info[UIImagePickerControllerOriginalImage];
    self.headImageView.image = self.headImage;
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)reImageRequestSuccess:(ATReImageRequest *)request
{
    [ATGlobal shareGlobal].user.image = self.headImageView.image;
    [SVProgressHUD showSuccessWithStatus:@"成功"];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)reImageRequestfail:(ATReImageRequest *)request error:(NSError *)error
{
    NSString *errorString = [NSString stringWithFormat:@"更新失败:%@",error];
    [SVProgressHUD showErrorWithStatus:errorString];
    
}



@end
