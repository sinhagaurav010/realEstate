//
//  PropertyDescViewController.m
//  PropertyApp
//
//  Created by saurav sinha on 26/02/12.
//  Copyright (c) 2012 sauravsinha007@gmail.com. All rights reserved.
//

#import "PropertyDescViewController.h"
#import "cellDescpImg.h"
#import "cellSummary.h"
#import "cellMapView.h"
#import "cellShowPhotos.h"
#import "EGOImageView.h"
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
    switch (indexPath.section) {
        case 0:
            return 193;
            break;
        case 2:
        {
            NSString *cellText =[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@,£%@           %@\n Reference:%d \n Description \n %@",[dictResult objectForKey:@"property_type"],[dictResult objectForKey:@"price"],[dictResult objectForKey:@"pricetype"],[[dictResult objectForKey:@"id"] integerValue],[dictResult objectForKey:ksummary]]];
            UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:15.0];
            CGSize constraintSize = CGSizeMake(280.0f, MAXFLOAT);
            CGSize labelSize = [cellText sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
            
            return labelSize.height + 50;
            break;
        }
        case 1:
        {
            return 88;
            break;
        }
        case 3:
        {
            return 314;
            break;
        }
        default:
            break;
    }
    return 44;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;              // Default is 1 if not implemented
{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
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
            NSURL *imageUrl=[NSURL URLWithString:[dictResult objectForKey:@"main_ photo"]];
            cell.imageMain.imageURL=imageUrl;
            cell.labelAddress.text=[dictResult objectForKey:@"address"];
            return cell;
            break;
        }
        case 2:
        {
            NSString *stringCell=@"cell";
            UITableViewCell *cell=(UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:stringCell];
            if(!cell)
            {
                cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:stringCell];
                
            }
            cell.textLabel.text=[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@" %@,£%@            %@\n Reference:%d \n Description \n %@",[dictResult objectForKey:@"property_type"],[dictResult objectForKey:@"price"],[dictResult objectForKey:@"pricetype"],[[dictResult objectForKey:@"id"] integerValue],[dictResult objectForKey:ksummary]]];
            cell.textLabel.textColor=[UIColor blackColor];
            cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
            cell.textLabel.numberOfLines = 0;
            cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
            cell.textLabel.backgroundColor=[UIColor clearColor];
            
            /*cellSummary *cell = (cellSummary *)[tableView dequeueReusableCellWithIdentifier:@"cellSummary"];
             if (!cell) 
             {
             cell = [[[NSBundle mainBundle] loadNibNamed:@"cellSummary" owner:self options:nil] lastObject] ;
             }
             cell.labelproperty_type.text=[NSString stringWithFormat:@"%@,£%@",[dictResult objectForKey:@"property_type"],[dictResult objectForKey:@"price"]];
             cell.labelpricetype.text=[dictResult objectForKey:@"pricetype"];
             cell.labelsummary.text=[dictResult objectForKey:@"summary"]; */
            return cell;
            break;  
        }
        case 1:
        {
            int countPhotos=0;
            cellShowPhotos *cell = (cellShowPhotos *)[tableView dequeueReusableCellWithIdentifier:@"cellShowPhotos"];
            if (!cell) 
            {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"cellShowPhotos" owner:self options:nil] lastObject] ;
            }
            for (int i=1; i<=12; i++) {
                if([[dictResult objectForKey:[NSString stringWithFormat:@"photo%d",i]] length]>0)
                {
                    countPhotos++;
                }
            }
           [cell.scrlView setContentSize:CGSizeMake(100*countPhotos,0)];
            int inX=0;
            for(int i=1;i<=countPhotos;i++)
            {
                UIView *aView=[[UIView alloc]initWithFrame:CGRectMake(inX, 10, 80,60)];
                [aView setBackgroundColor:[UIColor clearColor]];
                EGOImageView *imgEgo=[[EGOImageView alloc]initWithFrame:CGRectMake(0,0, 80,60)];
                [imgEgo setBackgroundColor:[UIColor clearColor]];
                NSURL *imageUrl=[NSURL URLWithString:[dictResult objectForKey:[NSString stringWithFormat:@"photo%d",i]]];
                imgEgo.imageURL=imageUrl;
                [aView addSubview:imgEgo];
                [cell.scrlView addSubview:aView];
                inX=inX+90;
                                 
            }

            return cell;
            break;
        }
        case 3:
        {
            cellMapView *cell = (cellMapView *)[tableView dequeueReusableCellWithIdentifier:@"cellMapView"];
            if (cell==nil) 
            {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"cellMapView" owner:self options:nil] lastObject] ;
            }
            
            cell.stringLat = [dictResult objectForKey:klatitude];
            cell.stringLong = [dictResult objectForKey:klongitude];
            
            [cell createMap];
            
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
    return 10;
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
