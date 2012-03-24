//
//  BroucherViewController.m
//  PropertyApp
//
//  Created by saurav sinha on 28/02/12.
//  Copyright (c) 2012 sauravsinha007@gmail.com. All rights reserved.
//

#import "BroucherViewController.h"
#import "MBProgressHUD.h"
@implementation BroucherViewController
@synthesize strUrlBroucher,webViewBroucher;
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
    navBarBroucher.tintColor=[UIColor colorWithRed:0.0f/255.0f green:51.0f/255.0f blue:87.0f/255.0f alpha:1.0f];
    [self.webViewBroucher loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:strUrlBroucher]]]; 
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [act startAnimating];
//    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    [hud setLabelText:@"Loading..."];

}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [act stopAnimating];
   // [MBProgressHUD hideHUDForView:self.view animated:YES];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [act stopAnimating];
 //   [MBProgressHUD hideHUDForView:self.view animated:YES];

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
-(IBAction)clickToDone:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}
@end
