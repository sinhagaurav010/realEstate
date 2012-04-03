//
//  SearchPattren.m
//  PropertyApp
//
//  Created by saurav sinha on 03/03/12.
//  Copyright (c) 2012 sauravsinha007@gmail.com. All rights reserved.
//

#import "SearchPattren.h"
#import "constant.h"
double convertToRadians(double val) {
    
    return val * PIx / 180;
}

@implementation SearchPattren
@synthesize arrayResult;
-(void)searchPropertyWheretransaction_type:(NSString *)transactionType fromLocation :(NSString *)loc fromMinPrice:(NSString *)minPrice toMaxPrice:(NSString *)maxPrice  withBedrooms:(NSString *)bedrooms withSorting:(NSString *)sortBy arrangeWithOrder:(NSString *)orderArrange gpsEnabled:(NSString *)gpsEnable Inarray:(NSMutableArray *)arraySelect
{
  
    self.arrayResult=[[NSMutableArray alloc]init];
    NSLog(@"array select count=%d",[arraySelect count]);
    NSLog(@"transaction type=%@,\n location=%@,\n minPrice=%@ \n maxPrice=%@ \n bedrooms=%@ \n sort by=%@ \n arrange order=%@ \n gps=%@",transactionType,loc,minPrice,maxPrice,bedrooms,sortBy,orderArrange,gpsEnable);
    NSMutableArray *arrayTemp=[[NSMutableArray alloc]init];
    if( [transactionType isEqualToString:@"SALE"])
        transactionType=@"1";
    else
        transactionType=@"2";
    
    if ([gpsEnable isEqualToString:@"GPS"]) {
        isFromCrrntLoc=YES;
    }
    else
    {
        isFromCrrntLoc=NO;
   
    }
    if(isFromCrrntLoc==YES)
    {
        for(int i=0;i<[arraySelect count];i++)
        {
            
            CLLocationCoordinate2D corrd2;
            corrd2.latitude=[[[arraySelect objectAtIndex:i] objectForKey:@"latitude"] doubleValue];
            corrd2.longitude=[[[arraySelect objectAtIndex:i] objectForKey:@"longitude"] doubleValue];

            if (([self kilometresBetweenPlace1:corrd andPlace2:corrd2] < [strRadius doubleValue]) && ([[[arraySelect objectAtIndex:i] objectForKey:@"transaction_type"] integerValue] == [transactionType integerValue]) ) {
                NSMutableDictionary *dictProp = [[NSMutableDictionary alloc] initWithDictionary:[arraySelect objectAtIndex:i]];
                [dictProp setObject:[NSString stringWithFormat:@"%0.2fKm",[self kilometresBetweenPlace1:corrd andPlace2:corrd2]] forKey:kRadProp];
                [arrayTemp addObject:dictProp];
            }
        }
        
    }
    else
    {
        for (int i=0; i<[arraySelect count]; i++)
        {
            if([[[arraySelect objectAtIndex:i] objectForKey:@"transaction_type"] integerValue] == [transactionType integerValue])
            {
                if([self checkForExistance:loc withStringFromArray:[[arraySelect objectAtIndex:i] objectForKey:kpostcode]])
                    [arrayTemp  addObject:[arraySelect  objectAtIndex:i]];
                
                else if([self checkForExistance:loc withStringFromArray:[[arraySelect objectAtIndex:i] objectForKey:kaddress]])
                    [arrayTemp  addObject:[arraySelect  objectAtIndex:i]];
                
                else if([self checkForExistance:loc withStringFromArray:[[arraySelect objectAtIndex:i] objectForKey:@"town"]])
                    [arrayTemp  addObject:[arraySelect  objectAtIndex:i]];
            }
        }
    }
   // NSLog(@"array temp=%@",arrayTemp);
    for(int i=0;i<[arrayTemp count];i++)
    {
     if([[[arrayTemp objectAtIndex:i] objectForKey:kbedrooms] integerValue] >= [bedrooms integerValue] && (([[[arrayTemp objectAtIndex:i] objectForKey:@"price"] integerValue]<=[maxPrice integerValue]) && ([[[arrayTemp objectAtIndex:i] objectForKey:@"price"] integerValue]>=[minPrice integerValue])))
     {
         [self.arrayResult addObject:[arrayTemp objectAtIndex:i]];
        
     }
    }
   
    NSSortDescriptor *myDescriptor;
    if([orderArrange isEqualToString:@"Ascending"])
    {
        myDescriptor = [[NSSortDescriptor alloc] initWithKey:[NSString stringWithFormat:@"%@",sortBy] ascending:YES];
    }
    else
    {
        myDescriptor = [[NSSortDescriptor alloc] initWithKey:[NSString stringWithFormat:@"%@",sortBy] ascending:NO];
    }
    [self.arrayResult sortUsingDescriptors:[NSArray arrayWithObject:myDescriptor]];
    // NSLog(@"array=%@",array);
      NSLog(@"array result count=%d",[self.arrayResult count]);
    
}

-(BOOL)checkForExistance:(NSString *)stringTocheck withStringFromArray:(NSString *)stringFrmArray
{
    BOOL check = NO;
    if([stringFrmArray  length]>=[stringTocheck length])
    {
        if([[[NSString stringWithFormat:@"%@",stringFrmArray]  substringToIndex:[stringTocheck length]] caseInsensitiveCompare:stringTocheck]==NSOrderedSame)
            check = YES;
    }
    return check;
}
#pragma mark - To find distace between Locations(b/w 10KM)

-(double)kilometresBetweenPlace1:(CLLocationCoordinate2D) place1 andPlace2:(CLLocationCoordinate2D) place2 {
    
   double dlon = convertToRadians(place2.longitude - place1.longitude);
    double dlat = convertToRadians(place2.latitude - place1.latitude);
    
    double a = ( pow(sin(dlat / 2), 2) + cos(convertToRadians(place1.latitude))) * cos(convertToRadians(place2.latitude)) * pow(sin(dlon / 2), 2);
    double angle = 2 * asin(sqrt(a));
    return angle * RADIO; 
}

@end
