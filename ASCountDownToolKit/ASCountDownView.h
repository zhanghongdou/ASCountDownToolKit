//
//  ASCountDownView.h
//  ASCountDownToolKit
//
//  Created by haohao on 16/10/28.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, ShowTimeType) {
    ShowTimeTypeChineseDayHourMinuteSec    = 1,//default   显示格式为00天00时00分00秒
    ShowTimeTypeChineseHourMinuteSec       = 2,//00时00分00秒
    ShowTimeTypeColonDayHourMinuteSec    = 3,//00天 00:00:00
    ShowTimeTypeColonHourMinuteSec,          //00:00:00
};
@protocol CountDownViewDelegate <NSObject>
-(void)CountDownViewFinised;
@end
@interface ASCountDownView : UIView
@property (nonatomic, weak) id<CountDownViewDelegate>delegate;
@property (nonatomic, assign) ShowTimeType showType;
@property (nonatomic, copy) NSString *endTime;
@end
