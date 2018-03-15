//
//  SlotMachineRollView.h
//  KKSlotMachineView
//
//  Created by hello on 2018/3/13.
//  Copyright © 2018年 hello. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MachineStopBlock)(void);

@interface SlotMachineRollView : UIView

@property(nonatomic,assign)NSInteger number;
@property(nonatomic, copy) MachineStopBlock stopBlock;
@property(nonatomic,assign)BOOL isShouldStop;              //判断是否要停止滚动
@property(nonatomic,assign)BOOL isAlreadyRollToNumber;     //判断是否是最后一圈 主要作用在于延迟与上一个号码停止的时间差

-(void)start;  //调用滚动

@end
