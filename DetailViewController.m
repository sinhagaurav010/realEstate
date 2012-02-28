//
//  DetailViewController.m
//  PropertyApp
//
//  Created by saurav sinha on 28/02/12.
//  Copyright (c) 2012 sauravsinha007@gmail.com. All rights reserved.
//

#import "DetailViewController.h"

@implementation DetailViewController
@synthesize dictResult,stringRightTitle;
@synthesize mpView,coordinate,stringLat,stringLong,stringDescSection4;


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
    NSString *string=[dictResult objectForKey:@"agent_telephone"];
    string=[string stringByReplacingOccurrencesOfString:@" " withString:@""];
    //NSLog(@"call string=%@",string);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat: @"tel:%@",string]]];
    
}

-(IBAction)EmailAgent:(id)sender
{
    if ([MFMailComposeViewController canSendMail]) {
        
        MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
        mailViewController.mailComposeDelegate = self;
        [mailViewController setSubject:@"Subject "];
        [mailViewController setMessageBody:[NSString stringWithFormat:@"%@",[dictResult objectForKey:@"description"]] isHTML:NO];
        
        [self presentModalViewController:mailViewController animated:YES];
        
    }
    
    else 
    {
        UIAlertView *alert  = [[UIAlertView  alloc] initWithTitle:@"Please configure Mail or this Device does not support Mail" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert  show];
    }
}

