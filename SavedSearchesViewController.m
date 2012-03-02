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
    arraySavedSearchesResult=[[NSMutableArray alloc]initWithArray:[ModalController getContforKey:SAVESEARCHES]];
    NSLog(@"arraySavedSearchesResult=%@",arraySavedSearchesResult);
   
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
    cell.labelFor.text=[[arraySavedSearchesResult objectAtIndex:indexPath.row] objectForKey:@"FOR"];
    cell.labelPrice.text=[ NSString stringWithFormat:@"£%@ - £%@",[[arraySavedSearchesResult objectAtIndex:indexPath.row] objectForKey:@"MINPRICE"],[[arraySavedSearchesResult objectAtIndex:indexPath.row] objectForKey:@"MAXPRICE"]];
    cell.labelLocation.text=[[arraySavedSearchesResult objectAtIndex:indexPath.row] objectForKey:@"LOCATION"];
    cell.labelBedrooms.text=[NSString stringWithFormat:@"%@ or more",[[arraySavedSearchesResult objectAtIndex:indexPath.row] objectForKey:@"BEDROOMS"]];
     cell.labelPrice.text=[ NSString stringWithFormat:@"%@ %@",[[arraySavedSearchesResult objectAtIndex:indexPath.row] objectForKey:@"SORTBY"],[[arraySavedSearchesResult objectAtIndex:indexPath.row] objectForKey:@"ORDERARRANGE"]];
   
    
    
    return (UITableViewCell *)cell;
}    

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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

@end
