//
//  BarChartViewController.m
//  ChartsDemo
//
//  Created by SKOTC on 17/7/10.
//  Copyright © 2017年 CAOMEI. All rights reserved.
//

#import "BarChartViewController.h"
#import "BarValueFormatter.h"


@interface BarChartViewController ()<ChartViewDelegate>

@property (nonatomic, strong) BarChartData *data;


@end

@implementation BarChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor =[UIColor whiteColor];
        // barChartView 的基本设置
        [self.view addSubview:self.barChartView];
        [self.view addSubview:self.dismissButton];
        
        
        self.barChartView.backgroundColor = [UIColor colorWithRed:230/255.0f green:253/255.0f blue:253/255.0f alpha:1];
        self.barChartView.noDataText = @"暂无数据";         // 没有数据时的文字提示
        self.barChartView.drawValueAboveBarEnabled = YES;  //  数据是否显示在柱状图的上面
        self.barChartView.drawBarShadowEnabled = NO;       //  是否显示阴影背景
        
        // barChartView 交互的一些基本的设置
        self.barChartView.scaleYEnabled = NO;             //  取消Y轴的缩放
        self.barChartView.doubleTapToZoomEnabled  = NO ;  //  取消双击的缩放
        self.barChartView.dragEnabled = YES;              //  拖拽启动
        self.barChartView.dragDecelerationEnabled = YES;  //  拖拽后的惯性效果
        self.barChartView.dragDecelerationFrictionCoef = 0.9;//拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显
        
        
        //
        ChartXAxis * xAxis = self.barChartView.xAxis;
        xAxis.axisLineWidth = 1;  // X轴的线宽
       
        /* 这个属性是枚举类型。用于设置描述Labelz位于X哪里
         typedef SWIFT_ENUM_NAMED(NSInteger, XAxisLabelPosition, "LabelPosition") {
         XAxisLabelPositionTop = 0,
         XAxisLabelPositionBottom = 1,
         XAxisLabelPositionBothSided = 2,
         XAxisLabelPositionTopInside = 3,
         XAxisLabelPositionBottomInside = 4,
         };
         */
        xAxis.labelPosition = XAxisLabelPositionBottom;
        xAxis.drawGridLinesEnabled = NO;                // 不绘制网格线
        xAxis.labelTextColor = [UIColor brownColor];    // label文字颜色
        //xAxis.granularityEnabled = YES;               // 设置重复的值不显示
        xAxis.axisMinValue = -1;                         // 最小值
        //xAxis.granularity  = 4;// 间隔为10
        
        //Y轴
        self.barChartView.rightAxis.enabled = NO;           //不绘制右边的轴线
        ChartYAxis *leftAxis = self.barChartView.leftAxis;  //获取左边Y轴
        leftAxis.forceLabelsEnabled = NO;                   //不强制绘制制定数量的label
        leftAxis.axisMinValue = 0;                          //设置Y轴的最小值
        leftAxis.axisMaxValue = 105;                        //设置Y轴的最大值
        leftAxis.inverted = NO;                             //是否将Y轴进行上下翻转
        leftAxis.axisLineWidth = 0.5;                       //Y轴线宽
        leftAxis.axisLineColor = [UIColor blackColor];      //Y轴颜色
        
        leftAxis.labelCount = 5;
        leftAxis.labelPosition  = YAxisLabelPositionOutsideChart;//label位置
        leftAxis.labelTextColor = [UIColor brownColor];//文字颜色
        leftAxis.labelFont = [UIFont systemFontOfSize:10.0f];//文字字体
        
        
        leftAxis.gridLineDashLengths = @[@3.0f, @3.0f];//设置虚线样式的网格线
        leftAxis.gridColor = [UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1];//网格线颜色
        leftAxis.gridAntialiasEnabled = YES;//开启抗锯齿
        
        
        ChartLimitLine *limitLine = [[ChartLimitLine alloc] initWithLimit:80 label:@"限制线"];
        limitLine.lineWidth = 2;
        limitLine.lineColor = [UIColor greenColor];
        limitLine.lineDashLengths = @[@5.0f, @5.0f];              //虚线样式
        limitLine.labelPosition = ChartLimitLabelPositionRightTop;//位置
        [leftAxis addLimitLine:limitLine];                        //添加到Y轴上
        leftAxis.drawLimitLinesBehindDataEnabled = YES;           //设置限制线绘制在柱形图的后面
        
        self.barChartView.legend.enabled  = NO;  //不显示图例说明
        self.barChartView.descriptionText = @""; //不显示，就设为空字符串即可
        
        self.data = [self setData];
        
        //为柱形图提供数据
        self.barChartView.data = self.data;
        
        //设置动画效果，可以设置X轴和Y轴的动画效果
        [self.barChartView animateWithYAxisDuration:1.0f];
        
        
}


