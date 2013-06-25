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
    NSManagedObjectContext *context;
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

    AppDelegate * appDelegate = [[UIApplication sharedApplication]delegate];
    context = [appDelegate managedObjectContext];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)register:(id)sender {
    if([self.registerUserPassword2Field.text isEqualToString:@""]){
    
    }else{
        
    }
    
//    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
//    NSManagedObject *newUser = [[NSManagedObject alloc]initWithEntity:entityDesc insertIntoManagedObjectContext:context];
//    NSFetchRequest *request = [[NSFetchRequest alloc]init];
//    
//    //Pour verifier si l'utilisateur existe deja
//    [request setEntity:entityDesc];
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userName like %@ ", self.loginUserTextField.text];
//    [request setPredicate:predicate];
//    
//    NSError *error;
//    NSArray *matchingData = [context executeFetchRequest:request error:&error];
//    
//    //on ajoute un utilisateur si la requete n'aboutit à rien
//    if(matchingData.count <=0){
//        [newUser setValue:self.loginUserTextField.text forKey:@"userName"];
//        [newUser setValue:self.loginPasswordTextField.text forKey:@"userPassword"];
//        [context save:&error];
//        self.loginLabel.text = @"Utilisateur ajouté !";
//    }else{
//        self.loginLabel.text = @"cet utilisateur exite deja";
//    }
}


- (IBAction)cancel:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}

@end
