//
//  MapViewController.m
//  ContactManager
//
//  Created by Ruben Christian Buhl on 03.03.15.
//  Copyright (c) 2015 Ruben Christian Buhl. All rights reserved.
//

#import "MapViewController.h"
#import "AppConstants.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated {
    MKCoordinateRegion region;
    
    region.center.longitude = [self.longitude doubleValue];
    region.center.latitude = [self.latitude doubleValue];
    region.span.longitudeDelta = spanLongitudeDelta;
    region.span.latitudeDelta = spanLongitudeDelta;
    
    [self.mapView setRegion: region animated: YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
