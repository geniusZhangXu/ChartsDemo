//
//  BarValueFormatter.h
//  ChartsDemo
//
//  Created by SKOTC on 2017/7/19.
//  Copyright © 2017年 CAOMEI. All rights reserved.
//

#import <Foundation/Foundation.h>
@import Charts;


@interface BarValueFormatter : NSObject <IChartAxisValueFormatter>


@property(nonatomic,strong) NSArray * valueArray;

-(id)initWithArray:(NSArray *)array;

@end
