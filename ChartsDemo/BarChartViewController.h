//
//  BarChartViewController.h
//  ChartsDemo
//
//  Created by SKOTC on 17/7/10.
//  Copyright © 2017年 CAOMEI. All rights reserved.
//

#define screenWidth  [[UIScreen mainScreen] bounds].size.width
#define screenHeight [[UIScreen mainScreen] bounds].size.height


#import <UIKit/UIKit.h>

@import Charts;

@interface BarChartViewController : UIViewController

@property (nonatomic,strong) BarChartView * barChartView;
@property (nonatomic,strong) UIButton * dismissButton;

@end
