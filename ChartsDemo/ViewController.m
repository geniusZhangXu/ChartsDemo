//
//  ViewController.m
//  ChartsDemo
//
//  Created by SKOTC on 17/6/26.
//  Copyright © 2017年 CAOMEI. All rights reserved.
//

#import "ViewController.h"
#import "LineViewController.h"
#import "BarChartViewController.h"
#import "PieViewController.h"
#import "RadarChartViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
        
        [super viewDidLoad];
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor =[UIColor whiteColor];
        
        // 折线
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"折线" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.frame = CGRectMake(100, 100, 60, 60);
        [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
        
        
        // 柱状
        UIButton * button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [button1 setTitle:@"柱状" forState:UIControlStateNormal];
        [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button1 .frame = CGRectMake(200, 100, 60, 60);
        [button1   addTarget:self action:@selector(buttonClick1) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button1 ];
        
        
        // 饼状
        UIButton * button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [button2 setTitle:@"饼状" forState:UIControlStateNormal];
        [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button2 .frame = CGRectMake(100, 250, 60, 60);
        [button2   addTarget:self action:@selector(buttonClick2) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button2 ];
        
        
        // 雷达
        UIButton * button3 = [UIButton buttonWithType:UIButtonTypeCustom];
        [button3 setTitle:@"雷达" forState:UIControlStateNormal];
        [button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button3 .frame = CGRectMake(200, 250, 60, 60);
        [button3   addTarget:self action:@selector(buttonClick3) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button3 ];
        
        
}


-(void)buttonClick{

        LineViewController * lineViewController = [[LineViewController alloc]init];
        [self presentViewController:lineViewController animated:YES completion:NULL];
}


-(void)buttonClick1{
        
        BarChartViewController * barChartViewController = [[BarChartViewController alloc]init];
        [self presentViewController:barChartViewController animated:YES completion:NULL];
}


-(void)buttonClick2{
        
        PieViewController * pieViewController = [[PieViewController alloc]init];
        [self presentViewController:pieViewController animated:YES completion:NULL];
}


-(void)buttonClick3{
        
        RadarChartViewController * radarChartViewController = [[RadarChartViewController alloc]init];
        [self presentViewController:radarChartViewController animated:YES completion:NULL];
}



-(void)didReceiveMemoryWarning {
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.  
        
        
}


@end
