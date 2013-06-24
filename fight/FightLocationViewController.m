//
//  FightLocationViewController.m
//  fight
//
//  Created by Benjamin on 24/06/13.
//  Copyright (c) 2013 Benjamin. All rights reserved.
//

#import "FightLocationViewController.h"
#import "Location.h"

@interface FightLocationViewController ()

@end


@implementation FightLocationViewController
@synthesize mapView;
@synthesize fight;


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
    self.mapView.delegate = self;

    
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{

    
    // Add an annotation
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = [[self.fight valueForKey:@"latitude"] doubleValue];
    coordinate.longitude = [[self.fight valueForKey:@"longitude"] doubleValue];
    
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = coordinate;
    point.title = [self.fight valueForKey:@"name"];
    point.subtitle = [self.fight valueForKey:@"address"];
    [self.mapView addAnnotation:point];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
