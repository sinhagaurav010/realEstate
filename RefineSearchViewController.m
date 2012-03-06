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
@synthesize strPickerSec1,strPickerSec2,arrayPicker2,arrayPicker1;

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
    labelTitle.frame = CGRectMake(110, 10, labelTitle.frame.size.width, labelTitle.frame.size.height);
    [toolBarRefine  addSubview:labelTitle];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationItem setTitle:TITLENAV];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"Search" style:UIBarButtonItemStyleBordered target:self action:@selector(clickTosearchBarBtn:)];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(clickToCancelNavBtn:)];
    //  arrayRefine=[[NSMutableArray alloc]initWithArray:arrayRefineFromSearchResult];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.hidesBackButton=YES;
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
    if([strGPS isEqualToString:@"GPS"])
        return 4;
    else
        return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    NSLog(@"***********************************");
    NSLog(@"minPrice=%d,maxPrice=%d,bedrooms=%d,sort by=%@,strAscending=%@,strRadius=%f",[strPriceMin integerValue],[strPriceMax integerValue],[strBedrooms integerValue],strSortBy,strAscending,[strRadius floatValue]);
    NSLog(@"***********************************");

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    if(indexPath.row==0)
    {
        cell.textLabel.text=@"Price Range";
        if([strFor isEqualToString:@"SALE"])
        {
            cell.detailTextLabel.text=[NSString stringWithFormat:@"£%dk - £%dk ",[strPriceMin integerValue]/1000,[strPriceMax integerValue]/1000];
        }
        else
        {
             cell.detailTextLabel.text=[NSString stringWithFormat:@"£%d - £%d ",[strPriceMin integerValue],[strPriceMax integerValue]];
        }
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
    if(indexPath.row==3)
    {
        cell.textLabel.text= @"Radius";
        cell.detailTextLabel.text=[NSString stringWithFormat:[NSString stringWithFormat:@"%@ KM",strRadius]];
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
        if([strFor isEqualToString:@"SALE"])
        {
            self.arrayPicker1=[[NSMutableArray alloc]initWithObjects:@"0",@"50000",@"70000",@"85000",@"100000",@"115000",@"125000",@"135000",@"150000",@"160000",@"175000",@"185000",@"200000",@"225000",@"250000",@"275000",@"300000",@"325000",@"350000",@"375000",@"400000",@"450000",@"500000",@"700000",@"1000000" ,nil];
            self.arrayPicker2=[[NSMutableArray alloc]initWithObjects:@"0",@"50000",@"70000",@"85000",@"100000",@"115000",@"125000",@"135000",@"150000",@"160000",@"175000",@"185000",@"200000",@"225000",@"250000",@"275000",@"300000",@"325000",@"350000",@"375000",@"400000",@"450000",@"500000",@"700000",@"1000000" ,nil];
        }
        else
        {
            self.arrayPicker1=[[NSMutableArray alloc]initWithObjects:@"0",@"250",@"300",@"400",@"500",@"600",@"700",@"800",@"1000",nil];
             self.arrayPicker2=[[NSMutableArray alloc]initWithObjects:@"0",@"250",@"300",@"400",@"500",@"600",@"700",@"800",@"1000",nil];
            
        }
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
        
        [pickerViewRefine  selectRow:0 inComponent:0 animated:NO];
        [pickerViewRefine  selectRow:0 inComponent:1 animated:NO];
        strPickerSec1=strPriceMin;
        strPickerSec2=strPriceMax;
        
    } 
    if (indexPath.row==1) {
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
    if (indexPath.row==3) {
        labelTitle.text=@"Radius";
        self.arrayPicker1=[[NSMutableArray alloc]initWithObjects:@"1.0",@"2.0",@"3.0",@"4.0",@"5.0",@"6.0",@"7.0",@"8.0",@"9.0",@"10.79",nil];
        for(int i=0;i< [self.arrayPicker1 count];i++)
        {
            if([[self.arrayPicker1 objectAtIndex:i] isEqualToString:strRadius])
                indexInPckSel1=i;
        }
        [pickerViewRefine reloadAllComponents];
        [pickerViewRefine  selectRow:indexInPckSel1 inComponent:0 animated:NO];
        strPickerSec1=strRadius;
    }
    pickerViewRefine.hidden=NO;
    toolBarRefine.hidden=NO;
    tableViewRefine.userInteractionEnabled = NO;
    
    
}

#pragma mark - PickerView Delegate
// tell the picker how many components it will have
-(void)changePicker
{
    if([labelTitle.text isEqualToString:@"Price Range"])
    {
        [self.arrayPicker2 removeAllObjects];
        self.arrayPicker2=[[NSMutableArray alloc]init];
        for(int i=0;i< [self.arrayPicker1 count];i++)
        {
            if(i==0)
                [arrayPicker2 addObject:[arrayPicker1 objectAtIndex:0]];
              else if([self.strPickerSec1 integerValue]<=[[arrayPicker1 objectAtIndex:i] integerValue])
                [arrayPicker2 addObject:[arrayPicker1 objectAtIndex:i]];
        }
    }
   // NSLog(@"array picker2=%@",arrayPicker2);
    [pickerViewRefine  selectRow:0 inComponent:1 animated:NO];
    [pickerViewRefine reloadComponent:1];
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if([labelTitle.text isEqualToString:@"Bedrooms"])
        return 1;
    else if([labelTitle.text isEqualToString:@"Radius"])
        return 1;
    else
        return 2;
}
// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if([labelTitle.text isEqualToString:@"Bedrooms"])
        return [self.arrayPicker1 count];
    else if([labelTitle.text isEqualToString:@"Radius"])
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
    if([labelTitle.text isEqualToString:@"Bedrooms"])
    {
        title=[NSString stringWithFormat:@"%@ or more",[self.arrayPicker1 objectAtIndex:row]];   
    }
    else if ([labelTitle.text isEqualToString:@"Radius"])
        title=[NSString stringWithFormat:@"%@ KM",[self.arrayPicker1 objectAtIndex:row]];
    else
    {
        if(component==0)
            title=[self.arrayPicker1 objectAtIndex:row];
        else
            title=[self.arrayPicker2 objectAtIndex:row];
    }
    return title;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    // Handle the selection
    if([labelTitle.text isEqualToString:@"Price Range"])
    {
        if(component==0)
        {
            
            self.strPickerSec1=[self.arrayPicker1 objectAtIndex:row];
            [self changePicker];
        }
        else
        {
            self.strPickerSec2=[self.arrayPicker2 objectAtIndex:row];
            
        }
    }
    else
    {
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
}


#pragma mark-User Defined Functions
-(IBAction)clickToDoneToolBarBtn:(id)sender
{
    NSLog(@"strPickerSec1=%@",self.strPickerSec1);
    NSLog(@"strPickerSec2=%@",self.strPickerSec2);

    [self searchPropertyAfterRefining];
    pickerViewRefine.hidden=YES;
    toolBarRefine.hidden=YES;
    [self.arrayPicker1 removeAllObjects];
    [self.arrayPicker2 removeAllObjects];
    self.strPickerSec1 =nil;
    self.strPickerSec2=nil;
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
        if([strPriceMax integerValue]==0)
        {
            if([strFor isEqualToString:@"SALE"])
            strPriceMax=@"1000001";
            else
                strPriceMax=@"1000";
                
        }
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
    if([labelTitle.text isEqualToString:@"Radius"])
    {
        strRadius=self.strPickerSec1;
    }
    NSLog(@"minPrice=%d,maxPrice=%d,bedrooms=%d,sort by=%@,strAscending=%@,strRadius=%f",[strPriceMin integerValue],[strPriceMax integerValue],[strBedrooms integerValue],strSortBy,strAscending,[strRadius floatValue]);
    NSLog(@"---------------------------");
    [tableViewRefine reloadData];
    
}
-(IBAction)clickTosearchBarBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
  
}
-(IBAction)clickToCancelNavBtn:(id)sender;
{
    //NSLog(@"array refine=%@",arrayRefine);
    NSLog(@"array refine count=%d",[arrayRefine count]);
    strPriceMin=[[arraySavedSearches objectAtIndex:0]objectForKey:@"MINPRICE"];
    strPriceMax=[[arraySavedSearches objectAtIndex:0]objectForKey:@"MAXPRICE"];
    strBedrooms=[[arraySavedSearches objectAtIndex:0]objectForKey:@"BEDROOMS"];
    strAscending=[[arraySavedSearches objectAtIndex:0]objectForKey:@"ORDERARRANGE"];
    strSortBy=[[arraySavedSearches objectAtIndex:0]objectForKey:@"SORTBY"];
    strRadius=[[arraySavedSearches objectAtIndex:0]objectForKey:@"RADIUS"];
    [self.navigationController popViewControllerAnimated:YES];
    
    
}


@end
