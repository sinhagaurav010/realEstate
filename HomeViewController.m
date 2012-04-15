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
@synthesize strUserAdd,strUserLat,strUserLong,strformattedAddress;
//const double PIx = 3.141592653589793;
//const double RADIO = 6371; // Mean radius of Earth in Km



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
    //find current location
    locmanager = [[CLLocationManager alloc] init];
    [locmanager setDelegate:self];
    [locmanager setDesiredAccuracy:kCLLocationAccuracyBest];
    [locmanager startUpdatingLocation];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=YES;
    strPrice= @"Any Price";
    strPriceMin=@"0";
    strBedrooms=@"0";
    strSortBy=@"price";
    strAscending=@"Ascending";
    strRadius=@"10";
    strGPS=nil;
    
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
    locmanager.delegate=nil;
    self.strUserLat = [NSString stringWithFormat:@"%g",newLocation.coordinate.latitude];
    self.strUserLong = [NSString stringWithFormat:@"%g",newLocation.coordinate.longitude];
    //NSLog(@"%@",self.strUserLat);
    
    [SVGeocoder reverseGeocode:CLLocationCoordinate2DMake(self.strUserLat.floatValue, self.strUserLong.floatValue)
                    completion:^(NSArray *placemarks, NSError *error) {
                        if(!error && placemarks) {
                            SVPlacemark *placemark = [placemarks objectAtIndex:0];
                            self.strformattedAddress=placemark.formattedAddress;
                            NSLog(@"formattedAddress=%@",strformattedAddress);
                            corrd.latitude=placemark.coordinate.latitude;
                            corrd.longitude=placemark.coordinate.longitude;
                            if(isFromCrrntLoc==YES)
                                txtFldLoc.text=[NSString stringWithFormat:@"%@ (GPS)",self.strformattedAddress];
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



#pragma mark - User Defined Functions
-(IBAction)clickToFindCurrentLocation:(id)sender
{
     strGPS=@"GPS";
    [txtFldLoc resignFirstResponder];
    isFromCrrntLoc=YES;
    if(TARGET_IPHONE_SIMULATOR)
    {
        double lat=55.5991;
        double  lng=-2.43339;//TD57HA ///55.92545 -3.200808
        self.strUserLat=[NSString stringWithFormat:@"%f",lat]; 
        self.strUserLong=[NSString stringWithFormat:@"%f",lng];
        corrd.latitude=[self.strUserLat doubleValue];
        corrd.longitude=[self.strUserLong doubleValue];
        //NSLog(@"%@",self.strUserLat);
        txtFldLoc.text=self.strformattedAddress;
        
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
//    if(TARGET_IPHONE_SIMULATOR)
//    {
//        txtFldLoc.text=@"TD9 9PY";
//    }
    
    [txtFldLoc resignFirstResponder];
    strFor=@"SALE";
    strPriceMax=MAXPRICE;
    if([txtFldLoc.text length]>0)
    {
        strLocation=txtFldLoc.text;
        if(isFromCrrntLoc == YES)
        {
            strGPS=@"GPS";
            strSortBy=kRadProp;
            
        }
        else
        {
            strGPS=nil;
            strSortBy=@"price";

        }
        SearchResultViewController *sdvc=[[SearchResultViewController alloc]init];
        [self.navigationController pushViewController:sdvc animated:YES];
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Info" message:@"Please enter postal code or Location." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
   
}

#pragma mark -clickToToLet-

-(IBAction)clickToToLet:(id)sender
{
    [txtFldLoc resignFirstResponder];
    
    strFor=@"TO LET";
    strPriceMax=MAXPRICE;
    if([txtFldLoc.text length]>0)
    {
        strLocation=txtFldLoc.text;
        if(isFromCrrntLoc == YES)
        {
            strGPS=@"GPS";
            strSortBy=kRadProp;
            
        }
        else
        {
            strGPS=nil;
            strSortBy=@"price";
            
        }

        SearchResultViewController *sdvc=[[SearchResultViewController alloc]init];
        [self.navigationController pushViewController:sdvc animated:YES];
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Info" message:@"Please enter postal code or Location." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
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
        SavePropertyViewController *spvc=[[SavePropertyViewController alloc]init];
        //  arraySearch = [[NSMutableArray alloc] initWithArray:arrayHome];  
        [spvc setArraySaveProResult:arraySavedProperty];
        //[sdvc setArraySearch:arraySavedProperty];
        [self.navigationController pushViewController:spvc animated:YES];
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
    NSError *error =  nil;
    NSDictionary * dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:modal.dataXml error:&error];    
    [[dictionary objectForKey:@"property"] isKindOfClass:[NSArray class]];
    arrayProperty=[[NSMutableArray alloc]initWithArray:[dictionary objectForKey:@"property"]];
    //NSLog(@"array property==%@",arrayProperty);
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
    if(isFromCrrntLoc==YES)
        txtFldLoc.text=nil;
    //NSLog(@"in textFieldShouldBeginEditing");
    strGPS=nil;
    isFromCrrntLoc=NO; 
    return YES;
}
@end
