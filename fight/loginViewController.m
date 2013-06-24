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
    
    
    //pour le retout clavier
    [[self loginUserTextField]setDelegate:self];
    [[self loginPasswordTextField]setDelegate:self];
    
    AppDelegate * appDelegate = [[UIApplication sharedApplication]delegate];
    context = [appDelegate managedObjectContext];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logInButton:(id)sender {
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:entityDesc];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userName like %@ and userPassword like %@", self.loginUserTextField.text, self.loginPasswordTextField.text];
    [request setPredicate:predicate];
    
    NSError *error;
    NSArray *matchingData = [context executeFetchRequest:request error:&error];
    
    if(matchingData.count <=0){
        self.loginLabel.text = @"il faut creer un compte connard";
    }else{
        self.loginLabel.text = @"Braovo mousaillon ! ";
        [self performSegueWithIdentifier:@"figths" sender:self];
    }

}

- (IBAction)signUpButton:(id)sender {
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
    NSManagedObject *newUser = [[NSManagedObject alloc]initWithEntity:entityDesc insertIntoManagedObjectContext:context];
    
    [newUser setValue:self.loginUserTextField.text forKey:@"userName"];
    [newUser setValue:self.loginPasswordTextField.text forKey:@"userPassword"];
    
    NSError *error;
    [context save:&error];
    self.loginLabel.text = @"Utilisateur ajouté !";
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}
@end