-(void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult :(MFMailComposeResult)result error :( NSError*)error 
{
    
    [self dismissModalViewControllerAnimated:YES];
    
}
-(void)save
{
    if([self.stringRightTitle isEqualToString:@"Save"])
    {
        [arraySavedProperty addObject:dictResult];
        self.navigationItem.rightBarButtonItem.title = @"Unsave";
        self.stringRightTitle = @"Unsave";
        
    }
    else
    {
        self.navigationItem.rightBarButtonItem.title = @"Save";
        self.stringRightTitle = @"Save";
        
        [arraySavedProperty  removeObjectAtIndex:savedAtIndex];
    }
    [ModalController  saveTheContent:arraySavedProperty withKey:SAVEDPROP];
    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    self.navigationItem.title = TITLENAV;
    toolbar.tintColor = COLORBAC;
    self.navigationController.navigationBar.tintColor   = COLORBAC;
    self.view.backgroundColor = COLORBAC;
    arraySavedProperty = [[NSMutableArray alloc] initWithArray:[ModalController getContforKey:SAVEDPROP]];
    
    
    ///for cell section 0
    imageMain=[[EGOImageView alloc]initWithFrame:CGRectMake(25, 11, 265, 145)];
    
    imageMain.placeholderImage = [UIImage  imageNamed:@"place_holder_small.jpg"];
    NSURL *imageUrl=[NSURL URLWithString:[dictResult objectForKey:@"main_ photo"]];
    imageMain.imageURL=imageUrl;
    
    labelAddress =[[UILabel alloc]initWithFrame:CGRectMake(25, 161, 270, 21)];
    [labelAddress setBackgroundColor:[UIColor clearColor]];
    labelAddress.text=[dictResult objectForKey:@"address"];

    ///for cell section 1
    for(int i=0;i<[arraySavedProperty   count];i++)
    {
        if([[[arraySavedProperty  objectAtIndex:i] objectForKey:kid] integerValue] ==[[dictResult objectForKey:kid] integerValue])
        {
            savedAtIndex = i;
            self.stringRightTitle = @"Unsave";   
            break;
        }
        else
            self.stringRightTitle = @"Save";   
        
    }
    arrayImages = [[NSMutableArray alloc] init];
    
    NSInteger countPhotos = 0; 
    scrlView=[[UIScrollView alloc]initWithFrame:CGRectMake(30, 0, 260, 87)];
    [scrlView setPagingEnabled:YES];
    for (int i=1; i<=12; i++) {
        if([[dictResult objectForKey:[NSString stringWithFormat:@"photo%d",i]] length]>0)
        {
            countPhotos++;
        }
    }
    [scrlView setContentSize:CGSizeMake(100*countPhotos,0)];
    int inX=0;
    for(int i=1;i<=countPhotos;i++)
    {
        //  UIView *aView=[[UIView alloc]initWithFrame:CGRectMake(inX, 10, 80,60)];
        //   [aView setBackgroundColor:[UIColor clearColor]];
        EGOImageView *imgEgo=[[EGOImageView alloc]initWithFrame:CGRectMake(inX,10, 80,60)];
        [imgEgo setBackgroundColor:[UIColor clearColor]];
        imgEgo.userInteractionEnabled = YES;
        imgEgo.tag = i;
        ////Put gesture recognizer
        UITapGestureRecognizer *singleTapOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        
        singleTapOne.numberOfTouchesRequired = 1; 
        //    singleTapOne.delegate = self;
        [imgEgo addGestureRecognizer:singleTapOne];
        [singleTapOne release];
        
        
        imgEgo.placeholderImage = [UIImage imageNamed:@"place_holder_small.jpg"];
        NSURL *imageUrl=[NSURL URLWithString:[dictResult objectForKey:[NSString stringWithFormat:@"photo%d",i]]];
        imgEgo.imageURL=imageUrl;
        [scrlView addSubview:imgEgo];
        
       
        
        [arrayImages addObject:imgEgo];
        
        //  [scrlView addSubview:aView];
        inX=inX+90;
        
    }


   
///for cell section 5
    self.mpView=[[MKMapView alloc]initWithFrame:CGRectMake(13, 3, 295, 307)];
    [self.mpView setUserInteractionEnabled:NO];
    self.stringLat = [dictResult objectForKey:klatitude];
    self.stringLong = [dictResult objectForKey:klongitude]; 
    [self createMap];
    
    ///for cell section 4
    imageMAin2=[[EGOImageView alloc]initWithFrame:CGRectMake(12, 42, 120, 90)];
    imageMAin2.placeholderImage = [UIImage imageNamed:@"place_holder_small.jpg"];
    imageUrl=[NSURL URLWithString:[dictResult objectForKey:@"agent_logo"]];
    imageMAin2.imageURL=imageUrl;
    
    
    
    labelAgentDescp =[[UILabel alloc]initWithFrame:CGRectMake(12, 13, 290, 21)];
    [labelAgentDescp setBackgroundColor:[UIColor clearColor]];
    labelAgentDescp.text=[NSString stringWithFormat:@"%@, %@",[dictResult objectForKey:@"selling_agent"],[dictResult objectForKey:@"town"]];
    
    l1 =[[UILabel alloc]initWithFrame:CGRectMake(162, 47, 100, 21)];
    [l1 setBackgroundColor:[UIColor clearColor]];
    l1.font=[UIFont boldSystemFontOfSize:15];
    l1.text=@"Telephone:";
    
    labeltelephone   = [[UILabel alloc]initWithFrame:CGRectMake(162, 70, 131, 21)];
    [labeltelephone setBackgroundColor:[UIColor clearColor]];
    labeltelephone.text=[dictResult objectForKey:@"agent_telephone"];
    
    
    ///for cell section 2
    self.stringDescSection4 = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@, £%@            %@\nReference: %d \n \nDescription: \n%@",[dictResult objectForKey:@"property_type"],[dictResult objectForKey:@"price"],[dictResult objectForKey:@"pricetype"],[[dictResult objectForKey:@"id"] integerValue],[dictResult objectForKey:ksummary]]];
    
    //NSLog(@"%@",dictResult);
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark -handleLongPressGesture-

-(void)handleSingleTap:(UILongPressGestureRecognizer*)sender 
{
    
//    if(UIGestureRecognizerStateEnded == sender.state)
//    {
        imageMain.imageURL = [(EGOImageView *)sender.view imageURL]  ;
    
        //        //NSLog(@"%d%@",[[sender view]tag],[[sender view] stringImageDes]);
        
//    }   
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:stringRightTitle style:UIBarButtonItemStyleDone target:self  action:@selector(save)];
    self.stringRightTitle = @"Save";
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
#pragma mark - UITableView Delegates
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            return 193;
            break;
        }
        case 1:
        {
            return 88;
            break;
        }
            
        case 2:
        {
            UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:15.0];
            CGSize constraintSize = CGSizeMake(280.0f, MAXFLOAT);
            CGSize labelSize = [self.stringDescSection4 sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
            
            return labelSize.height + 50;
            break;
        }
        case 3:
        {
            return 44;
            break;
        }
            
        case 4:
        {
            return 137;
            break;
        }
        case 5:
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
    return 6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"hi"] autorelease];
    }
    
    
    if(indexPath.section==0 )
    {
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
                
        [cell addSubview:imageMain];
        [cell addSubview:labelAddress];
        
    }
    else if(indexPath.section==1 )
    {
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        [cell  addSubview:scrlView];
    }
    
    else if(indexPath.section==2 )
    {
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        cell.textLabel.text= self.stringDescSection4;
        cell.textLabel.textColor=[UIColor blackColor];
        cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
        cell.textLabel.backgroundColor=[UIColor clearColor];
        
    }
    else if(indexPath.section==3  )
    {
        
        if([[dictResult objectForKey:@"property_brochure"] length]>0)
        {
            cell.textLabel.text=@"Schedule Available";
            cell.accessoryType=1;
        }
        else
        {
            cell.selectionStyle  = UITableViewCellSelectionStyleNone;
            cell.textLabel.text=@"Schedule Unavailable";
            cell.accessoryType=0;
        }
    }
    else if(indexPath.section==4 )
    {
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        
        [cell addSubview:imageMAin2];
        [cell addSubview:l1];
        [cell addSubview:labeltelephone];
        [cell addSubview:labelAgentDescp];
    }
    else  if(indexPath.section==5 )            
    {
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        [cell addSubview:self.mpView];
    }  
    
    return cell;   
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"in select =%d",indexPath.section);
    if(indexPath.section == 3)
    {
        
        if([[dictResult objectForKey:@"property_brochure"] length]>0)
        {
            BroucherViewController *bvc=[[BroucherViewController alloc]init];
            [bvc setStrUrlBroucher:[dictResult objectForKey:@"property_brochure"]];
            [self presentModalViewController:bvc animated:YES];
        }
        
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
#pragma mark - create MapView and UImKMapView delegates
-(void)createMap
{
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta=0.1;
    span.longitudeDelta=0.1;
    self.mpView.delegate = self;
    CLLocationCoordinate2D location=self.mpView.userLocation.coordinate;
    
    location.latitude=[self.stringLat floatValue];
    location.longitude=[self.stringLong floatValue];
    region.span=span;
    region.center=location;
    
    MyAnnotation *addAnnotation = [[MyAnnotation alloc] init]  ;
    [addAnnotation setCoordinate:location];
    
    /*Geocoder Stuff*/
    [self.mpView setRegion:region animated:TRUE];
    [self.mpView regionThatFits:region];
    
    [self.mpView addAnnotation:addAnnotation];
}

- (MKAnnotationView*)mapView:(MKMapView *)mapview viewForAnnotation:(id <MKAnnotation>)annotation
{
    NSString *string   =   @"hello";
    
	MKPinAnnotationView *annView = nil;
    
    if (annotation == mapview.userLocation) 
    {
        return nil;
    }
    
    
	annView = (MKPinAnnotationView *)[mapview dequeueReusableAnnotationViewWithIdentifier:string];
	MyAnnotation *annot = (MyAnnotation*)annotation;
	// If we have to, create a new view
	if(annView == nil)
    {
        // //////NSLog(@"here");
        annView = [[MKPinAnnotationView alloc] initWithAnnotation:annot reuseIdentifier:string];
        annView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        
        //annView.tag = annot.ann_tag;
    }
    //MKPinAnnotationView *annView=[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:string];  
	
	annView.canShowCallout = YES;  
	
	//[annView setSelected:YES];  	
	
    //annView.rightCalloutAccessoryView = 
	[annView setPinColor:MKPinAnnotationColorGreen];
	
	annView.calloutOffset = CGPointMake(-5, 5);
	annView.animatesDrop=NO; 
	return annView;
    ;
    
}

@end
