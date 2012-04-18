//
//  DetailViewController.m
//  PropertyApp
//
//  Created by saurav sinha on 28/02/12.
//  Copyright (c) 2012 sauravsinha007@gmail.com. All rights reserved.
//

#import "DetailViewController.h"
#define PADDING 10

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
        [mailViewController setSubject:@"A Property I found"];
        //        NSString *strHtml=[NSString stringWithFormat:@"<html><head><title></title></head><body> %@ </br> </br><a href='%@'>%@</a></body></html>",[dictResult objectForKey:@"description"],[dictResult objectForKey:kproperty_brochure],[dictResult objectForKey:kproperty_brochure]];  
        //         [mailViewController setMessageBody:strHtml isHTML:YES];
        [mailViewController setMessageBody:[NSString stringWithFormat:@"%@ \n\n%@",[dictResult objectForKey:@"description"],[dictResult objectForKey:kproperty_brochure]] isHTML:NO];
        
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
    
    NSLog(@"in detail view controller");
    currentPageIndex=0;
    self.navigationItem.title = TITLENAV;
    toolbar.tintColor = COLORBAC;
    self.navigationController.navigationBar.tintColor   = COLORBAC;
    self.view.backgroundColor = COLORBAC;
    arraySavedProperty = [[NSMutableArray alloc] initWithArray:[ModalController getContforKey:SAVEDPROP]];
    self.stringRightTitle = @"Save"; 
    
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
    
    self.navigationItem.rightBarButtonItem.title = self.stringRightTitle;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:stringRightTitle style:UIBarButtonItemStyleDone target:self  action:@selector(save)];
    
    // NSLog(@"arraySavedProperty=%@",arraySavedProperty  );
    
    ///for cell section 0
    imageMain=[[EGOImageView alloc]initWithFrame:CGRectMake(40,8 ,245, 155)];
    
    imageMain.placeholderImage = [UIImage  imageNamed:@"place_holder_small.jpg"];
    NSURL *imageUrl=[NSURL URLWithString:[dictResult objectForKey:@"main_ photo"]];
    imageMain.imageURL=imageUrl;
    
    labelAddress =[[UILabel alloc]initWithFrame:CGRectMake(30, 163, 270, 40)];
    [labelAddress setBackgroundColor:[UIColor clearColor]];
    labelAddress.font = [UIFont systemFontOfSize:15];  
    labelAddress.numberOfLines = 2;  
    labelAddress.lineBreakMode = UILineBreakModeWordWrap; 
    labelAddress.text=[NSString stringWithFormat:@"%@, %@",[dictResult objectForKey:kaddress],[dictResult objectForKey:ktown]];
    
    ///for cell section 1 
    arrayImages = [[NSMutableArray alloc] init];
    
    countPhotos = 0; 
    scrlView=[[UIScrollView alloc]initWithFrame:CGRectMake(30, 0, 265, 87)];
    [scrlView setPagingEnabled:YES];
    [scrlView setDelegate:self];
    for (int i=1; i<=12; i++) {
        if([[dictResult objectForKey:[NSString stringWithFormat:@"photo%d",i]] length]>0)
        {
            if([[dictResult objectForKey:[NSString stringWithFormat:@"photo%d",i]] isEqualToString:@"http://www.bspc.co.uk/propertyphotos/phototh.jpg"])
            {
                
            }
            else
                countPhotos++;
        }
    }
    [scrlView setContentSize:CGSizeMake(90*(countPhotos+1),0)];
    NSLog(@"scrlView setContentSize = %f",scrlView.contentSize.width);
    int inX=0;
    for(int i=1;i<=countPhotos+1;i++)
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
        //  [singleTapOne release];
        NSURL *imageUrl;
        imgEgo.placeholderImage = [UIImage imageNamed:@"place_holder_small.jpg"];
        if(i==countPhotos+1)
        {
            imageUrl=[NSURL URLWithString:[dictResult objectForKey:kmain_photo]];
        } 
        else
        {
            
            imageUrl=[NSURL URLWithString:[dictResult objectForKey:[NSString stringWithFormat:@"photo%d",i]]];
        }
        imgEgo.imageURL=imageUrl;
        [scrlView addSubview:imgEgo];
        [arrayImages addObject:imgEgo];
        
        
        //  [scrlView addSubview:aView];
        inX=inX+90;
        
    }
    temp=(int)ceil(countPhotos/3.0);
    NSLog(@"temp=%d",temp);
    ///for cell section 2
    
    if([[dictResult objectForKey:kprice] integerValue]>=10000)
        priceTemp=[NSString stringWithFormat:@"%d,000",[[dictResult objectForKey:kprice]integerValue]/1000];   
    else
        priceTemp=[NSString stringWithFormat:@"%d",[[dictResult objectForKey:kprice]integerValue]];
    self.stringDescSection4 = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"\n\n\n\n%@",[dictResult objectForKey:ksummary]]];
    
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
    
    ///for cell section 5
    self.mpView=[[MKMapView alloc]initWithFrame:CGRectMake(13, 3, 295, 307)];
    [self.mpView setUserInteractionEnabled:NO];
    self.stringLat = [dictResult objectForKey:klatitude];
    self.stringLong = [dictResult objectForKey:klongitude]; 
    [self createMap];
    
    
    
    
    
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
            return 205;
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
            labelSize = [self.stringDescSection4 sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
            
            return labelSize.height + 50; 
            //return webViewDescp.frame.size.height;
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"hi"];
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
        leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [leftBtn setFrame:CGRectMake(10, 35, 15,15)];
        [leftBtn setTitle:@"<" forState:UIControlStateNormal];
        [leftBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [leftBtn addTarget:self action:@selector(gotoPreviousPage) forControlEvents:UIControlEventTouchUpInside];
        
        rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [rightBtn setFrame:CGRectMake(295, 35, 15,15)];
        [rightBtn setTitle:@">" forState:UIControlStateNormal];
        [rightBtn addTarget:self action:@selector(gotoNextPage) forControlEvents:UIControlEventTouchUpInside];
        [rightBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        //        [cell addSubview:rightBtn];
        //        [cell addSubview:leftBtn];
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
        
        UILabel *labelDescription=[[UILabel alloc]initWithFrame:CGRectMake(20, 70, 100, 20)];
        labelDescription.font=[UIFont fontWithName:@"Helvetica-Bold" size:15.0];
        [labelDescription setBackgroundColor:[UIColor clearColor]];
        [labelDescription setText:@"Description:"];
        
        UILabel *labelProperty_type=[[UILabel alloc]initWithFrame:CGRectMake(20, 10, 130, 20)];
        labelProperty_type.font=[UIFont fontWithName:@"Helvetica" size:15.0];
        [labelProperty_type setBackgroundColor:[UIColor clearColor]];
        labelProperty_type.adjustsFontSizeToFitWidth=YES;
        [labelProperty_type setText:[NSString stringWithFormat:@"%@,  £%@",[dictResult objectForKey:@"property_type"],priceTemp]];
        
        UILabel *labelPriceType=[[UILabel alloc]initWithFrame:CGRectMake(170, 10, 100, 20)];
        labelPriceType.font=[UIFont fontWithName:@"Helvetica" size:15.0];
        [labelPriceType setBackgroundColor:[UIColor clearColor]];
        labelPriceType.adjustsFontSizeToFitWidth=YES;
        [labelPriceType setText:[NSString stringWithFormat:@"%@",[dictResult objectForKey:kpricetype]]];
        UILabel *labelReference=[[UILabel alloc]initWithFrame:CGRectMake(20, 40, 200, 20)];
        labelReference.font=[UIFont fontWithName:@"Helvetica" size:15.0];
        [labelReference setBackgroundColor:[UIColor clearColor]];
        labelReference.adjustsFontSizeToFitWidth=YES;
        [labelReference setText:[NSString stringWithFormat:@"Reference: %d",[[dictResult objectForKey:@"id"]integerValue]]];
        
        [cell addSubview:labelPriceType];
        [cell addSubview:labelReference];
        [cell addSubview:labelProperty_type];
        [cell addSubview:labelDescription];
        
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
    span.latitudeDelta=0.05;
    span.longitudeDelta=0.05;
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
}

#pragma marks-UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	if([scrollView isEqual:scrlView])
    {
        [self tilePages];
        
        // Calculate current page
        CGRect visibleBounds = scrlView.bounds;
        int index = (int)(floorf(CGRectGetMidX(visibleBounds) / CGRectGetWidth(visibleBounds)));
        if (index < 0) index = 0;
        if (index > countPhotos- 1) index = countPhotos - 1;
        currentPageIndex = index;
        //NSLog(@"page No=%d",currentPageIndex);
        if (currentPageIndex >= temp-1) {
            rightBtn.enabled=NO;
        }
        else
        {
            rightBtn.enabled=YES;
            
        }
        
        if(currentPageIndex==0)
            leftBtn.enabled=NO;
        else
            leftBtn.enabled=YES;
    }
    
	
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    //if (performingLayout || rotating) return;
	
	// Tile pages
    
}
#pragma mark -
#pragma mark Paging

