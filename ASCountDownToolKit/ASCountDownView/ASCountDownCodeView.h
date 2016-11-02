//
//  ASCountDownCodeView.h
//  ASCountDownToolKit
//
//  Created by haohao on 16/11/2.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^SendCodeBlock)();
@interface ASCountDownCodeView : UIView
@property (nonatomic, copy) SendCodeBlock sendCodeBlock;
@end
