//
//  LineViewController.h
//  ChartsDemo
//
//  Created by SKOTC on 17/6/27.
//  Copyright © 2017年 CAOMEI. All rights reserved.
//


#define screenWidth  [[UIScreen mainScreen] bounds].size.width
#define screenHeight [[UIScreen mainScreen] bounds].size.height


#import <UIKit/UIKit.h>
#import "DateValueFormatter.h"
#import "SetValueFormatter.h"

@import Charts;

@interface LineViewController : UIViewController

@property (nonatomic,strong) LineChartView * lineChartView;
@property (nonatomic,strong) UILabel  * markerValueLabel;
@property (nonatomic,strong) UIButton * dismissButton;

@end
