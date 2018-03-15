//
//  SlotMachineView.h
//  KKSlotMachineView
//
//  Created by hello on 2018/3/13.
//  Copyright © 2018年 hello. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlotMachineView : UIView


/**
 自定义方法

 @param frame frame
 @param initialNumberStr 初始化字符串
 @return instancetype
 */
- (instancetype)initWithFrame:(CGRect)frame initialNumbers:(NSString *)initialNumberStr;


/**
 刷新数据

 @param numberStr 刷新数据的数字字符串
 */
-(void)reloadDataWithNumbersStr:(NSString *)numberStr;

@end
