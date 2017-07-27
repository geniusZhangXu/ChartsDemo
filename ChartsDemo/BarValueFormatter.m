//
//  BarValueFormatter.m
//  ChartsDemo
//
//  Created by SKOTC on 2017/7/19.
//  Copyright © 2017年 CAOMEI. All rights reserved.
//

#import "BarValueFormatter.h"

@implementation BarValueFormatter

-(id)initWithArray:(NSArray *)array{

        self = [super init];
        if (self) {
                
               _valueArray = array;
        }
        return self;
}

//返回X轴的数据
- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis{
        
        if (value< 12 && value >=0) {
                
                 return _valueArray[(NSInteger)value];
        }else
                 return @"";
       
}

@end
