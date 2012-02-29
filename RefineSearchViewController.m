//
//  RefineSearchViewController.m
//  PropertyApp
//
//  Created by saurav sinha on 29/02/12.
//  Copyright (c) 2012 sauravsinha007@gmail.com. All rights reserved.
//

#import "RefineSearchViewController.h"
#import "constant.h"

@implementation RefineSearchViewController

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
    cell.detailTextLabel.text=strPrice;
    }
    if(indexPath.row==1)
    {
        cell.textLabel.text=@"Bedrooms";
       cell.detailTextLabel.text=strBedrooms;
    }
    if(indexPath.row==2)
    {
        cell.textLabel.text= @"Sort By";
        cell.detailTextLabel.text=strSortBy;
    }
    cell.detailTextLabel.textColor=[UIColor grayColor];
       return cell;
}    

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row==0) {
        labelTitle.text=@"Price Range";
        arrayPicker1=[[NSMutableArray alloc]initWithObjects:@"0",@"50000",@"70000",@"85000",@"10000" ,nil];
        arrayPicker2=[[NSMutableArray alloc]initWithObjects:@"0",@"50000",@"70000",@"85000",@"10000" ,nil];
    } 
    if (indexPath.row==1) {
        labelTitle.text=@"Bedrooms";
        arrayPicker1=[[NSMutableArray alloc]initWithObjects:@"0 or more",@"2  or more",@"3 or more",@"4  or more",@"5 or more" ,nil];
    } 
    if (indexPath.row==2) {
        labelTitle.text=@"Sort By";
        arrayPicker1=[[NSMutableArray alloc]initWithObjects:@"Price",@"Bedrooms",nil];
        arrayPicker2=[[NSMutableArray alloc]initWithObjects:@"Ascending",@"Descending" ,nil];
    } 
    pickerViewRefine.hidden=NO;
    toolBarRefine.hidden=NO;
    [pickerViewRefine reloadAllComponents];
}

#pragma mark - PickerView Delegate
// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if(labelTitle.text==@"Bedrooms")
    return 1;
    else
        return 2;
}
// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if(labelTitle.text==@"Bedrooms")
        return [arrayPicker1 count];
        
    else
    {
    if(component==0)
        return [arrayPicker1 count];
    else
        return [arrayPicker2 count];
    }
}
// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title;
    
    if(component==0)
    title=[arrayPicker1 objectAtIndex:row];
    else
        title=[arrayPicker2 objectAtIndex:row];
    return title;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    // Handle the selection
    if(component==0)
    {
    NSLog(@"selection picker view arrayPicker1 =====%@",[arrayPicker1 objectAtIndex:row]);
    }
    else
    {
         NSLog(@"selection picker view arrayPicker2 =====%@",[arrayPicker2 objectAtIndex:row]); 
    }
   // [self setSelectCatageory:[arrayPicker1 objectAtIndex:row]];
    
}

// tell the picker the width of each row for a given component
//- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
//    int sectionWidth = 300;
//    return sectionWidth;
//}

#pragma mark-User Defined Functions
-(IBAction)clickTosearchBarBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)clickToDoneToolBarBtn:(id)sender
{
    pickerViewRefine.hidden=YES;
    toolBarRefine.hidden=YES;
}
-(IBAction)clickToCancelToolBarBtn:(id)sender
{
    pickerViewRefine.hidden=YES;
    toolBarRefine.hidden=YES;
}
-(void)searchPropertyAfterRefining
{
    
}
@end
