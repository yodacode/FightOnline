//
//  FightDescriptionViewController.h
//  fight
//
//  Created by Benjamin on 19/06/13.
//  Copyright (c) 2013 Benjamin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FightDescriptionViewController : UIViewController
@property (strong) NSManagedObject *fight;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelAddress;
@property (weak, nonatomic) IBOutlet UILabel *labelFightersNumber;

@end
