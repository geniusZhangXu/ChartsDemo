//
//  LineViewController.m
//  ChartsDemo
//
//  Created by SKOTC on 17/6/27.
//  Copyright © 2017年 CAOMEI. All rights reserved.
//

#import "LineViewController.h"

@interface LineViewController ()<ChartViewDelegate>

@end

@implementation LineViewController

- (void)viewDidLoad {
        
        [super viewDidLoad];
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:self.lineChartView];
        [self.view addSubview:self.dismissButton];
        
        // 设置数据
        self.lineChartView.data = [self setData];
}


-(LineChartView *)lineChartView{

        if(!_lineChartView) {
                
                _lineChartView = [[LineChartView alloc]initWithFrame:CGRectMake(0, 50, screenWidth,  screenHeight-200)];
                _lineChartView.delegate = self;  // 代理
                _lineChartView.backgroundColor = [UIColor whiteColor];
                
                _lineChartView.noDataText = @"暂无数据";
                _lineChartView.chartDescription.enabled = YES;
                _lineChartView.scaleYEnabled = NO ;                // 取消Y轴的缩放
                _lineChartView.doubleTapToZoomEnabled = NO;        // 取消双击缩放
                _lineChartView.dragEnabled = YES;                  // 启动拖拽图片
                _lineChartView.dragDecelerationEnabled = YES;      // 拖拽后是否有惯性效果
                _lineChartView.dragDecelerationFrictionCoef = 0.9; // 拖拽后惯性效果的摩擦系数（0-1），越小越不明显
                _lineChartView.rightAxis.enabled = NO;             // 不绘制右边轴
                
                // 设置滑动时候的标签,也就是项目中的两条红线
                // ChartMarkerView 继承 UIView  Marker 书签
                ChartMarkerView * markView = [[ChartMarkerView alloc]init];
                markView.offset = CGPointMake(-999, -8);
                markView.chartView = _lineChartView;
                _lineChartView.marker = markView;
                
                [markView addSubview:self.markerValueLabel];
                
                // Axis     轴的意思
                // Chart    n. 图表；海图；图纸
                ChartYAxis * leftAxis = _lineChartView.leftAxis;   // 获取左边Y轴
                leftAxis.labelCount   = 5;        // Y轴label数量，数值不一定，如果forceLabelsEnabled等于YES,
                
                leftAxis.forceLabelsEnabled = NO; // 不强制绘制指定数量的label  // 则强制绘制制定数量的label, 但是可能不平均
                leftAxis.axisMinValue = 0;        // 设置Y轴的最小值
                leftAxis.axisMaxValue = 105;      // 设置Y轴的最大值
                leftAxis.inverted = NO;           // 是否将Y轴进行上下翻转
                leftAxis.axisLineColor  = [UIColor clearColor];// Y轴颜色
                
                
                //leftAxis.valueFormatter = [[SymbolsValueFormatter alloc]init];
                /*
                      typedef SWIFT_ENUM_NAMED(NSInteger, YAxisLabelPosition, "LabelPosition") {
                 
                        YAxisLabelPositionOutsideChart = 0,   表的Y轴外面
                        YAxisLabelPositionInsideChart  = 1,   表的Y轴里面
                     };
                 */
                
                leftAxis.labelPosition  = YAxisLabelPositionOutsideChart;// label位置
                leftAxis.labelTextColor = [UIColor blackColor];          // 文字颜色
                leftAxis.labelFont = [UIFont systemFontOfSize:10.0f];    // 文字字体
                leftAxis.gridColor = [UIColor grayColor];                // 网格线颜色    grid: n. 网格；格子，栅格；输电网
                leftAxis.gridAntialiasEnabled = NO;                      // 开启抗锯齿
                
                // 获取X轴
                ChartXAxis * xAxis   = _lineChartView.xAxis;
                xAxis.granularityEnabled = YES;                 // 设置重复的值不显示
                xAxis.labelPosition  = XAxisLabelPositionBottom;// 设置x轴数据在底部
                xAxis.gridColor      = [UIColor clearColor];    // X轴网格线颜色,设置clearColor就不显示X轴网格，可以修改其他颜色看看
                xAxis.labelTextColor = [UIColor blackColor];    // 文字颜色
                xAxis.axisLineColor  = [UIColor blackColor];    // 轴线的颜色
                
                _lineChartView.maxVisibleCount = 999;           // 
                _lineChartView.legend.enabled  = NO;            //
                [_lineChartView setDescriptionText:@""];        // X轴的描述，展示在X轴右端轴线上面
                [_lineChartView animateWithXAxisDuration:1.0f]; // X轴动画时间间隔
                
        }
        return _lineChartView;
}



/**
 这个Label用来展示标签指示处的值

 @return return value description
 */
