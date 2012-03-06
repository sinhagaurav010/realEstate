//
//  SavePropertyViewController.m
//  PropertyApp
//
//  Created by saurav sinha on 06/03/12.
//  Copyright (c) 2012 sauravsinha007@gmail.com. All rights reserved.
//

#import "SavePropertyViewController.h"

@implementation SavePropertyViewController
@synthesize arraySaveProResult;
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
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.title = TITLENAV;
    self.navigationController.navigationBar.tintColor   = COLORBAC;
    self.navigationController.navigationBarHidden=NO;
    self.navigationItem.hidesBackButton=NO;
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"Edit" style:UIBarButtonItemStyleBordered target:self action:@selector(clickToEditBarBtn:)];
   
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
    return [arraySaveProResult count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    searchCell *cell = (searchCell *)[tableView dequeueReusableCellWithIdentifier:@"searchCell"];
	if (!cell) 
	{
        //cell = [[ListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ListCell"];
        cell = [[[NSBundle mainBundle] loadNibNamed:@"searchCell" owner:self options:nil] lastObject] ;
	}
    
    [cell  addImage:[[arraySaveProResult objectAtIndex:indexPath.row]objectForKey:@"main_ photo"]];
    
    [cell  addLabel:[NSString stringWithFormat:@"£%@",[[arraySaveProResult objectAtIndex:indexPath.row]objectForKey:kprice]] withType:[NSString stringWithFormat:@"%@",[[arraySaveProResult objectAtIndex:indexPath.row]objectForKey:kpricetype]] withBedRoom:[NSString stringWithFormat:@"%@ Bedrooms",[[arraySaveProResult objectAtIndex:indexPath.row]objectForKey:kbedrooms]] withDesc:[[arraySaveProResult objectAtIndex:indexPath.row]objectForKey:kaddress]];
    //    cell.lablePrice.text=[NSString stringWithFormat:@"£%@",[[arraySearchResult objectAtIndex:indexPath.row]objectForKey:kprice]];
    //    cell.lablePricetype.text=[[arraySearchResult objectAtIndex:indexPath.row]objectForKey:kpricetype];
    //    cell.labelBedRoom.text=[NSString stringWithFormat:@"%@ Bed Rooms",[[arraySearchResult objectAtIndex:indexPath.row]objectForKey:kbedrooms]];
    //    cell.labelDescription.text=[[arraySearchResult objectAtIndex:indexPath.row]objectForKey:kaddress];
    //    
    if(self.navigationItem.rightBarButtonItem.title==@"Edit")
        cell.accessoryType=1;
    else
        cell.accessoryType=0;

    
    return (UITableViewCell *)cell;
}    

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DetailViewController  *propertyViewController = [[DetailViewController  alloc] init];
    NSLog(@"aaaaaaaa=%@",[arraySaveProResult objectAtIndex:indexPath.row]);
    propertyViewController.dictResult = [self.arraySaveProResult  objectAtIndex:indexPath.row];
    
    
    [self.navigationController  pushViewController:propertyViewController animated:YES];
    
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // If row is deleted, remove it from the list.
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // If I comment this line out the delete works but I no longer have the animation
        [arraySaveProResult removeObjectAtIndex:indexPath.row];
        [tableViewSaveProp deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [ModalController saveTheContent:arraySaveProResult withKey:SAVEDPROP];
        [tableViewSaveProp reloadData];
        
    }
    
}

-(IBAction)clickToEditBarBtn:(id)sender
{
    if([self.navigationItem.rightBarButtonItem.title isEqualToString:@"Edit"])
    {
        [tableViewSaveProp setEditing:YES];
        self.navigationItem.rightBarButtonItem.title=@"Done";
        [tableViewSaveProp reloadData];
    }
    else
    {
        [tableViewSaveProp setEditing:NO];
        self.navigationItem.rightBarButtonItem.title=@"Edit"; 
        [tableViewSaveProp reloadData];
    }
    
}
@end
