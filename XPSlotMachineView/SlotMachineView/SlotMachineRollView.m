//
//  SlotMachineRollView.m
//  KKSlotMachineView
//
//  Created by hello on 2018/3/13.
//  Copyright © 2018年 hello. All rights reserved.
//

#import "SlotMachineRollView.h"
#import "SlotMachineTableViewCell.h"

@interface SlotMachineRollView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *dataSource;
@property(nonatomic,assign)NSInteger firstNumber;
@end

@implementation SlotMachineRollView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        self.tableView = [UITableView new];
        self.tableView.frame = self.bounds;
        [self addSubview:self.tableView];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.bounces = NO;
        //防止滚动不准确发生偏移 需要添加以下三句代码
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
        self.tableView.userInteractionEnabled = NO;
        
        [self.tableView registerClass:[SlotMachineTableViewCell class] forCellReuseIdentifier:@"slotMachineCell"];
        self.firstNumber = -1;
    }
    return self;
}

-(void)setNumber:(NSInteger)number{
    _number = number;
    
    if(self.firstNumber < 0){
        self.firstNumber = number;
        self.dataSource = @[[NSString stringWithFormat:@"%zd",number]];
    }else{
        NSMutableArray *mutableArr = [NSMutableArray array];
        
        for(NSInteger i = self.firstNumber;i <= 9;i++){
            [mutableArr addObject:[NSString stringWithFormat:@"%zd",i]];
        }
        for(NSInteger k = 0;k <= 9;k++){
            [mutableArr addObject:[NSString stringWithFormat:@"%zd",k]];
        }
        for (NSInteger j = 0; j <= self.number; j++) {
            [mutableArr addObject:[NSString stringWithFormat:@"%zd",j]];
        }
        self.dataSource = mutableArr.copy;
        self.firstNumber = number;
    }
    [self.tableView reloadData];
}

-(void)start{

    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataSource.count-1 inSection:0] atScrollPosition: UITableViewScrollPositionBottom animated:YES];
}

-(void)continueRoll{
    //先滚动到初始cell 再重新滚动
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition: UITableViewScrollPositionBottom animated:NO];
    [self start];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if(_isShouldStop){
        if(!self.isAlreadyRollToNumber){
            //判断是否是最后一圈 主要作用在于延迟与上一个号码停止的时间差 让其再滚动一圈
            self.isAlreadyRollToNumber = YES;
            [self continueRoll];
        }else{
            if(self.stopBlock){
                self.stopBlock();
            }
        }
    }else{
        [self continueRoll];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SlotMachineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"slotMachineCell" forIndexPath:indexPath];
    cell.titleString = self.dataSource[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}

@end
