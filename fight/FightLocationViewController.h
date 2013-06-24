//
//  FightLocationViewController.h
//  fight
//
//  Created by Benjamin on 24/06/13.
//  Copyright (c) 2013 Benjamin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface FightLocationViewController : UIViewController<MKMapViewDelegate>
@property (strong) NSManagedObject *fight;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
