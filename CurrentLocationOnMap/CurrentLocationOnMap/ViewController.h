//
//  ViewController.h
//  CurrentLocationOnMap
//
//  Created by admin on 21/08/15.
//  Copyright (c) 2015 Innoeye. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *manager;
@property (nonatomic, strong) CLLocation *currentLocation;
@property (nonatomic, weak) IBOutlet MKMapView *mapview;
@end

