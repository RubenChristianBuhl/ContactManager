//
//  Contact.h
//  ContactManager
//
//  Created by Ruben Christian Buhl on 15.01.15.
//  Copyright (c) 2015 Ruben Christian Buhl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Contact : NSManagedObject

@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *firstname;
@property (nonatomic, retain) NSString *lastname;
@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) NSNumber *longitude;
@property (nonatomic, retain) NSNumber *latitude;

@end
