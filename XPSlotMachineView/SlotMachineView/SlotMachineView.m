//
//  SlotMachineView.m
//  KKSlotMachineView
//
//  Created by hello on 2018/3/13.
//  Copyright © 2018年 hello. All rights reserved.
//

#import "SlotMachineView.h"
#import "SlotMachineRollView.h"

@interface SlotMachineView()

@property(nonatomic,strong)NSMutableArray <SlotMachineRollView *>*rollViewArr;
@property(nonatomic,strong)UILabel *hundredMillionLabel;
@property(nonatomic,strong)UILabel *tenThousandLabel;

@end

@implementation SlotMachineView

- (instancetype)initWithFrame:(CGRect)frame initialNumbers:(NSString *)initialNumberStr{
    
    if(self = [super initWithFrame:frame]){
        [self setupUIWithinitialNumbers:initialNumberStr andFrame:frame];
    }
    return self;
}

-(void)setupUIWithinitialNumbers:(NSString *)initialNumberStr andFrame:(CGRect)frame{
    
    CGFloat width = 20;
    CGFloat margain = 0;
    NSMutableArray *initialNumbers = [NSMutableArray array];
    for(int j = 0;j < initialNumberStr.length;j++){
        NSString *subStr =  [initialNumberStr substringWithRange:NSMakeRange(j, 1)];
        [initialNumbers addObject:subStr];
    }
    self.rollViewArr = [NSMutableArray array];
    //根据位数判断 大于4位数 即是亿
    if(initialNumberStr.length > 4){
        margain = ([UIScreen mainScreen].bounds.size.width  - (initialNumberStr.length + 2) * (width + 5))/2;
        NSInteger count = initialNumberStr.length - 4;
        for(int i = 0;i < initialNumbers.count + 2;i++){
            
            if(count == i || i == initialNumbers.count + 1){
                if(count == i){
                    //添加亿label
                    [self addSubview: self.hundredMillionLabel];
                    self.hundredMillionLabel.frame = CGRectMake(margain + (width + 5) * i, frame.origin.y, width, 30);
                    self.hundredMillionLabel.text = @"亿";
                }else{
                    //添加万label
                    [self addSubview:self.tenThousandLabel];
                    self.tenThousandLabel.frame = CGRectMake(margain + (width + 5) * i, frame.origin.y, width, 30);
                    self.tenThousandLabel.text = @"万";
                }
                
            }else{
                
                SlotMachineRollView *rollView = [[SlotMachineRollView alloc]initWithFrame:CGRectMake(margain + (width + 5) * i, frame.origin.y, width, 30)];
                [self addSubview:rollView];
                if(i < count){
                    rollView.number = [initialNumbers[i] integerValue];
                }else if(i > count && count){
                    rollView.number = [initialNumbers[i - 1] integerValue];
                }
                
                [self.rollViewArr addObject:rollView];
            }
        }
    }else{
        margain = ([UIScreen mainScreen].bounds.size.width  - (initialNumberStr.length + 1) * (width + 5))/2;
        for(int i = 0;i < initialNumbers.count + 1;i++){
            if(i == initialNumbers.count){
                [self addSubview:self.tenThousandLabel];
                self.tenThousandLabel.frame = CGRectMake(margain + (width + 5) * i, frame.origin.y, width, frame.size.height);
                self.tenThousandLabel.text = @"万";
            }else{
                SlotMachineRollView *rollView = [[SlotMachineRollView alloc]initWithFrame:CGRectMake(margain + (width + 5) * i, frame.origin.y, width, 30)];
                [self addSubview:rollView];
                rollView.number = [initialNumbers[i] integerValue];
                [self.rollViewArr addObject:rollView];
            }
            
        }
    }
    
}

-(void)reloadDataWithNumbersStr:(NSString *)numberStr{
    
    NSMutableArray *numbers = [NSMutableArray array];
    for(int j = 0;j < numberStr.length;j++){
        NSString *subStr =  [numberStr substringWithRange:NSMakeRange(j, 1)];
        [numbers addObject:subStr];
    }
    
    //移除所有空间 再重新添加
    for(UIView *view in self.subviews){
        [view removeFromSuperview];
    }
    [self setupUIWithinitialNumbers:numberStr andFrame:self.frame];

    for(int i = 0;i < self.rollViewArr.count;i++){
        SlotMachineRollView *rollView = _rollViewArr[i];
        rollView.number = [numbers[i] integerValue];
        [rollView start];
        
        __weak typeof(self) weakSelf = self;
        rollView.stopBlock = ^{
            
            weakSelf.rollViewArr[i].isAlreadyRollToNumber = NO;
            if(i < self.rollViewArr.count - 1){
                weakSelf.rollViewArr[i+1].isShouldStop = YES;
            }
        };
        if(i == 0){
            //第一个要先设置需要停止 不然会持续滚动
            rollView.isShouldStop = YES;
        }
    }
}

-(UILabel *)hundredMillionLabel{
    if(_hundredMillionLabel == nil){
        _hundredMillionLabel = [UILabel new];
        _hundredMillionLabel.textColor = [UIColor redColor];
        _hundredMillionLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _hundredMillionLabel;
}

-(UILabel *)tenThousandLabel{
    if(_tenThousandLabel == nil){
        _tenThousandLabel = [UILabel new];
        _tenThousandLabel.textColor = [UIColor redColor];
        _tenThousandLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tenThousandLabel;
}

@end
