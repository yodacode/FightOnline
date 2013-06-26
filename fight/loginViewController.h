//
//  loginViewController.h
//  fight
//
//  Created by fabien on 24/06/13.
//  Copyright (c) 2013 Benjamin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface loginViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *loginUserTextField;
@property (weak, nonatomic) IBOutlet UITextField *loginPasswordTextField;
@property (weak, nonatomic) IBOutlet UILabel *loginLabel;


- (IBAction)logInButton:(id)sender;
- (IBAction)goToRegister:(id)sender;
- (IBAction)facebookLogin:(id)sender;





@end
