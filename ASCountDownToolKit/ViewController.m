//
//  ViewController.m
//  ASCountDownToolKit
//
//  Created by haohao on 16/10/28.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import "ViewController.h"
#import "ASCountDownView.h"
#import "ASCountDownCodeView.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet ASCountDownView *countView;
@property (weak, nonatomic) IBOutlet ASCountDownView *countView2;
@property (weak, nonatomic) IBOutlet ASCountDownView *countView3;
@property (weak, nonatomic) IBOutlet ASCountDownView *countView4;
@property (weak, nonatomic) IBOutlet ASCountDownCodeView *codeView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.countView.endTime = @"2016-11-11 10:10:10";
    
    self.countView2.endTime = @"2016-11-15 09:23:30";
    self.countView2.showType = ShowTimeTypeChineseHourMinuteSec;
    
    self.countView3.endTime = @"2016-11-20 10:22:20";
    self.countView3.showType = ShowTimeTypeColonDayHourMinuteSec;
    
    self.countView4.endTime = @"2016-11-16 10:15:26";
    self.countView4.showType = ShowTimeTypeColonHourMinuteSec;

    self.codeView.sendCodeBlock = ^{
        NSLog(@"验证码已发送到您的手机");
    };
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
