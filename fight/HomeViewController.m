//
//  HomeViewController.m
//  fight
//
//  Created by Benjamin on 05/07/13.
//  Copyright (c) 2013 Benjamin. All rights reserved.
//

#import "HomeViewController.h"
#import "CurrentUser.h"

@interface HomeViewController ()
@end

@implementation HomeViewController
@synthesize isLoged;

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
    self.loginTextField.delegate = self;
    self.passwordTextField.delegate = self;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    if(self.isLoged){
        self.tabBarController.tabBar.hidden = NO;
        self.ContentLogin.hidden = YES;
        self.labelIntro.text = @"Vous êtes connecté";
    } else {
        self.tabBarController.tabBar.hidden = YES;
        self.ContentLogin.hidden = NO;
        self.labelIntro.text = @"Connectez vous";
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)loginButton:(id)sender {
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:entityDesc];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"email like %@ and password like %@", self.loginTextField.text, self.passwordTextField.text];
    [request setPredicate:predicate];
    
    NSError *error;
    NSArray *matchingData = [context executeFetchRequest:request error:&error];
    
    if(matchingData.count <=0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connexion" message:@"Il faut creer un compte" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connexion" message:@"Vous êtes connecté" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        CurrentUser *CU=[CurrentUser getInstance];
        CU.name= [matchingData valueForKey:@"name"];
        CU.email = [matchingData valueForKey:@"email"];
        CU.firstname = [matchingData valueForKey:@"firstname"];
        
        self.isLoged = YES;
        self.tabBarController.tabBar.hidden = NO;
        self.ContentLogin.hidden = YES;
        self.labelIntro.text = @"Vous êtes connecté";
    }
    
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


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}


@end
