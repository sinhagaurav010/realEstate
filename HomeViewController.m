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
#import "constants.h"

@implementation HomeViewController

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
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    modal=[[ModalController alloc]init];
    [modal sendTheRequestWithPostString:nil withURLString:@"http://www.bspc.co.uk/sspc_feed/sspc_feed.asp"];
    [modal setDelegate:self];
    
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    [hud setLabelText:@"Loading..."];
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
#pragma mark - User Defined Functions
-(IBAction)clickToForSale:(id)sender
{
    arrayHome=[[NSMutableArray alloc]init ];
    for (int i=0; i<[arrayProperty count]; i++) {
        if([txtFldLoc.text isEqualToString:[[arrayProperty objectAtIndex:i]objectForKey:@"postcode"]] || [txtFldLoc.text isEqualToString:[[arrayProperty objectAtIndex:i]objectForKey:@"address"]])
        {
            [arrayHome addObject:[arrayProperty objectAtIndex:i]];
        }
    }
    if([arrayHome count]>0)
    {
        NSLog(@"array home=%@",arrayHome);
        SearchResultViewController *sdvc=[[SearchResultViewController alloc]init];
        [sdvc setArraySearch:arrayHome];
        [self.navigationController pushViewController:sdvc animated:YES];
    }
    
}
-(IBAction)clickToToLet:(id)sender
{
    
}
-(IBAction)clickToSavedSearches:(id)sender
{
    
}
-(IBAction)clickToSavedProperties:(id)sender
{
    
}
#pragma mark - modal Delegates
-(void)getdata
{
//    NSDictionary *responseDict = [modal.dataXml objectFromJSONDataWithParseOptions:JKSerializeOptionNone error:nil];
//    NSLog(@"-------=%@",responseDict);
    
    NSError *error =  nil;


  NSDictionary * dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:modal.dataXml error:&error];
    
   // NSLog(@"------%@",dictionary);
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    [[dictionary objectForKey:@"property"] isKindOfClass:[NSArray class]];
    arrayProperty=[[NSMutableArray alloc]initWithArray:[dictionary objectForKey:@"property"]];
    NSLog(@"array property==%@",arrayProperty);
    
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
@end
