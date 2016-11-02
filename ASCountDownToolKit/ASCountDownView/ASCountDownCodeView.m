//
//  ASCountDownCodeView.m
//  ASCountDownToolKit
//
//  Created by haohao on 16/11/2.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import "ASCountDownCodeView.h"
@interface ASCountDownCodeView ()
@property (nonatomic, strong) UIButton *codeBtn;
@property (nonatomic, retain) dispatch_source_t timer;
@end
@implementation ASCountDownCodeView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self creatUI];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self creatUI];
    }
    return self;
}

-(UIButton *)codeBtn
{
    if (!_codeBtn) {
        _codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _codeBtn.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        [_codeBtn setTitle:@"点击获取验证码" forState:UIControlStateNormal];
        _codeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_codeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_codeBtn addTarget:self action:@selector(openCountdown) forControlEvents:UIControlEventTouchUpInside];
    }
    return _codeBtn;
}

-(void)creatUI
{
    [self addSubview:self.codeBtn];
}

-(void)openCountdown{
    if (self.sendCodeBlock) {
        self.sendCodeBlock();
    }
    __block NSInteger time = 59;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(self.timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);

    dispatch_source_set_event_handler(self.timer, ^{
        if(time <= 0){
            dispatch_source_cancel(self.timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self destoryTimer];
                [self.codeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
                [self.codeBtn setTitleColor:[UIColor colorWithRed:251 / 255.0 green:133 / 255.0 blue:87 / 255.0 alpha:1] forState:UIControlStateNormal];
                self.codeBtn.userInteractionEnabled = YES;
            });
        }else{
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.codeBtn setTitle:[NSString stringWithFormat:@"重新发送(%.2d)", seconds] forState:UIControlStateNormal];
                [self.codeBtn setTitleColor:[UIColor colorWithRed:151 / 255.0 green:151 / 255.0 blue:151 / 255.0 alpha:1] forState:UIControlStateNormal];
                self.codeBtn.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(self.timer);
}

-(void)destoryTimer{
    if (self.timer) {
        dispatch_source_cancel(self.timer);
        self.timer = nil;
    }
}

- (void)drawRect:(CGRect)rect {
    
}

@end
