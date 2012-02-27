//
// SVPlacemark.m
// SVGeocoder
//
// Created by Sam Vermette on 01.05.11.
// Copyright 2011 samvermette.com. All rights reserved.
//
// https://github.com/samvermette/SVGeocoder
//

#import "SVPlacemark.h"


@implementation SVPlacemark

@synthesize coordinate;
@synthesize formattedAddress;

- (void)dealloc {
    self.formattedAddress = nil;
    [super dealloc];
}

- (id)initWithCoordinate:(CLLocationCoordinate2D)aCoordinate addressDictionary:(NSDictionary *)addressDictionary {
	
	if((self = [super initWithCoordinate:aCoordinate addressDictionary:addressDictionary]))
		self.coordinate = aCoordinate;
	
	return self;
}

- (NSString*)description {
	
	NSDictionary *coordDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:self.coordinate.latitude], @"latitude", [NSNumber numberWithFloat:self.coordinate.longitude], @"longitude", nil]; 
	
	NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:coordDict, @"coordinate", self.addressDictionary, @"address", self.formattedAddress, @"formattedAddress", nil];
	
	return [dict description];
}

@end