-(UILabel *)markerValueLabel{
        
        if(!_markerValueLabel){
                
             _markerValueLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 35, 25)];
             _markerValueLabel.font = [UIFont systemFontOfSize:14.0];
             _markerValueLabel.textAlignment = NSTextAlignmentCenter;
             _markerValueLabel.textColor = [UIColor whiteColor];
             _markerValueLabel.backgroundColor = [UIColor grayColor];
        }
        return _markerValueLabel;
}


-(LineChartData *)setData{
        
        NSInteger xVals_count = 50;  //X轴上要显示多少条数据
        
        //X轴上面需要显示的数据
        NSMutableArray * xVals = [[NSMutableArray alloc] init];
        
        for (int i = 1; i <= xVals_count; i++) {
                
                if (i<30) {
                        
                        [xVals addObject: [NSString stringWithFormat:@"02-%d",i]];
                }else{
                        
                        [xVals addObject: [NSString stringWithFormat:@"03-%d",i-29]];
                }
        }
        
        // x轴的值的格式
        _lineChartView.xAxis.valueFormatter = [[DateValueFormatter alloc]initWithArr:xVals];
        
        //对应Y轴上面需要显示的数据
        NSMutableArray *yVals = [[NSMutableArray alloc] init];
        for (int i = 0; i < xVals_count; i++) {
                
                // 在0-100之内的随机数用来做Y轴的数值
                int a = arc4random() % 100;
                // deprecated 弃用    designated  指定
                ChartDataEntry * entry = [[ChartDataEntry alloc] initWithX:i y:a];
                
                [yVals addObject:entry];
        }
        
        LineChartDataSet *set1 = nil;
        //创建LineChartDataSet对象 再通过上面的yVals数组初始化LineChartDataSet对象
        set1 = [[LineChartDataSet alloc]initWithValues:yVals label:nil];
        //设置折线的样式
        set1.lineWidth = 2.0/[UIScreen mainScreen].scale;// 折线宽度
        
        set1.drawValuesEnabled = YES;                    // 是否在拐点处显示数据
        
        
        set1.valueFormatter = [[SetValueFormatter alloc]initWithArr:yVals];
        
        set1.valueColors    = @[[UIColor brownColor]];   // 折线拐点处显示数据的颜色
        
        [set1 setColor:[UIColor greenColor]];            // 折线颜色
        set1.highlightColor = [UIColor redColor];
        set1.drawSteppedEnabled = NO;//是否开启绘制阶梯样式的折线图
        
        //折线拐点样式
        set1.drawCirclesEnabled = NO;//是否绘制拐点
        set1.drawFilledEnabled  = NO;//是否填充颜色
        
        //将 LineChartDataSet 对象放入数组中
        NSMutableArray * dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        
        //添加第二个LineChartDataSet对象
        NSMutableArray *yVals2   = [[NSMutableArray alloc] init];
        for (int i = 0; i < xVals_count; i++) {
                
                int a = arc4random() % 80;
                // 数据
                ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:i y:a];
                [yVals2 addObject:entry];
        }
        
        LineChartDataSet * set2 = [set1 copy];
        set2.values = yVals2;
        set2.drawValuesEnabled  = NO;
        [set2 setColor:[UIColor blueColor]];
        
        [dataSets addObject:set2];
        
        // 创建 LineChartData 对象, 此对象就是lineChartView需要最终数据对象
        // 用dataSets数组初始化LineChartData对象，dataSets数组里面的元素是LineChartDataSet类型
        // 注意这个initWithDataSets:(NSArray<id <IChartDataSet>> * _Nullable)dataSets 传入的对象类型
        // 再看看点进去看看 LineChartDataSet 的类型
        LineChartData *data = [[LineChartData alloc]initWithDataSets:dataSets];
        
        [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:11.f]];//文字字体
        [data setValueTextColor:[UIColor blackColor]];//文字颜色
        
        return data;
        
}

-(void)chartValueSelected:(ChartViewBase * _Nonnull)chartView entry:(ChartDataEntry * _Nonnull)entry highlight:(ChartHighlight * _Nonnull)highlight{
        
        _markerValueLabel.text = [NSString stringWithFormat:@"%ld%%",(NSInteger)entry.y];
        //将点击的数据滑动到中间
        [_lineChartView centerViewToAnimatedWithXValue:entry.x yValue:entry.y axis:[_lineChartView.data getDataSetByIndex:highlight.dataSetIndex].axisDependency duration:1.0];
        
}

/*
-(void)chartValueNothingSelected:(ChartViewBase * _Nonnull)chartView{
 
}
-(void)chartScaled:(ChartViewBase * _Nonnull)chartView scaleX:(CGFloat)scaleX scaleY:(CGFloat)scaleY{
 
}
-(void)chartTranslated:(ChartViewBase * _Nonnull)chartView dX:(CGFloat)dX dY:(CGFloat)dY{

}
*/


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
