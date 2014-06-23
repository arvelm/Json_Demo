//
//  RootViewController.h
//  JSON_Demo
//
//  Created by Ivan on 14-6-19.
//  Copyright (c) 2014年 Ivan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController

@property(nonatomic,strong)NSDictionary *dictionaryWeather;

@property(nonatomic,strong,readonly)NSString *currentCity;

@property(nonatomic,strong)NSArray *weatherData;

-(void)setupInterface;

@end
