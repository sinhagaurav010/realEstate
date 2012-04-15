//
//  HomeViewController.h
//  PropertyApp
//
//  Created by saurav sinha on 26/02/12.
//  Copyright (c) 2012 sauravsinha007@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModalController.h"
#import "Constant.h"
#import <CoreLocation/CLLocationManagerDelegate.h>
#import <CoreLocation/CoreLocation.h>
#import "SavePropertyViewController.h"
@interface HomeViewController : UIViewController<ModalDelegate,CLLocationManagerDelegate>
{
    IBOutlet UITextField *txtFldLoc;
    ModalController *modal;
    NSMutableArray *arrayHome;
    CLLocationManager *locmanager;
  
    
}
-(BOOL)checkForExistance:(NSString *)stringTocheck withStringFromArray:(NSString *)stringFrmArray;

@property(retain) NSString *strUserAdd;
@property(retain)NSString *strUserLat;
@property(retain)NSString *strUserLong;
@property(strong,nonatomic)NSString *strformattedAddress;
-(IBAction)clickToForSale:(id)sender;
-(IBAction)clickToToLet:(id)sender;
-(IBAction)clickToSavedSearches:(id)sender;
-(IBAction)clickToSavedProperties:(id)sender;
-(IBAction)clickToFindCurrentLocation:(id)sender;

@end
