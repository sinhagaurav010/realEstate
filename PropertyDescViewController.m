//
//  PropertyDescViewController.m
//  PropertyApp
//
//  Created by saurav sinha on 26/02/12.
//  Copyright (c) 2012 sauravsinha007@gmail.com. All rights reserved.
//

#import "PropertyDescViewController.h"

@implementation PropertyDescViewController
@synthesize dictResult;
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
    NSLog(@"%@",dictResult);
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

//#pragma mark - UITableView Delegates
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 102;
//}
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return [arraySearch count];
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    searchCell *cell = (searchCell *)[tableView dequeueReusableCellWithIdentifier:@"searchCell"];
//	if (!cell) 
//	{
//        //cell = [[ListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ListCell"];
//        cell = [[[NSBundle mainBundle] loadNibNamed:@"searchCell" owner:self options:nil] lastObject] ;
//	}
//    
//    cell.imageMain.placeholderImage = [UIImage  imageNamed:@"place_holder_small.jpg"];
//    NSURL *imageUrl=[NSURL URLWithString:[[arraySearch objectAtIndex:indexPath.row]objectForKey:@"thumb"]];
//    cell.imageMain.imageURL=imageUrl;
//    
//    cell.lablePrice.text=[NSString stringWithFormat:@"£%@",[[arraySearch objectAtIndex:indexPath.row]objectForKey:@"price"]];
//    cell.lablePricetype.text=[[arraySearch objectAtIndex:indexPath.row]objectForKey:@"pricetype"];
//    cell.labelBedRoom.text=[NSString stringWithFormat:@"%@ Bed Rooms",[[arraySearch objectAtIndex:indexPath.row]objectForKey:@"bedrooms"]];
//    cell.labelDescription.text=[[arraySearch objectAtIndex:indexPath.row]objectForKey:@"address"];
//    cell.accessoryType=1;
//    return (UITableViewCell *)cell;
//    
//    
//}    


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

@end
