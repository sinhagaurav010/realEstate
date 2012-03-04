//
//  SavedSearchesViewController.m
//  PropertyApp
//
//  Created by saurav sinha on 03/03/12.
//  Copyright (c) 2012 sauravsinha007@gmail.com. All rights reserved.
//

#import "SavedSearchesViewController.h"
#import "SavedSearches.h"
@implementation SavedSearchesViewController
@synthesize arraySavedSearchesResult,searchPattern;
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
    self.navigationItem.title = TITLENAV;
    self.view.backgroundColor   = COLORBAC;
    self.navigationController.navigationBar.tintColor   = COLORBAC;
      self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"Edit" style:UIBarButtonItemStyleBordered target:self action:@selector(clickToEditBarBtn:)];
        NSLog(@"arraySavedSearchesResult=%@",arraySavedSearchesResult);
   
}
-(void)viewWillAppear:(BOOL)animated
{
    
    self.navigationController.navigationBarHidden=NO;
    self.navigationItem.hidesBackButton=NO;
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
#pragma mark - UitableView datas source and delegate

#pragma mark - UITableView Delegates
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return 100;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arraySavedSearchesResult count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SavedSearches *cell = (SavedSearches *)[tableView dequeueReusableCellWithIdentifier:@"SavedSearches"];
    if (!cell) 
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SavedSearches" owner:self options:nil] lastObject] ;
    }
    if([[[arraySavedSearchesResult objectAtIndex:indexPath.row] objectForKey:@"MAXPRICE"] integerValue]==1000001)
    { 
        cell.labelPrice.text=[NSString stringWithFormat:@"£%dk or over ",[[[arraySavedSearchesResult objectAtIndex:0] objectForKey:@"MINPRICE"] integerValue]/1000];
    }
    else if(([strPriceMax integerValue]==1000000 && [strPriceMin integerValue]==0 )||([strPriceMax integerValue]==1000 && [strPriceMin integerValue]==0 ) )
    {
        cell.labelPrice.text=@"Any Price";
    }
    else
    {
        if([[[arraySavedSearchesResult objectAtIndex:indexPath.row] objectForKey:@"FOR"] isEqualToString:@"TO LET"])
        {
            cell.labelPrice.text=[NSString stringWithFormat:@"£%d - £%d ",[[[arraySavedSearchesResult objectAtIndex:0] objectForKey:@"MINPRICE"] integerValue],[[[arraySavedSearchesResult objectAtIndex:0] objectForKey:@"MAXPRICE"] integerValue]];
        }
        else
        {
            cell.labelPrice.text=[ NSString stringWithFormat:@"£%dk - £%dk",[[[arraySavedSearchesResult objectAtIndex:indexPath.row] objectForKey:@"MINPRICE"] integerValue]/1000,[[[arraySavedSearchesResult objectAtIndex:indexPath.row] objectForKey:@"MAXPRICE"] integerValue]/1000];
        }
    }

    cell.labelFor.text=[[arraySavedSearchesResult objectAtIndex:indexPath.row] objectForKey:@"FOR"];
   // cell.labelPrice.text=[ NSString stringWithFormat:@"£%dk - £%dk",[[[arraySavedSearchesResult objectAtIndex:indexPath.row] objectForKey:@"MINPRICE"] integerValue]/1000,[[[arraySavedSearchesResult objectAtIndex:indexPath.row] objectForKey:@"MAXPRICE"] integerValue]/1000];
    cell.labelLocation.text=[[arraySavedSearchesResult objectAtIndex:indexPath.row] objectForKey:@"LOCATION"];
    cell.labelBedrooms.text=[NSString stringWithFormat:@"%@ or more",[[arraySavedSearchesResult objectAtIndex:indexPath.row] objectForKey:@"BEDROOMS"]];
     cell.labelSortBy.text=[ NSString stringWithFormat:@"%@ %@",[[arraySavedSearchesResult objectAtIndex:indexPath.row] objectForKey:@"SORTBY"],[[arraySavedSearchesResult objectAtIndex:indexPath.row] objectForKey:@"ORDERARRANGE"]];
   if(self.navigationItem.rightBarButtonItem.title==@"Edit")
    cell.accessoryType=1;
   else
       cell.accessoryType=0;

    return (UITableViewCell *)cell;
}    

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[[arraySavedSearchesResult  objectAtIndex:indexPath.row] objectForKey:@"GPSENABLED"] isEqualToString:@"GPS"])
    {
        isFromCrrntLoc=YES;   
    }
    else
    {
        isFromCrrntLoc=NO;
    }
   searchPattern=[[SearchPattren alloc]init];
    [searchPattern searchPropertyWheretransaction_type:[[arraySavedSearchesResult  objectAtIndex:indexPath.row] objectForKey:@"FOR"]fromLocation:[[arraySavedSearchesResult  objectAtIndex:indexPath.row] objectForKey:@"LOCATION"] fromMinPrice:[[arraySavedSearchesResult  objectAtIndex:indexPath.row] objectForKey:@"MINPRICE"]toMaxPrice:[[arraySavedSearchesResult  objectAtIndex:indexPath.row] objectForKey:@"MAXPRICE"] withBedrooms:[[arraySavedSearchesResult  objectAtIndex:indexPath.row] objectForKey:@"BEDROOMS"] withSorting:[[arraySavedSearchesResult  objectAtIndex:indexPath.row] objectForKey:@"SORTBY"] arrangeWithOrder:[[arraySavedSearchesResult  objectAtIndex:indexPath.row] objectForKey:@"ORDERARRANGE"] gpsEnabled:isFromCrrntLoc Inarray:arrayProperty];
    SearchResultViewController *srvc=[[SearchResultViewController alloc]init];
    strFor=[[arraySavedSearchesResult  objectAtIndex:indexPath.row] objectForKey:@"FOR"];
    strLocation=[[arraySavedSearchesResult  objectAtIndex:indexPath.row] objectForKey:@"LOCATION"];
    strPriceMin=[[arraySavedSearchesResult  objectAtIndex:indexPath.row] objectForKey:@"MINPRICE"] ;
    strPriceMax=[[arraySavedSearchesResult  objectAtIndex:indexPath.row] objectForKey:@"MAXPRICE"] ;
    strBedrooms =[[arraySavedSearchesResult  objectAtIndex:indexPath.row] objectForKey:@"BEDROOMS"];
    strSortBy=[[arraySavedSearchesResult  objectAtIndex:indexPath.row] objectForKey:@"SORTBY"]; 
    strAscending=[[arraySavedSearchesResult  objectAtIndex:indexPath.row] objectForKey:@"ORDERARRANGE"];
    strRadius=[[arraySavedSearchesResult  objectAtIndex:indexPath.row] objectForKey:@"RADIUS"];
    strGPS=[[arraySavedSearchesResult  objectAtIndex:indexPath.row] objectForKey:@"GPSENABLED"];
    NSLog(@"array result count=%d",[searchPattern.arrayResult count]);
   [srvc setArraySearchResult:searchPattern.arrayResult];
    [self.navigationController pushViewController:srvc animated:YES];
    
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // If row is deleted, remove it from the list.
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // If I comment this line out the delete works but I no longer have the animation
        [arraySavedSearchesResult removeObjectAtIndex:indexPath.row];
        [tableViewSavedSearches deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [ModalController removeContentForKey:SAVESEARCHES];
        [tableViewSavedSearches reloadData];
        
    }
    
}
-(IBAction)clickToEditBarBtn:(id)sender
{
    if([self.navigationItem.rightBarButtonItem.title isEqualToString:@"Edit"])
    {
        [tableViewSavedSearches setEditing:YES];
        self.navigationItem.rightBarButtonItem.title=@"Done";
        [tableViewSavedSearches reloadData];
    }
    else
    {
        [tableViewSavedSearches setEditing:NO];
        self.navigationItem.rightBarButtonItem.title=@"Edit"; 
        [tableViewSavedSearches reloadData];
    }
    
}
-(double)kilometresBetweenPlace1:(CLLocationCoordinate2D) place1 andPlace2:(CLLocationCoordinate2D) place2 {
    
    double dlon = convertToRadians(place2.longitude - place1.longitude);
    double dlat = convertToRadians(place2.latitude - place1.latitude);
    
    double a = ( pow(sin(dlat / 2), 2) + cos(convertToRadians(place1.latitude))) * cos(convertToRadians(place2.latitude)) * pow(sin(dlon / 2), 2);
    double angle = 2 * asin(sqrt(a));
    return angle * RADIO;
}

@end
