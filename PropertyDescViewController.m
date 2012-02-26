//
//  PropertyDescViewController.m
//  PropertyApp
//
//  Created by saurav sinha on 26/02/12.
//  Copyright (c) 2012 sauravsinha007@gmail.com. All rights reserved.
//

#import "PropertyDescViewController.h"
#import "cellDescpImg.h"
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

-(IBAction)callAgent:(id)sender
{

}

-(IBAction)EmailAgent:(id)sender
{
    if ([MFMailComposeViewController canSendMail]) {
        
        MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
        mailViewController.mailComposeDelegate = self;
        [mailViewController setSubject:@"Subject "];
        [mailViewController setMessageBody:[NSString stringWithFormat:@"%@",[dictResult objectForKey:@"summary"]] isHTML:NO];
        
        [self presentModalViewController:mailViewController animated:YES];
        [mailViewController release];
        
    }
    
    else 
    {
        UIAlertView *alert  = [[UIAlertView  alloc] initWithTitle:@"Please configure Mail or this Device does not support Mail" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert  show];
        [alert  release];
    }
}

-(void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult :(MFMailComposeResult)result error :( NSError*)error 
{
    
    [self dismissModalViewControllerAnimated:YES];
    
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    self.navigationItem.title = TITLENAV;
    toolbar.tintColor = COLORBAC;
    self.navigationController.navigationBar.tintColor   = COLORBAC;
    self.view.backgroundColor = COLORBAC;
    NSLog(@"%@",dictResult);
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - UITableView Delegates
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 193;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;              // Default is 1 if not implemented
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
    
            cellDescpImg *cell = (cellDescpImg *)[tableView dequeueReusableCellWithIdentifier:@"cellDescpImg"];
            if (!cell) 
            {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"cellDescpImg" owner:self options:nil] lastObject] ;
            }
            cell.imageMain.placeholderImage = [UIImage  imageNamed:@"place_holder_small.jpg"];
            NSURL *imageUrl=[NSURL URLWithString:[dictResult objectForKey:@"thumb"]];
            cell.imageMain.imageURL=imageUrl;
            cell.labelAddress.text=[dictResult objectForKey:@"address"];
            cell.accessoryType=1;
            return cell;
           break;
        }
            
        default:
            break;
    }
   return nil;   
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 30;
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

@end
