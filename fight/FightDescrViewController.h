//
//  FightDescrViewController.h
//  fight
//
//  Created by Benjamin on 02/07/13.
//  Copyright (c) 2013 Benjamin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FightDescrViewController : UITableViewController
@property (strong) NSManagedObject *fight;
@property (strong) NSManagedObject *user;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelAddress;
@property (weak, nonatomic) IBOutlet UILabel *labelDateFight;
@property (weak, nonatomic) IBOutlet UILabel *labelFightersNumber;
@property (weak, nonatomic) IBOutlet UILabel *labelFightersAttending;
- (IBAction)participate:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonParticipate;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellParticipate;

@property (weak, nonatomic) IBOutlet UITableViewCell *labelDispo;
@end
