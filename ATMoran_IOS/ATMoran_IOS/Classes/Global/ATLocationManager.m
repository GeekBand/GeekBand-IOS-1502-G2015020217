//
//  ATLocationManager.m
//  GeekIos-ApplicationHomework
//
//  Created by AntsTower on 15/9/28.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import "ATLocationManager.h"


@interface ATLocationManager() <CLLocationManagerDelegate>
{
    CLLocationManager *_locationManager;
}
@end

@implementation ATLocationManager

+ (ATLocationManager *)sharedInstance
{
    static ATLocationManager *sharedLocationManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedLocationManagerInstance = [[ATLocationManager alloc] init];
    });
    return sharedLocationManagerInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        _locationManager = [[CLLocationManager alloc] init];
    }
    return self;
}


#pragma mark - LocationManager methods
- (void)updateLBS
{
    if([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [_locationManager requestAlwaysAuthorization];
        [_locationManager requestWhenInUseAuthorization];
    }
    
    if ([CLLocationManager locationServicesEnabled]) {
        _locationManager.delegate = self;
        _locationManager.distanceFilter = 1000.0f;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [_locationManager startUpdatingLocation];
        
    }
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    NSLog(@"locationManagerFail:%@",error.description);
    _longitude = @"";
    _latitude = @"";
    _location = nil;
    _currentLocation = nil;
    [_locationManager stopUpdatingLocation];
    
    if ([_delegate respondsToSelector:@selector(updateLocationFail:error:)]) {
        [_delegate updateLocationFail:self error:error];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    _currentLocation = locations.lastObject;
    _longitude = [NSString stringWithFormat:@"%f",[locations lastObject].coordinate.longitude];
    _latitude = [NSString stringWithFormat:@"%f",[locations lastObject].coordinate.latitude];

    NSLog(@"%@,%@",_longitude, _latitude);
    
    CLGeocoder *revGeo = [[CLGeocoder alloc] init];
    [revGeo reverseGeocodeLocation:_currentLocation
     //反向地理编码
                 completionHandler:^(NSArray *placemarks, NSError *error) {
                     if (!error && [placemarks count] > 0)
                     {
                         NSDictionary *dict =
                         [[placemarks objectAtIndex:0] addressDictionary]; NSLog(@"street address: %@",[dict objectForKey :@"Street"]);
                         
                         self.location = dict[@"Name"];
                     }
                     else
                     {
                         NSLog(@"ERROR: %@", error); }
                 }];
    
    [_locationManager stopUpdatingLocation];
    
    if ([_delegate respondsToSelector:@selector(updateLocationSuccess:)]) {
        [_delegate updateLocationSuccess:self];
    }
}


@end
