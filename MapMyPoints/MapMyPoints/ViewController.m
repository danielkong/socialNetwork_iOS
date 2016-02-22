//
//  ViewController.m
//  MapMyPoints
//
//  Created by Daniel Kong on 2/7/16.
//  Copyright © 2016 Daniel Kong. All rights reserved.
//

#import "ViewController.h"
#import "MapKit/MapKit.h"

@interface ViewController () <CLLocationManagerDelegate, MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (strong, nonatomic) MKPointAnnotation *anno1;
@property (strong, nonatomic) MKPointAnnotation *anno2;
@property (weak, nonatomic) IBOutlet UISwitch *switchButton;
@property (strong, nonatomic) MKPointAnnotation *anno3;

@property (strong, nonatomic) MKPointAnnotation *currentAnno;

@property (strong, nonatomic) CLLocationManager *locationManager;

@property (nonatomic, assign) BOOL mapIsMoving;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];    
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    
    self.mapIsMoving = NO;
    
    [self addAnnotations];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addAnnotations {
    self.anno1 = [[MKPointAnnotation alloc] init];
    self.anno1.coordinate = CLLocationCoordinate2DMake(33.64, -117.65);
    self.anno1.title = @"Laboratory";
    
    self.anno2 = [[MKPointAnnotation alloc] init];
    self.anno2.coordinate = CLLocationCoordinate2DMake(34.45, -119.66);
    self.anno2.title = @"Westmont";
    
    self.anno3 = [[MKPointAnnotation alloc] init];
    self.anno3.coordinate = CLLocationCoordinate2DMake(40.67, -73.99);
    self.anno3.title = @"test3";
    
    self.currentAnno = [[MKPointAnnotation alloc] init];
    self.currentAnno.coordinate = CLLocationCoordinate2DMake(0, 0);
    self.currentAnno.title = @"My Location";

    
    [self.mapView addAnnotations:@[self.anno1, self.anno2, self.anno3]];
}

- (void)centerMap:(MKPointAnnotation *)anno {
    [self.mapView setCenterCoordinate:anno.coordinate animated:YES];
}

- (IBAction)switchChanged:(id)sender {
    if (self.switchButton.isOn) {
        self.mapView.showsUserLocation = YES;
        [self.locationManager startUpdatingLocation];
    } else {
        self.mapView.showsUserLocation = NO;
        [self.locationManager stopUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(nonnull NSArray<CLLocation *> *)locations {
    self.currentAnno.coordinate = locations.lastObject.coordinate;
    
    if (self.mapIsMoving == NO) {
        [self centerMap:self.currentAnno];
    }
}

- (IBAction)anno1Tapped:(id)sender {
    [self centerMap:self.anno1];
}

- (IBAction)anno2Tapped:(id)sender {
    [self centerMap:self.anno2];

}

- (IBAction)anno3Tapped:(id)sender {
    [self centerMap:self.anno3];

}

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
    self.mapIsMoving = YES;
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    self.mapIsMoving = NO;
}
@end
