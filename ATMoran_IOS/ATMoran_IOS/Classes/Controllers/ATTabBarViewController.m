//
//  ATTabBarViewController.m
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/14.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import "ATTabBarViewController.h"
#import "GlobalTool.h"
#import "ATPublishViewController.h"

@interface ATTabBarViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong)UIImagePickerController *pickerController;

@end

@implementation ATTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0xee7f41)}
                                             forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0xa8a8a9)}
                                             forState:UIControlStateNormal];
    
//    UIEdgeInsets insets = UIEdgeInsetsMake(6, 0, -6, 0);
    
    NSArray *tabBarItems = self.tabBar.items;
    UITabBarItem *squareTabBarItem = [tabBarItems objectAtIndex:0];
    UIImage *selectedImg = [UIImage imageNamed:@"square_selected"];
    
    [squareTabBarItem setTitle:@"广场"];
    [squareTabBarItem setImage:[UIImage imageNamed:@"square"]];
    [squareTabBarItem setSelectedImage:[selectedImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//    squareTabBarItem.imageInsets = insets;
    squareTabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);
    
    UITabBarItem *myTabBarItem = [tabBarItems objectAtIndex:1];
    selectedImg = [UIImage imageNamed:@"my_selected"];
    
    [myTabBarItem setTitle:@"我的"];
    [myTabBarItem setImage:[UIImage imageNamed:@"my"]];
    [myTabBarItem setSelectedImage:[selectedImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    myTabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);


    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    CGFloat radius = 22.5;
    UIButton *photoButton = [[UIButton alloc]initWithFrame:CGRectMake(width/2-radius, height-49-radius, radius*2, radius*2)];
    photoButton.layer.cornerRadius = radius;
    photoButton.clipsToBounds = YES;
    [photoButton setImage:[UIImage imageNamed:@"publish"] forState:UIControlStateNormal];
    [photoButton setImage:[UIImage imageNamed:@"publish_hover"] forState:UIControlStateHighlighted];
    [photoButton addTarget:self action:@selector(addOrderView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:photoButton];

//    [self.tabBar insertSubview:photoButton aboveSubview:(UIView *)self.tabBar.backgroundImage];

//    [self.tabBar.superview bringSubviewToFront:photoButton];
    
//    self.view.backgroundColor = [UIColor greenColor];
    

//    [[[UIApplication sharedApplication] keyWindow] addSubview:photoButton];

//    NSArray* windows = [UIApplication sharedApplication].windows;
//    UIWindow *window = [windows objectAtIndex:0];
//    
//    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//    UIGraphicsBeginImageContext(rect.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
//    CGContextFillRect(context, rect);
//    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    [self.tabBar setBackgroundImage:img];
//    [self.tabBar setShadowImage:img];
    
//    [self.tabBar setShadowImage:[[UIImage alloc] ini]];
//    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
//    self.tabBar.clipsToBounds = YES;
     //    [self.view bringSubviewToFront:photoButton];
    
}

- (void)addOrderView
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    [sheet showInView:self.tabBarController.view];
}

#pragma mark ----UIActionSheet delegate method

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    self.pickerController = [[UIImagePickerController alloc]init];;
    if (buttonIndex == 0) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            self.pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            self.pickerController.allowsEditing = YES;
            self.pickerController.delegate = self;
            [self presentViewController:self.pickerController animated:YES completion:nil];
            
        }else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误" message:@"无法获取照相机" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
            [alert show];
            return;
        }
    }else if(buttonIndex == 1){
        self.pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        self.pickerController.delegate = self;
        [self presentViewController:self.pickerController animated:YES completion:nil];
    }
    
    
}

#pragma mark -----UIImagePickerController delegate method
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    CGSize imagesize = image.size;
    imagesize.height = 626;
    imagesize.width = 413;
    image = [self imageWithImage:image scaledToSize:imagesize];
 
    if (self.pickerController.sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ATPublishViewController *pulish =  [story instantiateViewControllerWithIdentifier:@"ATPublishViewController"];
        pulish.publishPhoto = image;
        [picker pushViewController:pulish animated:YES];
    }else{
//        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        GBMPublishViewController *pulish =  [story instantiateViewControllerWithIdentifier:@"CMJ"];
//        UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:pulish];
//        pulish.tag = 1;
//        [picker presentViewController:navigationController animated:YES completion:nil];
    }
    
    
    
    
}


//对图片尺寸进行压缩
-(UIImage *)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize{
    
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end
