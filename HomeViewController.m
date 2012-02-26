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
    [arrayHome removeAllObjects];
    if([txtFldLoc.text length]>0)
    {
    NSLog(@"%@",[[[arrayProperty objectAtIndex:0] objectForKey:@"transaction_type"] class]);
    arrayHome=[[NSMutableArray alloc]init ];
    for (int i=0; i<[arrayProperty count]; i++) {
        if(([txtFldLoc.text isEqualToString:[[arrayProperty objectAtIndex:i]objectForKey:@"postcode"]] || [[[arrayProperty objectAtIndex:i]objectForKey:@"address"] hasPrefix:txtFldLoc.text]) && ([[[arrayProperty objectAtIndex:i] objectForKey:@"transaction_type"] integerValue] == 1))
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
-(IBAction)clickToToLet:(id)sender
{
     [arrayHome removeAllObjects];
    if([txtFldLoc.text length]>0)
    {
       
        arrayHome=[[NSMutableArray alloc]init ];
        for (int i=0; i<[arrayProperty count]; i++) {
            if(([txtFldLoc.text isEqualToString:[[arrayProperty objectAtIndex:i]objectForKey:@"postcode"]] || [[[arrayProperty objectAtIndex:i]objectForKey:@"address"] hasPrefix:txtFldLoc.text]) && ([[[arrayProperty objectAtIndex:i] objectForKey:@"transaction_type"] integerValue] == 2))
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
-(IBAction)clickToSavedSearches:(id)sender
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Info" message:@"Not implemented yet!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];
}
-(IBAction)clickToSavedProperties:(id)sender
{
    NSMutableArray *arraySavedProperty = [[NSMutableArray alloc] initWithArray:[ModalController getContforKey:SAVEDPROP]];
    if([arraySavedProperty count]>0)
    {
        SearchResultViewController *sdvc=[[SearchResultViewController alloc]init];
        [sdvc setArraySearch:arraySavedProperty];
        [self.navigationController pushViewController:sdvc animated:YES];
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Info" message:@"No Propert has been saved" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert  release];
    }
}
#pragma mark - modal Delegates
-(void)getdata
{
    if(TESTING)
    [ModalController  saveTheContent:modal.stringRx withKey:SAVEDATA];
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
