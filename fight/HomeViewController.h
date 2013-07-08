//
//  HomeViewController.h
//  fight
//
//  Created by Benjamin on 05/07/13.
//  Copyright (c) 2013 Benjamin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *loginTextField;
@property (weak, nonatomic) IBOutlet UILabel *labelIntro;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIView *ContentLogin;
@property (nonatomic) BOOL isLoged;
- (IBAction)loginButton:(id)sender;
@end
