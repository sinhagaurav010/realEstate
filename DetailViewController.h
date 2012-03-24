//
//  DetailViewController.h
//  PropertyApp
//
//  Created by saurav sinha on 28/02/12.
//  Copyright (c) 2012 sauravsinha007@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import <MessageUI/MessageUI.h>
#import "ModalController.h"
#import "MyAnnotation.h"
#import "iCodeBlogAnnotationView.h"
#import <MapKit/MapKit.h>
#import "cellDescpImg.h"
#import "cellSummary.h"
#import "cellMapView.h"
#import "cellShowPhotos.h"
#import "EGOImageView.h"
#import "cellAgent.h"
#import "BroucherViewController.h"


@interface DetailViewController : UIViewController<MFMailComposeViewControllerDelegate,MKMapViewDelegate,UIScrollViewDelegate,UIWebViewDelegate>
{
    NSMutableArray *arrayImages;
    UILabel *labelAddress;
    EGOImageView *imageMain;
    UILabel *labeltelephone;
    UILabel *l1;
    NSInteger countPhotos;
    UIScrollView *scrlView;
    IBOutlet  UITableView *tableViewDesc;
    IBOutlet UIToolbar *toolbar;
    NSMutableArray *arraySavedProperty;
    NSInteger savedAtIndex;
    EGOImageView *imageMAin2;
    UILabel *labelAgentDescp;
    UIWebView *webViewDescp;
    // Paging
    UIButton *leftBtn;
    UIButton *rightBtn;
	NSMutableSet *visiblePages, *recycledPages;
    int currentPageIndex;
    CGSize labelSize;
    NSString *priceTemp;
    int temp;
}
-(IBAction)callAgent:(id)sender;

-(IBAction)EmailAgent:(id)sender;
@property(retain)NSString *stringRightTitle;
@property(retain)NSMutableDictionary *dictResult;
@property(retain)    NSString *stringDescSection4;

-(void)createMap;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property(retain)NSString *stringLat;
@property(retain)NSString *stringLong;

@property(retain,nonatomic)MKMapView *mpView;

-(void)tilePages;

- (void)gotoPreviousPage;
- (void)gotoNextPage;
@end
