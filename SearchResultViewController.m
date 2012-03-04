//
//  SearchResultViewController.m
//  PropertyApp
//
//  Created by saurav sinha on 26/02/12.
//  Copyright (c) 2012 sauravsinha007@gmail.com. All rights reserved.
//

#import "SearchResultViewController.h"
#import "searchCell.h"
#import "DetailViewController.h"


@implementation SearchResultViewController
@synthesize arraySearchResult;

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
    NSLog(@"here i csdc");
    self.navigationItem.title = TITLENAV;
    self.view.backgroundColor   = COLORBAC;
    self.navigationController.navigationBar.tintColor   = COLORBAC;
    tableViewSearch.tableHeaderView=ViewHeader;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    
    self.navigationController.navigationBarHidden=NO;
    self.navigationItem.hidesBackButton=YES;
   self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(clickToSaveNavBarBtn:)];
     self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(clickToBackBarBtn:)];
    dictSaved=[[NSMutableDictionary alloc]init];
    [dictSaved setValue:strFor forKey:@"FOR"];
    [dictSaved setValue:strLocation forKey:@"LOCATION"];
    [dictSaved setValue:strPriceMax forKey:@"MAXPRICE"];
    [dictSaved setValue:strPriceMin forKey:@"MINPRICE"];
    [dictSaved setValue:strBedrooms forKey:@"BEDROOMS"];
    [dictSaved setValue:strAscending forKey:@"ORDERARRANGE"];
    [dictSaved setValue:strSortBy forKey:@"SORTBY"];
    [dictSaved setValue:strRadius forKey:@"RADIUS"];
    [dictSaved setValue:strGPS forKey:@"GPSENABLED"];
    arraySavedSearches =[[NSMutableArray alloc]initWithObjects:dictSaved, nil];
    NSLog(@"arraySavedSearches=%@",arraySavedSearches);
    if([strPriceMax integerValue]==1000001)
    { 
        labelPrice.text=[NSString stringWithFormat:@"£%dk or over ",[[[arraySavedSearches objectAtIndex:0] objectForKey:@"MINPRICE"] integerValue]/1000];
    }
    else if(([strPriceMax integerValue]==1000000 && [strPriceMin integerValue]==0 )||([strPriceMax integerValue]==1000 && [strPriceMin integerValue]==0 ) )
    {
        labelPrice.text=@"Any Price";
    }
    else
    {
        if([strFor isEqualToString:@"TO LET"])
        {
            labelPrice.text=[NSString stringWithFormat:@"£%d - £%d ",[[[arraySavedSearches objectAtIndex:0] objectForKey:@"MINPRICE"] integerValue],[[[arraySavedSearches objectAtIndex:0] objectForKey:@"MAXPRICE"] integerValue]];
        }
        else
        {
     labelPrice.text=[NSString stringWithFormat:@"£%dk - £%dk ",[[[arraySavedSearches objectAtIndex:0] objectForKey:@"MINPRICE"] integerValue]/1000,[[[arraySavedSearches objectAtIndex:0] objectForKey:@"MAXPRICE"] integerValue]/1000];
        }
    }
    labelBedrooms.text=[NSString stringWithFormat:@"%d or more",[[[arraySavedSearches objectAtIndex:0] objectForKey:@"BEDROOMS"] integerValue]];
    if(refine)
        arraySearchResult = [[NSMutableArray  alloc] initWithArray:arrayRefine];
//    else if(ssvc)
//    {
//        srcPtrn=[[SearchPattren alloc]init];
//        arraySearchResult=[[NSMutableArray alloc]initWithArray:srcPtrn.arrayResult];
//    }
    else if(home)
    {
        arraySearchResult = [[NSMutableArray  alloc] initWithArray:arraySearch];
        
    }
    [tableViewSearch reloadData];
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
    return 102;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arraySearchResult count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    searchCell *cell = (searchCell *)[tableView dequeueReusableCellWithIdentifier:@"searchCell"];
	if (!cell) 
	{
        //cell = [[ListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ListCell"];
        cell = [[[NSBundle mainBundle] loadNibNamed:@"searchCell" owner:self options:nil] lastObject] ;
	}
    
    [cell  addImage:[[arraySearchResult objectAtIndex:indexPath.row]objectForKey:@"main_ photo"]];
    
    [cell  addLabel:[NSString stringWithFormat:@"£%@",[[arraySearchResult objectAtIndex:indexPath.row]objectForKey:kprice]] withType:[NSString stringWithFormat:@"%@",[[arraySearchResult objectAtIndex:indexPath.row]objectForKey:kpricetype]] withBedRoom:[NSString stringWithFormat:@"%@ Bed Rooms",[[arraySearchResult objectAtIndex:indexPath.row]objectForKey:kbedrooms]] withDesc:[[arraySearchResult objectAtIndex:indexPath.row]objectForKey:kaddress]];
    //    cell.lablePrice.text=[NSString stringWithFormat:@"£%@",[[arraySearchResult objectAtIndex:indexPath.row]objectForKey:kprice]];
    //    cell.lablePricetype.text=[[arraySearchResult objectAtIndex:indexPath.row]objectForKey:kpricetype];
    //    cell.labelBedRoom.text=[NSString stringWithFormat:@"%@ Bed Rooms",[[arraySearchResult objectAtIndex:indexPath.row]objectForKey:kbedrooms]];
    //    cell.labelDescription.text=[[arraySearchResult objectAtIndex:indexPath.row]objectForKey:kaddress];
    //    
    cell.accessoryType = 1;
    
    return (UITableViewCell *)cell;
}    

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DetailViewController  *propertyViewController = [[DetailViewController  alloc] init];
    
    propertyViewController.dictResult = [arraySearchResult  objectAtIndex:indexPath.row];
    
    
    [self.navigationController  pushViewController:propertyViewController animated:YES];
    
}
#pragma marks-User Defined functions
-(IBAction)clickToSaveNavBarBtn:(id)sender
{
    [arraySavedSearchesForSaveBtn addObject:dictSaved];
    [ModalController saveTheContent:arraySavedSearchesForSaveBtn withKey:SAVESEARCHES]; 
    NSLog(@"********");
    ssvc=[[SavedSearchesViewController alloc]init];
    [ssvc setArraySavedSearchesResult:arraySavedSearchesForSaveBtn];
    [self.navigationController pushViewController:ssvc animated:YES];
    
}
-(IBAction)clickToHeaderBtn:(id)sender
{
    refine=[[RefineSearchViewController alloc]init];   
    arrayRefine=[[NSMutableArray alloc]initWithArray:arraySearchResult];
    [self.navigationController pushViewController:refine animated:YES];
}
-(IBAction)clickToBackBarBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
