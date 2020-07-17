//
//  ContactViewController.m
//  ContactManager
//
//  Created by Ruben Christian Buhl on 29.10.14.
//  Copyright (c) 2014 Ruben Christian Buhl. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

#import "AppConstants.h"
#import "MapViewController.h"
#import "ContactViewController.h"
#import "ContactManager.h"

@interface ContactViewController ()

- (void)showImageOfContact:(Contact *)contact;
- (void)showImageOfURL:(NSString *)url;
- (void)showImageWithNSURLSessionFrom:(NSString *)url;
- (void)showImageWithAFNetworkingFrom:(NSString *)url;

@end

@implementation ContactViewController

static BOOL networkingOn = NO;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.parentViewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemSave target: self action: @selector(save:)];

    if(self.locationManager == nil) {
        self.locationManager = [[CLLocationManager alloc] init];
    }

    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = locationDistanceFilter;

    [self.locationManager startUpdatingLocation];

    if(self.updateContact != nil) {
        self.firstname.text = self.updateContact.firstname;
        self.lastname.text = self.updateContact.lastname;
        self.email.text = self.updateContact.email;
        self.url.text = self.updateContact.url;
        self.longitude.text = [self.updateContact.longitude stringValue];
        self.latitude.text = [self.updateContact.latitude stringValue];

        self.parentViewController.navigationItem.title = NSLocalizedString(editContactString, nil);
    } else {
        self.parentViewController.navigationItem.title = NSLocalizedString(createContactString, nil);
    }

    [self.networkingSwitch setOn: networkingOn];
    [self showImageOfContact: self.updateContact];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.locationManager requestAlwaysAuthorization];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *location = [locations lastObject];

    NSDate *locationDate = location.timestamp;

    NSTimeInterval howrecent = [locationDate timeIntervalSinceNow];

    if(fabs(howrecent) < maximumLocationAge) {
        if(self.updateContact == nil) {
            MapViewController *mapViewController = (MapViewController *) [[(UITabBarController *) self.parentViewController viewControllers] objectAtIndex: 1];

            mapViewController.longitude = [NSNumber numberWithDouble: location.coordinate.longitude];
            mapViewController.latitude = [NSNumber numberWithDouble: location.coordinate.latitude];

            self.longitude.text = [[NSNumber numberWithDouble: location.coordinate.longitude] stringValue];
            self.latitude.text = [[NSNumber numberWithDouble: location.coordinate.latitude] stringValue];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)save:(id)sender {
    NSString* firstname = self.firstname.text;
    NSString* lastname = self.lastname.text;
    NSString* email = self.email.text;
    NSString* url = self.url.text;
    NSNumber* longitude = [NSNumber numberWithDouble: [self.longitude.text doubleValue]];
    NSNumber* latitude = [NSNumber numberWithDouble: [self.latitude.text doubleValue]];

    if(self.updateContact != nil) {
        [self.delegate updateContact: self.updateContact withFirstname: firstname lastName: lastname email: email url: url longitude: longitude latitude: latitude];
    } else {
        [self.delegate addContactWithFirstname: firstname lastName: lastname email: email url: url longitude: longitude latitude: latitude];
    }

    [self.navigationController popViewControllerAnimated: YES];
}

- (IBAction)chooseImage:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];

    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;

    [self presentViewController: picker animated: YES completion: nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey: UIImagePickerControllerOriginalImage];

    self.image.image = image;

    [self dismissViewControllerAnimated: YES completion: nil];
}

- (IBAction)changeNetworking:(id)sender {
    networkingOn = self.networkingSwitch.on;
}

- (IBAction)changeURL:(id)sender {
    [self showImageOfURL: self.url.text];
}

- (IBAction)changeLongitudeOrLatitude:(id)sender {
    MapViewController *mapViewController = (MapViewController *) [[(UITabBarController *) self.parentViewController viewControllers] objectAtIndex: 1];

    mapViewController.longitude = [NSNumber numberWithDouble: [self.longitude.text doubleValue]];
    mapViewController.latitude = [NSNumber numberWithDouble: [self.latitude.text doubleValue]];
}

- (void)showImageOfContact:(Contact *)contact {
    if(contact != nil) {
        [self showImageOfURL: contact.url];
    }
}

- (void)showImageOfURL:(NSString *)url {
    if(networkingOn) {
        [self showImageWithAFNetworkingFrom: url];
    } else {
        [self showImageWithNSURLSessionFrom: url];
    }
}

- (void)showImageWithNSURLSessionFrom:(NSString *)url {
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL: [NSURL URLWithString: url] completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error == nil) {
            self.image.image = [[UIImage alloc] initWithData: data];
        } else {
            NSLog(@"%@", error);
        }
    }];

    [dataTask resume];
}

- (void)showImageWithAFNetworkingFrom:(NSString *)url {
    NSURLRequest *request = [NSURLRequest requestWithURL: [NSURL URLWithString: url]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest: request];

    [operation setCompletionBlockWithSuccess: ^(AFHTTPRequestOperation *operation, id responseObject) {
        self.image.image = [[UIImage alloc] initWithData: (NSData *) responseObject];
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];

    [operation start];
}

@end
