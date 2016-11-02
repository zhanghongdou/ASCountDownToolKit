//
//  ASCountDownView.m
//  ASCountDownToolKit
//
//  Created by haohao on 16/10/28.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import "ASCountDownView.h"
#define CountDownViewWidth self.frame.size.width
#define CountDownViewHeight self.frame.size.height
@interface ASCountDownView ()
/*
 *time Label
 */
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, retain) dispatch_source_t timer;
@end
@implementation ASCountDownView

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

-(UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CountDownViewWidth, CountDownViewHeight)];
        _timeLabel.textColor = [UIColor colorWithRed:255.0 / 255.0 green:96.0 / 255.0 blue:97.0 / 255.0 alpha:1];
        _timeLabel.backgroundColor = [UIColor clearColor];
        _timeLabel.font = [UIFont systemFontOfSize:14];
        _timeLabel.adjustsFontSizeToFitWidth = YES;
        _timeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _timeLabel;
}

-(void)creatUI
{
    self.showType = ShowTimeTypeChineseDayHourMinuteSec;
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.timeLabel];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self countDownWithSpecificTime];
}


-(void)countDownWithSpecificTime
{
    if (_timer == nil) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
        dispatch_source_set_event_handler(_timer, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self startCountDown];
            });
        });
        dispatch_resume(_timer);
    }
}


//进行倒计时
-(void)startCountDown
{
    NSString *startTimeStr = self.endTime;
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:[NSDate date]];
    NSDate *currentDate = [[NSDate date] dateByAddingTimeInterval:interval];
    NSDateFormatter *formater = [[NSDateFormatter alloc]init];
    //这里需要注意传入的时间字符串的格式是否一致，否则会出错
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *startDate = [formater dateFromString:startTimeStr];
    NSDate *rightStartDate = [startDate dateByAddingTimeInterval:interval];
    NSTimeInterval timeInterval =[rightStartDate timeIntervalSinceDate:currentDate];
    [self setTimeStyleToShow:timeInterval];
}

-(void)setTimeStyleToShow:(NSTimeInterval)timeInterval
{
    int hours = (int)(timeInterval /  3600);
    int minutes = (int)(timeInterval - hours*3600)/60;
    int seconds = timeInterval - hours * 3600 - minutes * 60;
    
    int days2 = (int)(timeInterval / (3600 * 24));
    int hours2 = (int)((timeInterval - days2 * 24 * 3600) / 3600);
    int minutes2 = (int)(timeInterval - days2 * 24 * 3600 - hours2 * 3600) / 60;
    int seconds2 = timeInterval - days2 * 24 * 3600 - hours2 * 3600 - minutes2 * 60;
    
    NSString *dayStr;NSString *hoursStr;NSString *minutesStr;NSString *secondsStr;
    NSString *hoursStr2;NSString *minutesStr2;NSString *secondsStr2;
    dayStr = [NSString stringWithFormat:@"%02d", days2];
    
    hoursStr = [NSString stringWithFormat:@"%02d", hours];
    
    hoursStr2 = [NSString stringWithFormat:@"%02d", hours2];

    minutesStr = [NSString stringWithFormat:@"%02d",minutes];

    minutesStr2 = [NSString stringWithFormat:@"%02d", minutes2];
    
    secondsStr = [NSString stringWithFormat:@"%02d", seconds];
    
    secondsStr2 = [NSString stringWithFormat:@"%02d", seconds2];
    
    if (hours <= 0 && minutes <= 0 && seconds <= 0 && hours2 <= 0 && minutes2 <= 0 && seconds2 <= 0 && days2 <= 0) {
        [self destoryTimer];
        return;
    }
    
    switch (self.showType) {
        case ShowTimeTypeChineseHourMinuteSec:
            self.timeLabel.text = [NSString stringWithFormat:@"%@时%@分%@秒",hoursStr, minutesStr, secondsStr];
            break;
        case ShowTimeTypeColonDayHourMinuteSec:
            self.timeLabel.text = [NSString stringWithFormat:@"%@天%@:%@:%@", dayStr,hoursStr2, minutesStr2, secondsStr2];
            break;
        case ShowTimeTypeColonHourMinuteSec:
            self.timeLabel.text = [NSString stringWithFormat:@"%@:%@:%@",hoursStr, minutesStr, secondsStr];
            break;
        default:
            self.timeLabel.text = [NSString stringWithFormat:@"%@天%@时%@分%@秒", dayStr,hoursStr2, minutesStr2, secondsStr2];
            break;
    }
}

-(void)destoryTimer{
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
    self.timeLabel.text = @"活动结束";
    if (self.delegate) {
        [self.delegate CountDownViewFinised];
    }
    
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
}


@end
