//
//  RootViewController.m
//  JSON_Demo
//
//  Created by Ivan on 14-6-19.
//  Copyright (c) 2014年 Ivan. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@property(nonatomic,strong)NSMutableDictionary *firstDay;
@property(nonatomic,strong)NSMutableDictionary *secondDay;
@property(nonatomic,strong)NSMutableDictionary *thirdDay;
@property(nonatomic,strong)NSMutableDictionary *forthDay;

@property(nonatomic,strong)UILabel *cityLabel;
@property(nonatomic,strong)UILabel *dateLabel;
@property(nonatomic,strong)UILabel *weatherLabel;
@property(nonatomic,strong)UILabel *windLabel;
@property(nonatomic,strong)UILabel *temperatureLable;
@property(nonatomic,strong)UIImage *weatherImage;

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    _firstDay=[[NSMutableDictionary alloc]init];
    _secondDay=[[NSMutableDictionary alloc]init];
    _thirdDay=[[NSMutableDictionary alloc]init];
    _forthDay=[[NSMutableDictionary alloc]init];
    
    return self;
}

-(void)loadView{
    UIView *view=[[UIView alloc]initWithFrame:[[UIScreen mainScreen]applicationFrame]];
    view.backgroundColor=[UIColor colorWithRed:0.1 green:0.6 blue:1.0 alpha:1.0];
    self.view=view;
}

//-(void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    UIActivityIndicatorView *activityIndicatorView=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(120, 224, 80, 80)];
//    activityIndicatorView.activityIndicatorViewStyle= UIActivityIndicatorViewStyleWhiteLarge;
//    activityIndicatorView.hidesWhenStopped=YES;
//    [self.view addSubview:activityIndicatorView];
//    [activityIndicatorView startAnimating];
//}



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self testNSJSONSerialization];
    _cityLabel.text=_currentCity;
    if (_weatherData) {
        NSURL *imageUrl=[NSURL URLWithString:[_forthDay valueForKey:@"dayPictureUrl"]];
        _weatherImage=[UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(170, 105, 24, 24)];
        [imageView setImage:_weatherImage];
        [self.view addSubview:imageView];
    }
    [self setupInterface];
    
//    标题从date中提取
    NSMutableString *week=[NSMutableString stringWithString:[_firstDay valueForKey:@"date"]];
    [week deleteCharactersInRange:NSMakeRange(2, 16)];
    self.title=week;
    
    _cityLabel.text=_currentCity;
    _dateLabel.text=[_firstDay valueForKey:@"date"];
    _weatherLabel.text=[_firstDay valueForKey:@"weather"];
    _windLabel.text=[_firstDay valueForKey:@"wind"];
    _temperatureLable.text=[_firstDay valueForKey:@"temperature"];
    
    
    NSDate *date=[[NSDate alloc]init ];
    NSLog(@"Time: %@",date);

    
   
    

    
    
    
    
    

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)testNSJSONSerialization{
    NSError *error;
    
//    NSURL *url=[NSURL URLWithString:@"http://api.map.baidu.com/telematics/v3/weather?location=深圳&output=json&ak=RXWQ6lcNaxtfpevCXsmGSPGg"];
    NSString *address=@"http://api.map.baidu.com/telematics/v3/weather?location=深圳&output=json&ak=RXWQ6lcNaxtfpevCXsmGSPGg";
    NSString *utfAdress=[address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url=[NSURL URLWithString:utfAdress];
    NSURLRequest *urlRequest=[NSURLRequest requestWithURL:url];
    NSData *dataresponse=[NSURLConnection sendSynchronousRequest:urlRequest returningResponse
                                                                :nil error:nil];
//    NSLog(@"dataResponse:%@",dataresponse);
    
    if (dataresponse) {
        _dictionaryWeather=[NSJSONSerialization JSONObjectWithData:dataresponse options:NSJSONReadingMutableLeaves error:&error];
        
        NSArray *resultsArray=[_dictionaryWeather objectForKey:@"results"];
        NSDictionary *resultDict=[resultsArray objectAtIndex:0];
//        NSLog(@"results:%@",resultsArray);
        
//         获取城市信息
        _currentCity=[resultDict valueForKey:@"currentCity"];
         NSLog(@"_CurrentCity: %@",_currentCity );
        
//        获取天气信息
        _weatherData=[resultDict objectForKey:@"weather_data"];
        
        _firstDay=_weatherData[0];
        _secondDay=_weatherData[1];
        _thirdDay=_weatherData[2];
        _forthDay=_weatherData[3];
        NSLog(@"1stDay:%@",[_firstDay valueForKey:@"date"]);
        NSLog(@"1stDay:%@",[_firstDay valueForKey:@"weather"]);
        NSLog(@"1stDay:%@",[_firstDay valueForKey:@"wind"]);
        NSLog(@"1stDay:%@",[_firstDay valueForKey:@"temperature"]);
        
    }else{
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"消息" message:@"信息获取失败" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil, nil];
        alertView.show;
        
    }
}



-(void)setupInterface{
    _cityLabel=[[UILabel alloc] initWithFrame:CGRectMake(80, 100, 120, 40)];
//    _cityLabel.backgroundColor=[UIColor cyanColor];
    _cityLabel.textAlignment=NSTextAlignmentCenter;
    _cityLabel.autoresizingMask=YES;
    [self.view addSubview:_cityLabel];
    
    _dateLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, 140, 280, 40)];
//    _dateLabel.backgroundColor=[UIColor cyanColor];
    _dateLabel.textAlignment=NSTextAlignmentCenter;
    _dateLabel.autoresizingMask=YES;
    [self.view addSubview:_dateLabel];
    
    _weatherLabel=[[UILabel alloc] initWithFrame:CGRectMake(100, 180, 120, 40)];
//    _weatherLabel.backgroundColor=[UIColor cyanColor];
    _weatherLabel.textAlignment=NSTextAlignmentCenter;
    _weatherLabel.autoresizingMask=YES;
    [self.view addSubview:_weatherLabel];
    
    _windLabel=[[UILabel alloc] initWithFrame:CGRectMake(100, 220, 120, 40)];
//    _windLabel.backgroundColor=[UIColor cyanColor];
    _windLabel.textAlignment=NSTextAlignmentCenter;
    _windLabel.autoresizingMask=YES;
    [self.view addSubview:_windLabel];
    
    _temperatureLable=[[UILabel alloc] initWithFrame:CGRectMake(100, 260, 120, 40)];
//    _temperatureLable.backgroundColor=[UIColor cyanColor];
    _temperatureLable.textAlignment=NSTextAlignmentCenter;
    _temperatureLable.autoresizingMask=YES;
    [self.view addSubview:_temperatureLable];
}

-(void)weekend{
    
  
    
    
}

@end
