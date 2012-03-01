//
//  RefineSearchViewController.m
//  PropertyApp
//
//  Created by saurav sinha on 29/02/12.
//  Copyright (c) 2012 sauravsinha007@gmail.com. All rights reserved.
//

#import "RefineSearchViewController.h"
#import "constant.h"
#import "SearchResultViewController.h"
@implementation RefineSearchViewController
@synthesize strPickerSec1,strPickerSec2,arrayRefine,arrayPicker2,arrayPicker1;
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
    [self.navigationItem setTitle:TITLENAV];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"Search" style:UIBarButtonItemStyleBordered target:self action:@selector(clickTosearchBarBtn:)];
    self.arrayRefine=[[NSMutableArray alloc]initWithArray:arraySearch];
}
-(void)viewWillAppear:(BOOL)animated
{
    pickerViewRefine.hidden=YES;
    toolBarRefine.hidden=YES;
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
    return 44;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    if(indexPath.row==0)
    {
        cell.textLabel.text=@"Price Range";
        cell.detailTextLabel.text=[NSString stringWithFormat:@"£%dk - £%dk ",[strPriceMin integerValue]/1000,[strPriceMax integerValue]/1000];
    }
    if(indexPath.row==1)
    {
        cell.textLabel.text=@"Bedrooms";
        cell.detailTextLabel.text=[NSString stringWithFormat:@"%d or more",[strBedrooms integerValue]];
    }
    if(indexPath.row==2)
    {
        cell.textLabel.text= @"Sort By";
        cell.detailTextLabel.text=[NSString stringWithFormat:@"%@ %@",strSortBy,strAscending];
    }
    cell.textLabel.font=[UIFont boldSystemFontOfSize:14.0];
    cell.detailTextLabel.font=[UIFont boldSystemFontOfSize:14.0];
    cell.detailTextLabel.textColor=[UIColor grayColor];
    return cell;
}    

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger indexInPckSel1,indexInPckSel2;
    
    
    if (indexPath.row==0) {
        labelTitle.text=@"Price Range";
        self.arrayPicker1=[[NSMutableArray alloc]initWithObjects:@"0",@"50000",@"70000",@"85000",@"100000",@"115000",@"125000",@"135000",@"150000",@"160000",@"175000",@"185000",@"200000",@"225000",@"250000",@"275000",@"300000",@"325000",@"350000",@"350000",@"375000",@"400000",@"450000",@"500000",@"700000",@"1000000" ,nil];
        self.self.arrayPicker2=[[NSMutableArray alloc]initWithObjects:@"0",@"50000",@"70000",@"85000",@"100000",@"115000",@"125000",@"135000",@"150000",@"160000",@"175000",@"185000",@"200000",@"225000",@"250000",@"275000",@"300000",@"325000",@"350000",@"350000",@"375000",@"400000",@"450000",@"500000",@"700000",@"1000000" ,nil];
        for(int i=0;i< [self.arrayPicker1 count];i++)
        {
            if([[self.arrayPicker1 objectAtIndex:i] isEqualToString:strPriceMin])
                indexInPckSel1=i;
        }for(int i=0;i< [self.arrayPicker2 count];i++)
        {
            if([[self.self.arrayPicker1 objectAtIndex:i] integerValue]==[strPriceMax integerValue])
                indexInPckSel2=i;
        }
        [pickerViewRefine reloadAllComponents];
        [pickerViewRefine  selectRow:indexInPckSel1 inComponent:0 animated:NO];
        [pickerViewRefine  selectRow:indexInPckSel2 inComponent:1 animated:NO];
        strPickerSec1=strPriceMin;
        strPickerSec2=strPriceMax;
        
    } 
    if (indexPath.row==1) {
        NSLog(@"%d",[strBedrooms  integerValue] );
        labelTitle.text=@"Bedrooms";
        self.arrayPicker1=[[NSMutableArray alloc]initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5" ,nil];
        [pickerViewRefine reloadAllComponents];
        [pickerViewRefine  selectRow:[strBedrooms  integerValue] inComponent:0 animated:NO];
        strPickerSec1=strBedrooms;
        
    } 
    if (indexPath.row==2) {
        labelTitle.text=@"Sort By";
        self.arrayPicker1=[[NSMutableArray alloc]initWithObjects:@"price",@"bedrooms",nil];
        self.arrayPicker2=[[NSMutableArray alloc]initWithObjects:@"Ascending",@"Descending",nil];
        
        for(int i=0;i< [self.arrayPicker1 count];i++)
        {
            if([[self.arrayPicker1 objectAtIndex:i] isEqualToString:strSortBy])
                indexInPckSel1=i;
        }for(int i=0;i< [self.arrayPicker2 count];i++)
        {
            if([[self.arrayPicker2 objectAtIndex:i] isEqualToString:strAscending])
                indexInPckSel2=i;
        }
        [pickerViewRefine reloadAllComponents];
        [pickerViewRefine  selectRow:indexInPckSel1 inComponent:0 animated:NO];
        [pickerViewRefine  selectRow:indexInPckSel2 inComponent:1 animated:NO];
        strPickerSec1=strSortBy;
        strPickerSec2=strAscending;
    } 
    pickerViewRefine.hidden=NO;
    toolBarRefine.hidden=NO;
    tableViewRefine.userInteractionEnabled = NO;
    
    
}

