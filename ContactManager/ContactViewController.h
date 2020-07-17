//
//  ContactController.h
//  ContactManager
//
//  Created by Ruben Christian Buhl on 29.10.14.
//  Copyright (c) 2014 Ruben Christian Buhl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#import "ContactTableController.h"
#import "Contact.h"

@interface ContactViewController : UITableViewController <MKMapViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *firstname;
@property (weak, nonatomic) IBOutlet UITextField *lastname;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *url;
@property (weak, nonatomic) IBOutlet UITextField *longitude;
@property (weak, nonatomic) IBOutlet UITextField *latitude;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UISwitch *networkingSwitch;

@property (nonatomic, assign) id <ContactTableControllerDelegate> delegate;

@property (nonatomic, strong) Contact *updateContact;

@property (nonatomic, strong) CLLocationManager *locationManager;

@end
