//
//  MapViewController.h
//  ContactManager
//
//  Created by Ruben Christian Buhl on 03.03.15.
//  Copyright (c) 2015 Ruben Christian Buhl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#import "Contact.h"

@interface MapViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (nonatomic, strong) NSNumber* longitude;
@property (nonatomic, strong) NSNumber* latitude;

@end
