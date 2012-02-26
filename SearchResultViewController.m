//
//  SearchResultViewController.m
//  PropertyApp
//
//  Created by saurav sinha on 26/02/12.
//  Copyright (c) 2012 sauravsinha007@gmail.com. All rights reserved.
//

#import "SearchResultViewController.h"
#import "searchCell.h"
@implementation SearchResultViewController
@synthesize arraySearch;

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
    self.view.backgroundColor   = COLORBAC;
    self.navigationController.navigationBar.tintColor   = COLORBAC;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [tableViewSearch reloadData];
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
    return [arraySearch count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    searchCell *cell = (searchCell *)[tableView dequeueReusableCellWithIdentifier:@"searchCell"];
	if (!cell) 
	{
        //cell = [[ListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ListCell"];
        cell = [[[NSBundle mainBundle] loadNibNamed:@"searchCell" owner:self options:nil] lastObject] ;
	}
    
    cell.imageMain.placeholderImage = [UIImage  imageNamed:@"place_holder_small.jpg"];
    NSURL *imageUrl=[NSURL URLWithString:[[arraySearch objectAtIndex:indexPath.row]objectForKey:@"thumb"]];
    cell.imageMain.imageURL=imageUrl;
    cell.lablePrice.text=[NSString stringWithFormat:@"£%@",[[arraySearch objectAtIndex:indexPath.row]objectForKey:@"price"]];
    cell.lablePricetype.text=[[arraySearch objectAtIndex:indexPath.row]objectForKey:@"pricetype"];
    cell.labelBedRoom.text=[NSString stringWithFormat:@"%@ Bed Rooms",[[arraySearch objectAtIndex:indexPath.row]objectForKey:@"bedrooms"]];
    cell.labelDescription.text=[[arraySearch objectAtIndex:indexPath.row]objectForKey:@"address"];
    return (UITableViewCell *)cell;
}    

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PropertyDescViewController  *propertyViewController = [[PropertyDescViewController  alloc] init];
    
    propertyViewController.dictResult = [arraySearch  objectAtIndex:indexPath.row];
    
    
    [self.navigationController  pushViewController:propertyViewController animated:YES];
    
    [propertyViewController release];
    
   /* DetailViewController *detail=[[DetailViewController alloc]init];
    [detail setPidNo:[[arrayHome objectAtIndex:indexPath.row]objectForKey:@"PID"]];
    [self.navigationController pushViewController:detail animated:YES];
    [detail release]; */
    
}

@end
