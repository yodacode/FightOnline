//
//  RegisterViewController.m
//  fight
//
//  Created by fabien on 24/06/13.
//  Copyright (c) 2013 Benjamin. All rights reserved.
//

#import "RegisterViewController.h"
#import "AppDelegate.h"

@interface RegisterViewController (){
    NSManagedObjectContext *contextRegister;
}

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
    
    //Pour gerer le retour clavier
  
    [[self registerUserFirstNameField]setDelegate:self];
    [[self registerUserNameField]setDelegate:self];
    [[self registerUserEmailField]setDelegate:self];
    [[self registerUserPseudoField]setDelegate:self];
    [[self registerUserPassword1Field]setDelegate:self];
    [[self registerUserPassword2Field]setDelegate:self];

    AppDelegate * appDelegateRegister = [[UIApplication sharedApplication]delegate];
    contextRegister = [appDelegateRegister managedObjectContext];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)register:(id)sender {

    if([self.registerUserFirstNameField.text isEqualToString:@""] || [self.registerUserNameField.text isEqualToString:@""] || [self.registerUserPseudoField.text isEqualToString:@""] || [self.registerUserPassword1Field.text isEqualToString:@""] || [self.registerUserPassword2Field.text isEqualToString:@""] ){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erreur" message:@"Merci de bien vouloir remplir tous les champs" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else{
        if ([self.registerUserPassword1Field.text isEqualToString:self.registerUserPassword2Field.text]){
            //ici si le formulaire est validé
            
            NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"User" inManagedObjectContext:contextRegister];
            NSFetchRequest *request = [[NSFetchRequest alloc]init];
    
            [request setEntity:entityDesc];
           //(lastName like[cd] %@) AND
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userEmail like %@", self.registerUserEmailField.text];
            [request setPredicate:predicate];
            
            NSError *error;
            NSArray *matchingData = [contextRegister executeFetchRequest:request error:&error];
            
            //on ajoute un utilisateur si la requete n'aboutit à rien
            if(matchingData.count <=0){
                NSManagedObject *newUser = [[NSManagedObject alloc]initWithEntity:entityDesc insertIntoManagedObjectContext:contextRegister];

                [newUser setValue:self.registerUserFirstNameField.text forKey:@"userFirstName"];
                [newUser setValue:self.registerUserNameField.text forKey:@"userName"];
                [newUser setValue:self.registerUserPseudoField.text forKey:@"userPseudo"];
                [newUser setValue:self.registerUserEmailField.text forKey:@"userEmail"];
                [newUser setValue:self.registerUserPassword1Field.text forKey:@"userPassword"];
                
                [contextRegister save:&error];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Inscription" message:@"Utilisateur ajouté" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
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


- (IBAction)cancel:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}

@end
