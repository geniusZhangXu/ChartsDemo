//
//  RadarChartViewController.h
//  ChartsDemo
//
//  Created by SKOTC on 2017/7/21.
//  Copyright © 2017年 CAOMEI. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Charts;

#define screenWidth  [[UIScreen mainScreen] bounds].size.width
#define screenHeight [[UIScreen mainScreen] bounds].size.height

@interface RadarChartViewController : UIViewController

@property (nonatomic,strong) UIButton * dismissButton;
@property (nonatomic,strong) RadarChartView *  radarChartView;
@property (nonatomic,strong) RadarChartData *data;


@end
