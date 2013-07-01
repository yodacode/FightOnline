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
@synthesize geocoder = _geocoder;


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
    
    if (!self.geocoder) {
        self.geocoder = [[CLGeocoder alloc] init];
    }
    
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 1000, 1000);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
     NSString *address = [self.fight valueForKey:@"address"];    
    
    [self.geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {

        if ([placemarks count] > 0) {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            CLLocation *location = placemark.location;
            CLLocationCoordinate2D coordinate = location.coordinate;
            
            // Add an annotation
            CLLocationCoordinate2D coordinates;
            
            coordinates.longitude = coordinate.longitude;
            coordinates.latitude = coordinate.latitude;
            
            
            MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
            point.coordinate = coordinates;
            point.title = [self.fight valueForKey:@"name"];
            point.subtitle = [self.fight valueForKey:@"address"];
            [self.mapView addAnnotation:point];
            
            
        } else {
            NSLog(@"place not found");
        }
    
    
    }];
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