- (void)tilePages {
	
	// Calculate which pages should be visible
	// Ignore padding as paging bounces encroach on that
	// and lead to false page loads
	CGRect visibleBounds = scrlView.bounds;
	int iFirstIndex = (int)floorf((CGRectGetMinX(visibleBounds)+PADDING*countPhotos) / CGRectGetWidth(visibleBounds));
	int iLastIndex  = (int)floorf((CGRectGetMaxX(visibleBounds)-PADDING*countPhotos-1) / CGRectGetWidth(visibleBounds));
    if (iFirstIndex < 0) iFirstIndex = 0;
    if (iFirstIndex > countPhotos - 1) iFirstIndex = countPhotos - 1;
    if (iLastIndex < 0) iLastIndex = 0;
    if (iLastIndex > countPhotos - 1) iLastIndex = countPhotos - 1;
	
	// Recycle no longer needed pages
	
	[visiblePages minusSet:recycledPages];
	
	// Add missing pages
	
	
}
- (CGRect)frameForPageAtIndex:(NSUInteger)index {
    // We have to use our paging scroll view's bounds, not frame, to calculate the page placement. When the device is in
    // landscape orientation, the frame will still be in portrait because the pagingScrollView is the root view controller's
    // view, so its frame is in window coordinate space, which is never rotated. Its bounds, however, will be in landscape
    // because it has a rotation transform applied.
    CGRect bounds = scrlView.bounds;
    CGRect pageFrame = bounds;
    pageFrame.size.width -= (countPhotos * PADDING);
    pageFrame.origin.x = (bounds.size.width * index) + PADDING;
    return pageFrame;
}

- (void)jumpToPageAtIndex:(NSUInteger)index {
	
	// Change page
	if (index < countPhotos) {
		CGRect pageFrame = [self frameForPageAtIndex:index];
		scrlView.contentOffset = CGPointMake(pageFrame.origin.x - PADDING, 0);
		//[self updateNavigation];
	}
	
	// Update timer to give more time
	//[self hideControlsAfterDelay];
	
}

- (void)gotoPreviousPage { [self jumpToPageAtIndex:currentPageIndex-1]; }
- (void)gotoNextPage { [self jumpToPageAtIndex:currentPageIndex+1]; } 
@end
