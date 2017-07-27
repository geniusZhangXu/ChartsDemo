//
//  PieViewController.h
//  ChartsDemo
//
//  Created by SKOTC on 2017/7/20.
//  Copyright © 2017年 CAOMEI. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Charts;

#define screenWidth  [[UIScreen mainScreen] bounds].size.width
#define screenHeight [[UIScreen mainScreen] bounds].size.height

@interface PieViewController : UIViewController

@property (nonatomic,strong) PieChartData * data;
@property (nonatomic,strong) PieChartView * pieChartView;
@property (nonatomic,strong) UIButton * dismissButton;
@end
