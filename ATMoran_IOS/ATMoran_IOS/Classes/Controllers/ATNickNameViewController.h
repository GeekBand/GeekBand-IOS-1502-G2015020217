//
//  ATNickNameViewController.h
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/16.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import "ATBaseViewController.h"

@interface ATNickNameViewController : ATBaseViewController

@property (weak, nonatomic) IBOutlet UITextField *nickNameTextField;
@property (nonatomic, weak) NSString *nickName;

- (IBAction)doneButtonClicked:(id)sender;

@end
