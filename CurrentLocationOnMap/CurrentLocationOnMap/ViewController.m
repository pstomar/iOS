//
//  ViewController.m
//  CurrentLocationOnMap
//
//  Created by admin on 21/08/15.
//  Copyright (c) 2015 Innoeye. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self startLocationServices];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark locationservices
-(void)startLocationServices {
    // Set NSLocationAlwaysUsageDescription property in info.plist file
    if (_manager == nil) {
        _manager = [[CLLocationManager alloc] init];
        [_manager setDelegate:self];
    }
    
    [_manager requestAlwaysAuthorization];
    [_manager setDesiredAccuracy:kCLLocationAccuracyBest];
    [_manager setDistanceFilter:kCLDistanceFilterNone];
    [_manager startUpdatingLocation];
}

-(void)stopLocationServices{
    [_manager stopUpdatingLocation];
}

-(void)setMapviewto:(CLLocationCoordinate2D)coordinate{
//    CLLocationCoordinate2D coord = {latitude: 37.423617, longitude: -122.220154};
    MKCoordinateSpan span = {latitudeDelta: .1, longitudeDelta: .1};
    MKCoordinateRegion region = {coordinate, span};
    [_mapview setRegion:region];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
   _currentLocation = [locations lastObject];
    [self setMapviewto:[_currentLocation coordinate]];
    [self stopLocationServices];
}

@end
