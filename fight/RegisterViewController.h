//
//  RegisterViewController.h
//  fight
//
//  Created by fabien on 24/06/13.
//  Copyright (c) 2013 Benjamin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *registerUserFirstNameField;
@property (weak, nonatomic) IBOutlet UITextField *registerUserNameField;
@property (weak, nonatomic) IBOutlet UITextField *registerUserPseudoField;
@property (weak, nonatomic) IBOutlet UITextField *registerUserEmailField;
@property (weak, nonatomic) IBOutlet UITextField *registerUserPassword1Field;
@property (weak, nonatomic) IBOutlet UITextField *registerUserPassword2Field;



- (IBAction)register:(id)sender;
-(IBAction)cancel:(id)sender;


@end
