//
//  AppConstants.h
//  ContactManager
//
//  Created by Ruben Christian Buhl on 12.12.14.
//  Copyright (c) 2014 Ruben Christian Buhl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppConstants : NSObject

FOUNDATION_EXPORT NSString * const createContactString;
FOUNDATION_EXPORT NSString * const editContactString;

FOUNDATION_EXPORT int const locationDistanceFilter;

FOUNDATION_EXPORT float const spanLongitudeDelta;
FOUNDATION_EXPORT float const spanLatitudeDelta;
FOUNDATION_EXPORT float const maximumLocationAge;

@end