-(BarChartView *)barChartView{
  
        if (!_barChartView) {
                
                _barChartView =[[BarChartView alloc]initWithFrame:CGRectMake(10,(screenHeight-300)/2, screenWidth, 300)];
                _barChartView.delegate = self;
        }
        return _barChartView;

}

//为柱形图设置数据
- (BarChartData *)setData{
        
        int xVals_count = 12;//X轴上要显示多少条数据
        double maxYVal  = 100;//Y轴的最大值
        
        //X轴上面需要显示的数据
        NSMutableArray *xVals = [[NSMutableArray alloc] init];
        for (int i = 0; i < xVals_count; i++) {
                
                [xVals addObject:[NSString stringWithFormat:@"%d月", i+1]];
        }
        
        
        _barChartView.xAxis.valueFormatter = [[BarValueFormatter alloc]initWithArray:xVals];
        
        //对应Y轴上面需要显示的数据
        NSMutableArray *yVals = [[NSMutableArray alloc] init];
        for (int i = 0; i < xVals_count; i++) {
                
                double mult = maxYVal + 1;
                double val = (double)(arc4random_uniform(mult));
                BarChartDataEntry * entry = [[BarChartDataEntry alloc]initWithX:i y:val];
                [yVals addObject:entry];
        }
        
        
        //创建BarChartDataSet对象，其中包含有Y轴数据信息，以及可以设置柱形样式
        BarChartDataSet * set1 = [[BarChartDataSet alloc]initWithValues:yVals label:nil];
        
        //set1.barSpace = 0.2;//柱形之间的间隙占整个柱形(柱形+间隙)的比例
        set1.drawValuesEnabled = YES; //是否在柱形图上面显示数值
        set1.highlightEnabled  = NO;  //点击选中柱形图是否有高亮效果，（双击空白处取消选中）
        [set1 setColors:ChartColorTemplates.material];//设置柱形图颜色
       
        //将BarChartDataSet对象放入数组中
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        
        
        //创建BarChartData对象, 此对象就是barChartView需要最终数据对象
        BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
        //data.barWidth = 0.7;
        [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.f]];//文字字体
        [data setValueTextColor:[UIColor orangeColor]];//文字颜色
        
        return data;
}


#pragma mark -- ChartViewDelegate
//点击选中柱形时回调
- (void)chartValueSelected:(ChartViewBase * _Nonnull)chartView entry:(ChartDataEntry * _Nonnull)entry dataSetIndex:(NSInteger)dataSetIndex highlight:(ChartHighlight * _Nonnull)highlight{
        
        NSLog(@"");
}

//没有选中柱形图时回调，当选中一个柱形图后，在空白处双击，就可以取消选择，此时会回调此方法
- (void)chartValueNothingSelected:(ChartViewBase * _Nonnull)chartView{
        
        NSLog(@"---chartValueNothingSelected---");
}

//放大图表时回调
- (void)chartScaled:(ChartViewBase * _Nonnull)chartView scaleX:(CGFloat)scaleX scaleY:(CGFloat)scaleY{
        
        NSLog(@"---chartScaled---scaleX:%g, scaleY:%g", scaleX, scaleY);
}

//拖拽图表时回调
- (void)chartTranslated:(ChartViewBase * _Nonnull)chartView dX:(CGFloat)dX dY:(CGFloat)dY{
        
        NSLog(@"---chartTranslated---dX:%g, dY:%g", dX, dY);
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
