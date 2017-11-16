//
//  LocationManager.m
//  ModelProduct
//
//  Created by apple on 16/1/13.
//  Copyright (c) 2016年 chj. All rights reserved.
//

#import "LocationManager.h"
#import <CoreLocation/CoreLocation.h>


@interface LocationManager()<CLLocationManagerDelegate>{
    BOOL isShow;
}

@property (nonatomic,strong)CLLocationManager *locationManager;
@property (nonatomic,strong)CLGeocoder *geocoder;

@end

@implementation LocationManager


+ (id)shareInStance {
    static LocationManager *manager=nil;
    static dispatch_once_t dispathone;
    dispatch_once(&dispathone, ^{
        manager=[[LocationManager alloc]init];
    });
    return manager;
}

- (void)startUserLocation:(LocationSuccessBlock)succBlock fail:(LocationFailBlock)failBlock {
    
    if (isShow) {
        return;
    }
    
    self.successBlock=succBlock;
    self.failBlock=failBlock;
    
    self.locationManager.delegate=nil;
    [self.locationManager stopUpdatingLocation];
    
    if (!_locationManager) {
        
        
        if ([CLLocationManager locationServicesEnabled]) {
            
            _locationManager =[[CLLocationManager alloc]init];
            
            //在ios 8.0下要授权
            
            if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
                //NSLog(@"requestWhenInUseAuthorization");
                [self.locationManager requestWhenInUseAuthorization];
            }
            
            
            self.locationManager.desiredAccuracy=kCLLocationAccuracyHundredMeters;
            self.locationManager.distanceFilter=100.0f;
            self.locationManager.delegate=self;
            
        }else{
            self.failBlock(@"没有权限");

        }
        
        
        
    }
    
    isShow = YES;
    
    [self.locationManager startUpdatingLocation];
    
}
- (void)stopUserLocation {
    self.locationManager.delegate=nil;
    [self.locationManager stopUpdatingLocation];
    
    isShow = NO;
    
}



#pragma CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    CLLocation *nowLocation=[locations lastObject];
    
    NSString *str_latitude=[NSString stringWithFormat:@"%f",nowLocation.coordinate.latitude];
    NSString *str_longitude=[NSString stringWithFormat:@"%f",nowLocation.coordinate.longitude];
    ksetDefaultValueForKey(str_latitude, kUserLocationLatitude);
    ksetDefaultValueForKey(str_longitude, kUserLocationLongitude);
    
    [self stopUserLocation];
    
    [manager stopUpdatingLocation];
    
    //反地理编码
    
    CLGeocoder *locationGeo=[[CLGeocoder alloc]init];
    
    [locationGeo reverseGeocodeLocation:nowLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (!error && [placemarks count] > 0) {
            
            NSDictionary *dic=[[placemarks objectAtIndex:0] addressDictionary];
            
            NSArray *formatted=[dic objectForKey:@"FormattedAddressLines"];
            ksetDefaultValueForKey([formatted objectAtIndex:0], kUserLocationAddressInfo);
            
            ksetDefaultValueForKey([dic objectForKey:@"City"], kUserLocationCity);
            ksetDefaultValueForKey([dic objectForKey:@"Country"], kUserLocationCountry);
            
            
            
            NSString *addressName=[NSString stringWithFormat:@"%@%@%@",[dic objectForKey:@"Country"],[dic objectForKey:@"State"],[dic objectForKey:@"SubLocality"]];
            NSLog(@"当前位置  %@",addressName);
            self.successBlock(kFormatterSring(kgetDefaultValueForKey(kUserLocationAddressInfo)));

        }
        
    }];
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    isShow = NO;
    
    self.failBlock(@"定位失败");

}

@end
