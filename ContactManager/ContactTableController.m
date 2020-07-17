//
//  ContactTableController.m
//  ContactManager
//
//  Created by Ruben Christian Buhl on 23.11.14.
//  Copyright (c) 2014 Ruben Christian Buhl. All rights reserved.
//

#import "ContactTableController.h"
#import "ContactCell.h"
#import "MapViewController.h"
#import "ContactViewController.h"
#import "ContactManager.h"
#import "Contact.h"

@interface ContactTableController ()

@property (nonatomic, strong) ContactManager *contactManager;

@end

@implementation ContactTableController

- (void)viewDidLoad {
    [super viewDidLoad];

    _contactManager = [[ContactManager alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addContactWithFirstname:(NSString *)firstname lastName:(NSString *)lastname email:(NSString *)email url:(NSString *)url longitude:(NSNumber *)longitude latitude:(NSNumber *)latitude {
    [self.contactManager addContactWithFirstname: firstname lastName: lastname email: email url: url longitude: longitude latitude: latitude];
    [self.tableView reloadData];
}

- (void)updateContact:(Contact *)contact withFirstname:(NSString *)firstname lastName:(NSString *)lastname email:(NSString *)email url:(NSString *)url longitude:(NSNumber *)longitude latitude:(NSNumber *)latitude {
    [self.contactManager updateContact: contact withFirstname: firstname lastName: lastname email: email url: url longitude: longitude latitude: latitude];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.contactManager.contacts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ContactCell *cell = (ContactCell *) [tableView dequeueReusableCellWithIdentifier: @"contactCell" forIndexPath:indexPath];

    // Configure the cell...
    Contact *contact = [self.contactManager.contacts objectAtIndex: indexPath.row];

    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat: @"%@ %@", contact.firstname, contact.lastname]];
    UIFont *font = [UIFont boldSystemFontOfSize: cell.name.font.pointSize];
    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject: font forKey: NSFontAttributeName];

    [attrString setAttributes: attrsDictionary range: NSMakeRange(attrString.length - contact.lastname.length, contact.lastname.length)];

    cell.name.attributedText = attrString;

    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    ContactViewController *viewController = (ContactViewController *) [[(UITabBarController *) segue.destinationViewController viewControllers] objectAtIndex: 0];
    MapViewController *mapViewController = (MapViewController *) [[(UITabBarController *) segue.destinationViewController viewControllers] objectAtIndex: 1];

    viewController.delegate = self;

    if([segue.identifier isEqualToString: @"updateContactSegue"]) {
        viewController.updateContact = [self.contactManager.contacts objectAtIndex: self.tableView.indexPathForSelectedRow.row];

        mapViewController.longitude = viewController.updateContact.longitude;
        mapViewController.latitude = viewController.updateContact.latitude;
    } else if([segue.identifier isEqualToString: @"addContactSegue"]) {
        viewController.updateContact = nil;
    }
}

@end
