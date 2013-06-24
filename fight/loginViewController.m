//
//  loginViewController.m
//  fight
//
//  Created by fabien on 24/06/13.
//  Copyright (c) 2013 Benjamin. All rights reserved.
//

#import "loginViewController.h"
#import "AppDelegate.h"

@interface loginViewController (){
    NSManagedObjectContext *context;
}

@end

@implementation loginViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    AppDelegate * appDelegate = [[UIApplication sharedApplication]delegate];
    context = [appDelegate managedObjectContext];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logInButton:(id)sender {
   
}

- (IBAction)signUpButton:(id)sender {
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
    NSManagedObject *newUser = [[NSManagedObject alloc]initWithEntity:entityDesc insertIntoManagedObjectContext:context];
    
    [newUser setValue:self.loginUserTextField.text forKey:@"userName"];
    [newUser setValue:self.loginUserTextField.text forKey:@"passWord"];
    
    NSError *error;
    [context save:&error];
    self.loginLabel.text = @"Utilisateur ajouté !";
}
@end
