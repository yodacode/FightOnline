//
//  RegisterViewController.m
//  fight
//
//  Created by Benjamin on 05/07/13.
//  Copyright (c) 2013 Benjamin. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

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
	// Do any additional setup after loading the view.
    self.nameTextFiled.delegate = self;
    self.firstnameTextField.delegate = self;
    self.emailTextField.delegate = self;
    self.ageTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.confirmPasswordTextField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (IBAction)buttonRegister:(id)sender {
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if([self.nameTextFiled.text isEqualToString:@""] || [self.firstnameTextField.text isEqualToString:@""] || [self.emailTextField.text isEqualToString:@""] || [self.passwordTextField.text isEqualToString:@""] || [self.confirmPasswordTextField.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erreur" message:@"Merci de bien vouloir remplir tous les champs" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else{
        if ([self.passwordTextField.text isEqualToString:self.confirmPasswordTextField.text]){
            //ici si le formulaire est validé
            
            NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
            NSFetchRequest *request = [[NSFetchRequest alloc]init];
            
            [request setEntity:entityDesc];
            //(lastName like[cd] %@) AND
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"email like %@", self.emailTextField.text];
            [request setPredicate:predicate];
            
            NSError *error;
            NSArray *matchingData = [context executeFetchRequest:request error:&error];
            
            //on ajoute un utilisateur si la requete n'aboutit à rien
            if(matchingData.count <=0){
                NSManagedObject *newUser = [[NSManagedObject alloc]initWithEntity:entityDesc insertIntoManagedObjectContext:context];
                
                [newUser setValue:self.firstnameTextField.text forKey:@"firstname"];
                [newUser setValue:self.nameTextFiled.text forKey:@"name"];
                [newUser setValue:self.emailTextField.text forKey:@"email"];
                [newUser setValue:self.passwordTextField.text forKey:@"password"];
                
                [context save:&error];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Inscription" message:@"Utilisateur ajouté" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [self performSegueWithIdentifier: @"Login" sender: self];
                [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erreur" message:@"Cet utilisateur existe deja" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                
            }
            
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erreur" message:@"Veuillez resaisir le mot de passe" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
        }
    }
    
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}
@end
