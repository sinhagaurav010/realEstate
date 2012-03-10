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
#import "SearchPattren.h"

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
    self.navigationItem.hidesBackButton=NO;
   self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(clickToSaveNavBarBtn:)];
    // self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(clickToBackBarBtn:)];
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
    if([[[arraySavedSearches objectAtIndex:0]objectForKey:@"FOR"] isEqualToString:@"SALE"])
    {
        if([[[arraySavedSearches objectAtIndex:0]objectForKey:@"MINPRICE"] integerValue] ==0 && [[[arraySavedSearches objectAtIndex:0]objectForKey:@"MAXPRICE"] integerValue]==[MAXPRICE integerValue])
            labelPrice.text=@"Any Price";
        else if([[[arraySavedSearches objectAtIndex:0]objectForKey:@"MINPRICE"] integerValue] >0 && [[[arraySavedSearches objectAtIndex:0]objectForKey:@"MAXPRICE"] integerValue]==[MAXPRICE integerValue])
           labelPrice.text=[NSString stringWithFormat:@"£%dk and over",[[[arraySavedSearches objectAtIndex:0]objectForKey:@"MINPRICE"] integerValue]/1000];
        else   
            labelPrice.text=[NSString stringWithFormat:@"£%dk - £%dk ",[[[arraySavedSearches objectAtIndex:0]objectForKey:@"MINPRICE"] integerValue]/1000,[[[arraySavedSearches objectAtIndex:0]objectForKey:@"MAXPRICE"] integerValue]/1000];
    }
    else
    {
        if([[[arraySavedSearches objectAtIndex:0]objectForKey:@"MINPRICE"] integerValue] ==0 && [[[arraySavedSearches objectAtIndex:0]objectForKey:@"MAXPRICE"] integerValue]==[MAXPRICE integerValue])
            labelPrice.text=@"Any Price";
        else if([[[arraySavedSearches objectAtIndex:0]objectForKey:@"MINPRICE"] integerValue] >0 && [[[arraySavedSearches objectAtIndex:0]objectForKey:@"MAXPRICE"] integerValue]==[MAXPRICE integerValue])
            labelPrice.text=[NSString stringWithFormat:@"£%d and over",[[[arraySavedSearches objectAtIndex:0]objectForKey:@"MINPRICE"] integerValue]];
        else   
            labelPrice.text=[NSString stringWithFormat:@"£%d - £%d ",[[[arraySavedSearches objectAtIndex:0]objectForKey:@"MINPRICE"] integerValue],[[[arraySavedSearches objectAtIndex:0]objectForKey:@"MAXPRICE"] integerValue]];
    }
    NSLog(@"arraySavedSearches=%@",arraySavedSearches);
    labelBedrooms.text=[NSString stringWithFormat:@"%d or more",[[[arraySavedSearches objectAtIndex:0] objectForKey:@"BEDROOMS"] integerValue]];
    [self search];

    
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
    NSString *priceTemp;
    if([[[arraySearchResult objectAtIndex:indexPath.row]objectForKey:kprice] integerValue]>=10000)
       priceTemp=[NSString stringWithFormat:@"%d,000",[[[arraySearchResult objectAtIndex:indexPath.row]objectForKey:kprice]integerValue]/1000];   
    else
        priceTemp=[NSString stringWithFormat:@"%d",[[[arraySearchResult objectAtIndex:indexPath.row]objectForKey:kprice]integerValue]];
        
    [cell  addLabel:[NSString stringWithFormat:@"Price £%@",priceTemp] withType:[NSString stringWithFormat:@"%@",[[arraySearchResult objectAtIndex:indexPath.row]objectForKey:kpricetype]] withBedRoom:[NSString stringWithFormat:@"%@ Bedrooms",[[arraySearchResult objectAtIndex:indexPath.row]objectForKey:kbedrooms]] withDesc:[NSString stringWithFormat:@"%@, %@",[[arraySearchResult objectAtIndex:indexPath.row]objectForKey:kaddress],[[arraySearchResult objectAtIndex:indexPath.row]objectForKey:ktown]]];
    cell.accessoryType = 1;
    
    return (UITableViewCell *)cell;
}    

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DetailViewController  *propertyViewController = [[DetailViewController  alloc] init];
    NSLog(@"aaaaaaaa=%@",[arraySearchResult objectAtIndex:indexPath.row]);
    propertyViewController.dictResult = [self.arraySearchResult  objectAtIndex:indexPath.row];
    
    
    [self.navigationController  pushViewController:propertyViewController animated:YES];
    
}
#pragma marks-User Defined functions
-(void)search
{
   SearchPattren *searchPattern=[[SearchPattren alloc]init];
    [searchPattern searchPropertyWheretransaction_type:[[arraySavedSearches  objectAtIndex:0] objectForKey:@"FOR"] fromLocation:[[arraySavedSearches  objectAtIndex:0] objectForKey:@"LOCATION"] fromMinPrice:[[arraySavedSearches  objectAtIndex:0] objectForKey:@"MINPRICE"] toMaxPrice:[[arraySavedSearches  objectAtIndex:0] objectForKey:@"MAXPRICE"] withBedrooms:[[arraySavedSearches  objectAtIndex:0] objectForKey:@"BEDROOMS"] withSorting:[[arraySavedSearches  objectAtIndex:0] objectForKey:@"SORTBY"] arrangeWithOrder:[[arraySavedSearches  objectAtIndex:0] objectForKey:@"ORDERARRANGE"]   gpsEnabled:[[arraySavedSearches  objectAtIndex:0] objectForKey:@"GPSENABLED"] Inarray:arrayProperty];
    self.arraySearchResult=[[NSMutableArray alloc]initWithArray:searchPattern.arrayResult];
    [tableViewSearch reloadData];
    
}
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
