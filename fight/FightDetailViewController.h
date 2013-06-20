//
//  FightDetailViewController.h
//  fight
//
//  Created by Benjamin on 18/06/13.
//  Copyright (c) 2013 Benjamin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FightDetailViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UITextField *fighternumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *longitudeTextField;
@property (weak, nonatomic) IBOutlet UITextField *latitudeTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *dateFight;

@property (strong) NSManagedObject *fight;

- (IBAction)save:(id)sender;
- (IBAction)cancel:(id)sender;
@end