#pragma mark - PickerView Delegate
// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if([labelTitle.text isEqualToString:@"Bedrooms"])
        return 1;
    else
        return 2;
}
// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if([labelTitle.text isEqualToString:@"Bedrooms"])
        return [self.arrayPicker1 count];
    
    else
    {
        if(component==0)
            return [self.arrayPicker1 count];
        else
            return [self.arrayPicker2 count];
    }
}
// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title;
    
    if(component==0)
        title=[self.arrayPicker1 objectAtIndex:row];
    else
        title=[self.arrayPicker2 objectAtIndex:row];
    return title;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    // Handle the selection
    
    if(component==0)
    {
        NSLog(@"selection picker view self.arrayPicker1 =====%@",[self.arrayPicker1 objectAtIndex:row]);
        self.strPickerSec1=[self.arrayPicker1 objectAtIndex:row];
        
    }
    else
    {
        NSLog(@"selection picker view self.arrayPicker2 =====%@",[self.arrayPicker2 objectAtIndex:row]);
        self.strPickerSec2=[self.arrayPicker2 objectAtIndex:row];
    }
}


#pragma mark-User Defined Functions
-(IBAction)clickToDoneToolBarBtn:(id)sender
{
    [self searchPropertyAfterRefining];
    pickerViewRefine.hidden=YES;
    toolBarRefine.hidden=YES;
    [self.arrayPicker1 removeAllObjects];
    [self.arrayPicker2 removeAllObjects];
    tableViewRefine.userInteractionEnabled = YES;

    
}
-(IBAction)clickToCancelToolBarBtn:(id)sender
{
    tableViewRefine.userInteractionEnabled = YES;
    [self.arrayPicker1 removeAllObjects];
    [self.arrayPicker2 removeAllObjects];
    pickerViewRefine.hidden=YES;
    toolBarRefine.hidden=YES;
}
-(void)searchPropertyAfterRefining
{
    NSLog(@"---------------------------");
    if([labelTitle.text isEqualToString:@"Price Range"])
    {
        
        strPriceMin=self.strPickerSec1;
        strPriceMax=self.strPickerSec2;
    }
    if([labelTitle.text isEqualToString:@"Bedrooms"])
    {
        strBedrooms=self.strPickerSec1;
    }
    if([labelTitle.text isEqualToString:@"Sort By"])
    {
        strSortBy=self.strPickerSec1;
        strAscending=self.strPickerSec2;
    }
    NSLog(@"minPrice=%d,maxPrice=%d,bedrooms=%d,sort by=%@,strAscending=%@",[strPriceMin integerValue],[strPriceMax integerValue],[strBedrooms integerValue],strSortBy,strAscending);
    NSLog(@"---------------------------");
    [tableViewRefine reloadData];
    
}
-(IBAction)clickTosearchBarBtn:(id)sender
{
    
    [self.arrayRefine removeAllObjects];
    NSLog(@"strBedrooms==%@",strBedrooms);
    for(int i=0;i<[arraySearch count];i++)
    {
        if([[[arraySearch objectAtIndex:i] objectForKey:kbedrooms] integerValue] > [strBedrooms integerValue] && (([[[arraySearch objectAtIndex:i] objectForKey:@"price"] integerValue]<[strPriceMax integerValue]) && ([[[arraySearch objectAtIndex:i] objectForKey:@"price"] integerValue]>[strPriceMin integerValue])))
        {
            [self.arrayRefine addObject:[arraySearch objectAtIndex:i]];  
        }
        
    }
    NSSortDescriptor *myDescriptor;
    if([strAscending isEqualToString:@"Descending"])
    {
        myDescriptor = [[NSSortDescriptor alloc] initWithKey:[NSString stringWithFormat:@"%@",strSortBy] ascending:NO];
    }
    else
    {
        myDescriptor = [[NSSortDescriptor alloc] initWithKey:[NSString stringWithFormat:@"%@",strSortBy] ascending:YES];   
    }
    [self.arrayRefine sortUsingDescriptors:[NSArray arrayWithObject:myDescriptor]];
    NSLog(@"array refine=%@",arrayRefine);
    NSLog(@"array refine count=%d",[arrayRefine count]);
    //    SearchResultViewController *srvc=[[SearchResultViewController alloc]init];
    //    [srvc setArraySearchResult:arrayRefine];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
