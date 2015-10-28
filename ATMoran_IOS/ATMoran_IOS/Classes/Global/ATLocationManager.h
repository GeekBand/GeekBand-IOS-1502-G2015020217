//
//  ATLocationManager.h
//  GeekIos-ApplicationHomework
//
//  Created by AntsTower on 15/9/28.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class ATLocationManager;
@protocol ATLocationManagerDelegate <NSObject>

- (void)updateLocationSuccess:(ATLocationManager *)manager;
- (void)updateLocationFail:(ATLocationManager *)manager error:(NSError *)error;

@end

@interface ATLocationManager : NSObject

+ (ATLocationManager *)sharedInstance;

- (void)updateLBS;

@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) CLLocation *currentLocation;

@property (nonatomic, strong) NSString *address;

@property (nonatomic,weak) id<ATLocationManagerDelegate> delegate;

@end
