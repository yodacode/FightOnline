//
//  UserViewController.h
//  fight
//
//  Created by Benjamin on 01/07/13.
//  Copyright (c) 2013 Benjamin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserViewController : UITableViewController<UITextFieldDelegate>
@property (strong) NSManagedObject *user;
@property (strong) NSManagedObject *fights;
@property (strong) NSMutableArray *fightsAttending;
@property (weak, nonatomic) IBOutlet UITextView *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (strong) NSMutableArray *fightsCreated;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *organisedLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdLabel;
@end
