//
//  HomeViewController.m
//  PropertyApp
//
//  Created by saurav sinha on 26/02/12.
//  Copyright (c) 2012 sauravsinha007@gmail.com. All rights reserved.
//

#import "HomeViewController.h"
#import "SearchResultViewController.h"
#import "JSON.h"
#import "MBProgressHUD.h"
#import "SBJSON.h"
#import "JSONKit.h"
#import "CJSONDeserializer.h"
#import "constant.h"
#import "SVGeocoder.h"
#import "SavedSearches.h"
@implementation HomeViewController
@synthesize strUserAdd,strUserLat,strUserLong;
//const double PIx = 3.141592653589793;
//const double RADIO = 6371; // Mean radius of Earth in Km


double convertToRadians(double val) {
    
    return val * PIx / 180;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    self.navigationItem.title = TITLENAV;
    self.navigationController.navigationBar.tintColor   = COLORBAC;
    self.view.backgroundColor = COLORBAC;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    modal=[[ModalController alloc]init];
    [modal sendTheRequestWithPostString:nil withURLString:kmainURL];
    [modal setDelegate:self];
    
    //    if(TESTING)
    //        if([ModalController  getContforKey:SAVEDATA ])
    
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    [hud setLabelText:@"Loading..."]; 
    arraySavedSearchesForSaveBtn =[[NSMutableArray alloc]initWithArray:[ModalController getContforKey:SAVESEARCHES]];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=YES;
    strPrice= @"Any Price";
    strPriceMin=@"0";
    strBedrooms=@"0";
    strSortBy=@"price";
    strAscending=@"Ascending";
    strRadius=@"10.79";
    
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark -CLLocationManager Delegates

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [locmanager stopUpdatingLocation];
    self.strUserLat = [NSString stringWithFormat:@"%g",newLocation.coordinate.latitude];
    self.strUserLong = [NSString stringWithFormat:@"%g",newLocation.coordinate.longitude];
    //NSLog(@"%@",self.strUserLat);
    
    [SVGeocoder reverseGeocode:CLLocationCoordinate2DMake(self.strUserLat.floatValue, self.strUserLong.floatValue)
                    completion:^(NSArray *placemarks, NSError *error) {
                        if(!error && placemarks) {
                            SVPlacemark *placemark = [placemarks objectAtIndex:0];
                            txtFldLoc.text=placemark.formattedAddress;
                            corrd.latitude=placemark.coordinate.latitude;
                            corrd.longitude=placemark.coordinate.longitude;
                        } else {
                            UIAlertView *alertView;
                            alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[error description] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                            [alertView show];
                        }
                        
                        
                    }];
}
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    //NSLog(@"error");
    [locmanager stopUpdatingLocation];
}
#pragma mark - To find distace between Locations(b/w 10KM)

-(double)kilometresBetweenPlace1:(CLLocationCoordinate2D) place1 andPlace2:(CLLocationCoordinate2D) place2 {
    
    double dlon = convertToRadians(place2.longitude - place1.longitude);
    double dlat = convertToRadians(place2.latitude - place1.latitude);
    
    double a = ( pow(sin(dlat / 2), 2) + cos(convertToRadians(place1.latitude))) * cos(convertToRadians(place2.latitude)) * pow(sin(dlon / 2), 2);
    double angle = 2 * asin(sqrt(a));
    return angle * RADIO;
}


#pragma mark - User Defined Functions
-(IBAction)clickToFindCurrentLocation:(id)sender
{
     strGPS=@"GPS";
    [txtFldLoc resignFirstResponder];
    isFromCrrntLoc=YES;
    if(TARGET_IPHONE_SIMULATOR)
    {
        double lat=55.5991;
        double  lng=-2.43339;
        self.strUserLat=[NSString stringWithFormat:@"%f",lat]; 
        self.strUserLong=[NSString stringWithFormat:@"%f",lng];
        corrd.latitude=[self.strUserLat doubleValue];
        corrd.longitude=[self.strUserLong doubleValue];
        //NSLog(@"%@",self.strUserLat);
        txtFldLoc.text=@"current loc";
        
    }
    else
    {
       
        locmanager = [[CLLocationManager alloc] init];
        [locmanager setDelegate:self];
        [locmanager setDesiredAccuracy:kCLLocationAccuracyBest];
        [locmanager startUpdatingLocation];
    }
}



