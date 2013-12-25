//
//  ViewController.m
//  iBeaconProto
//
//  Created by AkihideKuwamoto on 2013/12/25.
//  Copyright (c) 2013年 AkihideKuwamoto. All rights reserved.
//

#import "ViewController.h"

#define SERVICE_UUID @"895B905A-074B-440A-8CA5-C6D855ED4A42"
#define SERVICE_IDENTIFER @"BEACON-PROTOTYPE"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    if ([CLLocationManager isMonitoringAvailableForClass:[CLBeaconRegion class]]) {
        self.locationManager = [CLLocationManager new];
        self.locationManager.delegate = self;
        
        self.proximityUUID = [[NSUUID alloc] initWithUUIDString:SERVICE_UUID];
        
        self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:self.proximityUUID
                                                               identifier:SERVICE_IDENTIFER];
        [self.locationManager startMonitoringForRegion:self.beaconRegion];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Start monitoring

- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region
{
    [self.locationManager requestStateForRegion:self.beaconRegion];
}

#pragma mark CLLocationDelegate
- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
    switch (state) {
        case CLRegionStateInside: // リージョン内にいる
            if ([region isMemberOfClass:[CLBeaconRegion class]] && [CLLocationManager isRangingAvailable]) {
                [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
            }
            break;
        case CLRegionStateOutside:
        case CLRegionStateUnknown:
        default:
            break;
    }
}


- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    if ([region isMemberOfClass:[CLBeaconRegion class]] && [CLLocationManager isRangingAvailable]) {
        [self.locationManager startRangingBeaconsInRegion:(CLBeaconRegion *)region];
    }
}
@end
