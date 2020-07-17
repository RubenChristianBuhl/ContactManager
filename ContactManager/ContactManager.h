//
//  ContactManager.h
//  ContactManager
//
//  Created by Ruben Christian Buhl on 30.10.14.
//  Copyright (c) 2014 Ruben Christian Buhl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "Contact.h"

@interface ContactManager : NSObject

- (void)addContactWithFirstname:(NSString *)firstname lastName:(NSString *)lastname email:(NSString *)email url:(NSString *)url longitude:(NSNumber *)longitude latitude:(NSNumber *)latitude;
- (void)updateContact:(Contact *)contact withFirstname:(NSString *)firstname lastName:(NSString *)lastname email:(NSString *)email url:(NSString *)url longitude:(NSNumber *)longitude latitude:(NSNumber *)latitude;

@property (nonatomic, strong) NSMutableArray *contacts;

@end
