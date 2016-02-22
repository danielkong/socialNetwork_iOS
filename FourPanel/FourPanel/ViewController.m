//
//  ViewController.m
//  FourPanel
//
//  Created by Daniel Kong on 1/27/16.
//  Copyright © 2016 Daniel Kong. All rights reserved.
//

#import "ViewController.h"
#import "MapKit/MapKit.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *webUrlString = @"https://www.facebook.com";
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:webUrlString ]];
    [self.webView loadRequest:req];
    
    double lat = 34.448;
    double longtitude = - 119.66;
    
    MKPointAnnotation *anno = [[MKPointAnnotation alloc] init];
    anno.coordinate = CLLocationCoordinate2DMake(lat, longtitude);
    anno.title = @"Daniel Kong";
    [self.mapView addAnnotation:anno];
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(anno.coordinate, 10000, 10000);
    // adjust fit region
    MKCoordinateRegion adjust = [self.mapView regionThatFits:region];
    [self.mapView setRegion:adjust animated:YES];
    
    

}

@end
