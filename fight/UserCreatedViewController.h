//
//  UserCreatedViewController.h
//  fight
//
//  Created by Benjamin on 02/07/13.
//  Copyright (c) 2013 Benjamin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserCreatedViewController : UITableViewController
@property (strong) NSManagedObject *user;
@property (strong) NSMutableArray *fights;
@end
