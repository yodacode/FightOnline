//
//  UserViewController.h
//  fight
//
//  Created by Benjamin on 01/07/13.
//  Copyright (c) 2013 Benjamin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserViewController : UITableViewController
@property (strong) NSManagedObject *user;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@end