-(IBAction)clickToForSale:(id)sender
{
    strPriceMax=@"1000000";
    [txtFldLoc resignFirstResponder];
    [arrayHome removeAllObjects];
    arrayHome=[[NSMutableArray alloc]init ];
    if([txtFldLoc.text length]>0)
    {
        if(isFromCrrntLoc == YES)
        {
            for(int i=0;i<[arrayProperty count];i++)
            {
                
                if([[[arrayProperty objectAtIndex:i] objectForKey:@"transaction_type"] integerValue] == 1)
                {
                    CLLocationCoordinate2D corrd2;
                    corrd2.latitude=[[[arrayProperty objectAtIndex:i] objectForKey:@"latitude"] doubleValue];
                    corrd2.longitude=[[[arrayProperty objectAtIndex:i] objectForKey:@"longitude"] doubleValue];
                    if (([self kilometresBetweenPlace1:corrd andPlace2:corrd2] < KMRANGE) && ([[[arrayProperty objectAtIndex:i] objectForKey:@"transaction_type"] integerValue] == 1) ) {
                        [arrayHome addObject:[arrayProperty objectAtIndex:i]];
                    }
                }
            }
        }
        else
        {
            
            for (int i=0; i<[arrayProperty count]; i++)
            {
                if([[[arrayProperty objectAtIndex:i] objectForKey:@"transaction_type"] integerValue] == 1)
                {
                    if([self checkForExistance:txtFldLoc.text withStringFromArray:[[arrayProperty objectAtIndex:i] objectForKey:kpostcode]])
                        [arrayHome  addObject:[arrayProperty  objectAtIndex:i]];
                    
                    else if([self checkForExistance:txtFldLoc.text withStringFromArray:[[arrayProperty objectAtIndex:i] objectForKey:kaddress]])
                        [arrayHome  addObject:[arrayProperty  objectAtIndex:i]];
                    
                    else if([self checkForExistance:txtFldLoc.text withStringFromArray:[[arrayProperty objectAtIndex:i] objectForKey:@"town"]])
                        [arrayHome  addObject:[arrayProperty  objectAtIndex:i]];
                }
            }
        }  
        if([arrayHome count]>0)
        {
            strFor=@"SALE";
            strLocation=txtFldLoc.text;
            NSSortDescriptor *myDescriptor = [[NSSortDescriptor alloc] initWithKey:@"price" ascending:YES];
            [arrayHome sortUsingDescriptors:[NSArray arrayWithObject:myDescriptor]];
            // NSLog(@"array home=%@",arrayHome);
            SearchResultViewController *sdvc=[[SearchResultViewController alloc]init];
            arraySearch = [[NSMutableArray alloc] initWithArray:arrayHome];
            [sdvc setArraySearchResult:arraySearch];
            // NSLog(@"array search=%@",arraySearch);
            [self.navigationController pushViewController:sdvc animated:YES];
        }
        
        else
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Info" message:@"No data found." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Info" message:@"Please enter postal code" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

#pragma mark -clickToToLet-

-(IBAction)clickToToLet:(id)sender
{
    strPriceMax=@"1000";
    [txtFldLoc resignFirstResponder];
    [arrayHome removeAllObjects];
    arrayHome = [[NSMutableArray alloc]init ];
    
    if([txtFldLoc.text length]>0)
    {
        if(isFromCrrntLoc == YES)
        {
            for(int i=0;i<[arrayProperty count];i++)
            {
                if([[[arrayProperty objectAtIndex:i] objectForKey:@"transaction_type"] integerValue] == 2)
                {
                    CLLocationCoordinate2D corrd2;
                    corrd2.latitude=[[[arrayProperty objectAtIndex:i] objectForKey:@"latitude"] doubleValue];
                    corrd2.longitude=[[[arrayProperty objectAtIndex:i] objectForKey:@"longitude"] doubleValue];
                    if (([self kilometresBetweenPlace1:corrd andPlace2:corrd2] < 10) && ([[[arrayProperty objectAtIndex:i] objectForKey:@"transaction_type"] integerValue] == 2) ) {
                        [arrayHome addObject:[arrayProperty objectAtIndex:i]];
                    }
                }
            }
        }
        
        else
        {
            for (int i=0; i<[arrayProperty count]; i++)
            {
                if([[[arrayProperty objectAtIndex:i] objectForKey:@"transaction_type"] integerValue] == 2)
                {
                    if([self checkForExistance:txtFldLoc.text withStringFromArray:[[arrayProperty objectAtIndex:i] objectForKey:kpostcode]])
                        [arrayHome  addObject:[arrayProperty  objectAtIndex:i]];
                    
                    else if([self checkForExistance:txtFldLoc.text withStringFromArray:[[arrayProperty objectAtIndex:i] objectForKey:kaddress]])
                        [arrayHome  addObject:[arrayProperty  objectAtIndex:i]];
                    
                    else if([self checkForExistance:txtFldLoc.text withStringFromArray:[[arrayProperty objectAtIndex:i] objectForKey:@"town"]])
                        [arrayHome  addObject:[arrayProperty  objectAtIndex:i]];
                }
            }
        } 
        if([arrayHome count]>0)
        {
            //NSLog(@"array home=%@",arrayHome);
            strFor=@"TO LET";
            strLocation=txtFldLoc.text;
            NSSortDescriptor *myDescriptor = [[NSSortDescriptor alloc] initWithKey:@"price" ascending:YES];
            [arrayHome sortUsingDescriptors:[NSArray arrayWithObject:myDescriptor]];
            SearchResultViewController *sdvc=[[SearchResultViewController alloc]init];
            arraySearch = [[NSMutableArray alloc] initWithArray:arrayHome];
            [sdvc setArraySearchResult:arraySearch];
            [self.navigationController pushViewController:sdvc animated:YES];
        }
        
        else
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Info" message:@"No data found." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Info" message:@"Please enter postal code" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
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
-(IBAction)clickToSavedSearches:(id)sender
{
    SavedSearchesViewController *ssvc=[[SavedSearchesViewController alloc]init];
    [ssvc setArraySavedSearchesResult:arraySavedSearchesForSaveBtn];
    [self.navigationController pushViewController:ssvc animated:YES];
    // [alert release];
}
-(IBAction)clickToSavedProperties:(id)sender
{
    NSMutableArray *arraySavedProperty = [[NSMutableArray alloc] initWithArray:[ModalController getContforKey:SAVEDPROP]];
    if([arraySavedProperty count]>0)
    {
        SearchResultViewController *sdvc=[[SearchResultViewController alloc]init];
        //  arraySearch = [[NSMutableArray alloc] initWithArray:arrayHome];  
        [sdvc setArraySearchResult:arraySavedProperty];
        //[sdvc setArraySearch:arraySavedProperty];
        [self.navigationController pushViewController:sdvc animated:YES];
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Info" message:@"No Property has been saved" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        //[alert  release];
    }
}
#pragma mark - modal Delegates
-(void)getdata
{
    if(TESTING)
        [ModalController  saveTheContent:modal.stringRx withKey:SAVEDATA];
    //    NSDictionary *responseDict = [modal.dataXml objectFromJSONDataWithParseOptions:JKSerializeOptionNone error:nil];
    //    //NSLog(@"-------=%@",responseDict);
    
    NSError *error =  nil;
    
    
    NSDictionary * dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:modal.dataXml error:&error];
    //    NSLog(@"%@",dictionary);
    
    [[dictionary objectForKey:@"property"] isKindOfClass:[NSArray class]];
    arrayProperty=[[NSMutableArray alloc]initWithArray:[dictionary objectForKey:@"property"]];
    //NSLog(@"array property==%@",arrayProperty);
    // //NSLog(@"------%@",dictionary);
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    
}
-(void)getError
{
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    [ModalController showTheAlertWithMsg:@"Error in Network" withTitle:@"Info" inController:nil];
    
}
#pragma mark - UiTextField Delegates
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    //NSLog(@"in textFieldShouldBeginEditing");
    strGPS=nil;
    isFromCrrntLoc=NO; 
    return YES;
}
@end
