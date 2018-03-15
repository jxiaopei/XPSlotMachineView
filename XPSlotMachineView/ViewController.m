//
//  ViewController.m
//  KKSlotMachineView
//
//  Created by hello on 2018/3/13.
//  Copyright © 2018年 hello. All rights reserved.
//

#import "ViewController.h"
#import "SlotMachineView.h"

@interface ViewController ()

@property(nonatomic,strong)SlotMachineView *slotMachineView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.slotMachineView = [[SlotMachineView alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 30) initialNumbers:@"0000000"];
    [self.view addSubview:self.slotMachineView];
}

-(IBAction)didClickBtn:(id)sender{
    [self.slotMachineView reloadDataWithNumbersStr:@"1234567"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
