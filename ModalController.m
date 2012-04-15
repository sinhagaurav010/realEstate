//
//  ModalController.m
//  ICMiPhoneApp
//
//  Created by Gaurav Sinha on 27/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ModalController.h"


@implementation ModalController

@synthesize stringRx,dataXml,delegate;

-(void)sendTheRequestWithPostString:(NSString*)string withURLString:(NSString*)URL
{
      NSMutableURLRequest *request = [NSMutableURLRequest 
                                    requestWithURL:[NSURL URLWithString:URL] 
                                    cachePolicy:NSURLRequestUseProtocolCachePolicy
                                    timeoutInterval:25.0];  
    
    NSData *postData = [string dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:postData];
    
    [request setHTTPMethod:@"POST"];
    receivedData = [[NSMutableData alloc] init];
    
    NSURLConnection *connection = [[NSURLConnection alloc]
                                   initWithRequest:request
                                   delegate:self
                                   startImmediately:YES];
    
    [connection start];
    //[connection release];
}

//+(void)sendLog:(NSString *)string
//{
//    NSMutableURLRequest *request = [NSMutableURLRequest 
//                                    requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:URLDEBUG,string]] 
//                                    cachePolicy:NSURLRequestUseProtocolCachePolicy
//                                    timeoutInterval:100];  
//    
//    //receivedData = [[NSMutableData alloc] init];
//    
//    //    NSData *postData = [string dataUsingEncoding:NSUTF8StringEncoding];
//    //    [request setHTTPBody:postData];
//    
//    NSURLConnection *connection = [[NSURLConnection alloc]
//                                   initWithRequest:request
//                                   delegate:nil
//                                   startImmediately:YES];    
//    [connection release];
//    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
//    //NSLog(@"current version%@--%@",currSysVer,[[UIDevice currentDevice] systemName]);
//}
#pragma mark -ConvertToSystemTimeZone-

//+(NSDate*) convertToSystemTimezone:(NSDate*)sourceDate {
//    NSCalendar * calendar = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
//    [calendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
//    
//    NSUInteger flags = (NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit );
//    NSDateComponents * dateComponents = [calendar components:flags fromDate:sourceDate];
//    
//    [calendar setTimeZone:[NSTimeZone systemTimeZone]];
//    NSDate * myDate = [calendar dateFromComponents:dateComponents];
//    
//    return myDate;
//}


#pragma mark -isLogin-
//+(BOOL)isLoggedIn
//{
//    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
//    
//    if([prefs objectForKey:@"TokenICM"])
//        return 1;
//    
//    return  0;
//}

+(double)calDistancebetWithLat:(double)latSource with:(double)longSource with:(double)latDis with:(double   )londDis
{
//    int nRadius = 6371; // Earth's radius in Kilometers
//    // Get the difference between our two points
//    // then convert the difference into radians
//    double nDLat = (latDis - latSource) * (M_PI/180);
//    double nDLon = (londDis - longSource) * (M_PI/180);
//    double nA = pow ( sin(nDLat/2), 2 ) + cos(latSource) * cos(latDis) * pow ( sin(nDLon/2), 2 );
//    
//    double nC = 2 * atan2( sqrt(nA), sqrt( 1 - nA ));
//    double nD = nRadius * nC;
//    //NSLog(@"%f",nD);
    
//    CLLocation *userLoc = [[CLLocation alloc]initWithLatitude:latSource  longitude:longSource];
//    CLLocation *poiLoc = [[CLLocation alloc] initWithLatitude:latDis longitude:londDis];
//	
//    double dist = [userLoc getDistanceFrom:poiLoc] / 1000;
// return dist; // Return our calculated distance
    return NO;
}
#pragma mark -delegate-


#pragma mark -connection-

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[receivedData appendData:data];    
    ////////NSLog(@"Received data is now %d bytes", [receivedData length]); 	  
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    stringRx = @"error";
    [self.delegate getError];
    //[[NSNotificationCenter defaultCenter] postNotificationName:ERROR object:nil];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    dataXml = [[NSData alloc] initWithData:receivedData];
    
    stringRx = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    
    //////NSLog(@"GetString-%@",stringRx);
    [self.delegate getdata];
    //[[NSNotificationCenter defaultCenter] postNotificationName:GETXML 
    //                                                  object:nil];
}
+(void)showTheAlertWithMsg:(NSString*)strMsg withTitle:(NSString*)strTitle inController:(UIViewController*)controller
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle 
                                                    message:strMsg 
                                                   delegate:controller
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles: nil];
    [alert show];
   // [alert release];
}

#pragma mark -NSUserDefaults-
+(void)saveTheContent:(id)savedEle withKey:(NSString*)stringKey
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:savedEle forKey:stringKey];
    
    [prefs synchronize];
    
}
+(void)removeContentForKey:(NSString*)stringKey
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs removeObjectForKey:stringKey];
    [prefs synchronize];
    
}
+(id)getContforKey:(NSString*)stringKey
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:stringKey];
}


//
//+(UIView*)titleView
//{
//    UILabel *Loco = [[UILabel alloc] initWithFrame:CGRectMake(0, 7, 100, 30)];
//    Loco.textColor = [UIColor grayColor];
//    Loco.font = [UIFont systemFontOfSize:25];
//    Loco.backgroundColor = [UIColor clearColor];
//    Loco.text = @"Loco";
//    Loco.textAlignment = UITextAlignmentRight;
//    
//    UILabel *ping = [[UILabel alloc] initWithFrame:CGRectMake(100, 7, 100, 30)];
//    ping.textColor = [UIColor orangeColor];
//    ping.font = [UIFont systemFontOfSize:25];
//    ping.backgroundColor = [UIColor clearColor];
//    ping.text = @"Ping";
//    
//    UIView *locoPingView = [[[UIView alloc] initWithFrame:CGRectMake(60, 0, 260, 44)] autorelease];
//    [locoPingView addSubview:Loco];
//    [locoPingView addSubview:ping];
//    //    [self.navigationItem.titleView addSubview:Loco];
//    //    [self.navigationItem.titleView addSubview:ping];
//    
//    [Loco release];
//    [ping release];
//    
//    return locoPingView;
//}
//

//-(void)dealloc
//{ 
//    //    [receivedData release];
//    //    [stringRx release];
//    [super dealloc];
//}
@end
