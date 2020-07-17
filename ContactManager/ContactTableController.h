//
//  ContactTableController.h
//  ContactManager
//
//  Created by Ruben Christian Buhl on 23.11.14.
//  Copyright (c) 2014 Ruben Christian Buhl. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Contact.h"

@protocol ContactTableControllerDelegate <NSObject>

- (void)addContactWithFirstname:(NSString *)firstname lastName:(NSString *)lastname email:(NSString *)email url:(NSString *)url longitude:(NSNumber *)longitude latitude:(NSNumber *)latitude;
- (void)updateContact:(Contact *)contact withFirstname:(NSString *)firstname lastName:(NSString *)lastname email:(NSString *)email url:(NSString *)url longitude:(NSNumber *)longitude latitude:(NSNumber *)latitude;

@end

@interface ContactTableController : UITableViewController <ContactTableControllerDelegate>

@end
