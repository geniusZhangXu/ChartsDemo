//
//  RadarChartViewController.m
//  ChartsDemo
//
//  Created by SKOTC on 2017/7/21.
//  Copyright © 2017年 CAOMEI. All rights reserved.
//

#import "RadarChartViewController.h"

@interface RadarChartViewController ()<ChartViewDelegate>

@end

@implementation RadarChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:self.dismissButton];
        
        //
        [self.view addSubview:self.radarChartView];
        
        //雷达图线条样式
        self.radarChartView.webLineWidth = 0.5;                    //主干线线宽
        self.radarChartView.webColor = [UIColor purpleColor];      //主干线线宽
        self.radarChartView.innerWebLineWidth = 0.375;             //边线宽度
        self.radarChartView.innerWebColor = [UIColor purpleColor]; //边线颜色
        self.radarChartView.webAlpha = 1;                          //透明度
        
        
        //设置 xAxi
        ChartXAxis *xAxis = self.radarChartView.xAxis;
        xAxis.labelFont = [UIFont systemFontOfSize:15];//字体
        xAxis.labelTextColor = [UIColor blackColor];//颜色
        
        //设置 yAxis
        ChartYAxis *yAxis = self.radarChartView.yAxis;
        yAxis.axisMinValue = 0.0;//最小值
        yAxis.axisMaxValue = 150.0;//最大值
        yAxis.drawLabelsEnabled = NO;//是否显示 label
        yAxis.labelCount = 6;// label 个数
        yAxis.labelFont = [UIFont systemFontOfSize:9];// label 字体
        yAxis.labelTextColor = [UIColor lightGrayColor];// label 颜色
        
        //为雷达图提供数据
        self.data = [self setData];
        self.radarChartView.data = self.data;
        [self.radarChartView renderer];
        
        //设置动画
        [self.radarChartView animateWithYAxisDuration:0.1f];
        
}


//创建数据
- (RadarChartData *)setData{
        
        double mult = 100;
        int count = 12;//维度的个数
        
        //每个维度的名称或描述
        NSMutableArray *xVals = [[NSMutableArray alloc] init];
        for (int i = 0; i < count; i++) {
                [xVals addObject:[NSString stringWithFormat:@"%d 月", i+1]];
        }
        
        //每个维度的数据
        NSMutableArray *yVals1 = [[NSMutableArray alloc] init];
        for (int i = 0; i < count; i++) {
                double randomVal = arc4random_uniform(mult) + mult/ 2;         //产生 50~150 的随机数
                ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:i y:randomVal];
                [yVals1 addObject:entry];
        }
        
        RadarChartDataSet *set1 = [[RadarChartDataSet alloc] initWithValues:yVals1 label:@"set 1"];
        set1.lineWidth = 0.5;               //数据折线线宽
        [set1 setColor:[UIColor blueColor]];//数据折线颜色
        set1.drawFilledEnabled = YES;       //是否填充颜色
        set1.fillColor = [UIColor yellowColor];//填充颜色
        set1.fillAlpha = 0.25;              //填充透明度
        set1.drawValuesEnabled = NO;        //是否绘制显示数据
        set1.valueFont = [UIFont systemFontOfSize:9];//字体
        set1.valueTextColor = [UIColor grayColor];   //颜色
        
        //    NSMutableArray *yVals2 = [[NSMutableArray alloc] init];
        //    for (int i = 0; i < count; i++) {
        //        double randomVal = arc4random_uniform(mult) + mult / 2;//产生 50~150 的随机数
        //        ChartDataEntry *entry = [[ChartDataEntry alloc] initWithValue:randomVal xIndex:i];
        //        [yVals2 addObject:entry];
        //    }
        //    RadarChartDataSet *set2 = [[RadarChartDataSet alloc] initWithYVals:yVals2 label:@"set 2"];
        //    set2.lineWidth = 0.5;//数据折线线宽
        //    set2.drawFilledEnabled = YES;//是否填充颜色
        //    [set2 setColor:[self colorWithHexString:@"#ff2d51"]];
        //    set2.fillColor = [self colorWithHexString:@"#ff2d51"];
        //    set2.fillAlpha = 0.25;//填充透明度
        //    set2.drawValuesEnabled = NO;//是否绘制显示数据
        //    set2.valueFont = [UIFont systemFontOfSize:9];//字体
        //    set2.valueTextColor = [UIColor grayColor];//颜色
        
        RadarChartData *data = [[RadarChartData alloc] initWithDataSets:@[set1]];
        
        return data;
}


- (void)chartValueSelected:(ChartViewBase * _Nonnull)chartView entry:(ChartDataEntry * _Nonnull)entry dataSetIndex:(NSInteger)dataSetIndex highlight:(ChartHighlight * _Nonnull)highlight{
        
        NSLog(@"chartValueSelected");
}


- (void)chartValueNothingSelected:(ChartViewBase * _Nonnull)chartView{
        
        NSLog(@"chartValueNothingSelected");
}


- (void)chartScaled:(ChartViewBase * _Nonnull)chartView scaleX:(CGFloat)scaleX scaleY:(CGFloat)scaleY{
        
        NSLog(@"chartScaled");
}


- (void)chartTranslated:(ChartViewBase * _Nonnull)chartView dX:(CGFloat)dX dY:(CGFloat)dY{
        
        NSLog(@"chartTranslated");
}



-(RadarChartView *)radarChartView{

        if (!_radarChartView) {
        
                _radarChartView = [[RadarChartView alloc]initWithFrame:CGRectMake(10,(screenHeight-300)/2, screenWidth, 300)];
                _radarChartView.backgroundColor = [UIColor colorWithRed:230/255.0f green:253/255.0f blue:253/255.0f alpha:1];
                _radarChartView.delegate = self;
                _radarChartView.descriptionText = @"";//描述
                _radarChartView.rotationEnabled = YES;//是否允许转动
                _radarChartView.highlightPerTapEnabled = YES;//是否能被选中
        }
        return _radarChartView;

}



-(UIButton *)dismissButton{
        
        if (!_dismissButton) {
                
                _dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
                _dismissButton.frame = CGRectMake(screenWidth-80, screenHeight - 40, 80, 40);
                [_dismissButton setTitle:@"Dismiss" forState:UIControlStateNormal];
                [_dismissButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [_dismissButton addTarget:self action:@selector(dismissButtonClick) forControlEvents:UIControlEventTouchUpInside];
        }
        return _dismissButton;
}

-(void)dismissButtonClick{
        
        [self dismissViewControllerAnimated:YES completion:NULL];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
