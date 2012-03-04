//
//  SearchPattren.h
//  PropertyApp
//
//  Created by saurav sinha on 03/03/12.
//  Copyright (c) 2012 sauravsinha007@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CLLocationManagerDelegate.h>
#import <CoreLocation/CoreLocation.h>

@interface SearchPattren : NSObject

{
    
}
@property(strong,nonatomic)NSMutableArray *arrayResult;
-(void)searchPropertyWheretransaction_type:(NSString *)transactionType fromLocation :(NSString *)loc fromMinPrice:(NSString *)maxPrice toMaxPrice:(NSString *)minPrice  withBedrooms:(NSString *)bedrooms withSorting:(NSString *)sortBy arrangeWithOrder:(NSString *)orderArrange gpsEnabled:(BOOL)gpsEnabled Inarray:(NSMutableArray *)arraySelect;
-(BOOL)checkForExistance:(NSString *)stringTocheck withStringFromArray:(NSString *)stringFrmArray;
double convertToRadians(double val) ;
-(double)kilometresBetweenPlace1:(CLLocationCoordinate2D) place1 andPlace2:(CLLocationCoordinate2D) place2;
@end
