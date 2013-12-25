//
//  ViewController.h
//  iBeaconProto
//
//  Created by AkihideKuwamoto on 2013/12/25.
//  Copyright (c) 2013年 AkihideKuwamoto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController<CLLocationManagerDelegate>

@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic) NSUUID *proximityUUID;
@property (nonatomic) CLBeaconRegion *beaconRegion;

@end
