//
//  SlotMachineTableViewCell.m
//  KKSlotMachineView
//
//  Created by hello on 2018/3/13.
//  Copyright © 2018年 hello. All rights reserved.
//

#import "SlotMachineTableViewCell.h"

@interface SlotMachineTableViewCell()

@property(nonatomic,strong)UILabel *titleLabel;

@end

@implementation SlotMachineTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubViews];
    }
    return self;
}

-(void)setTitleString:(NSString *)titleString{
    _titleString = titleString;
    _titleLabel.text = titleString;
}

-(void)addSubViews{
    
    UIImageView *bgImageView = [UIImageView new];
    [self addSubview:bgImageView ];
    bgImageView.frame = CGRectMake(0, 0, 20, 30);
    bgImageView.image = [UIImage imageNamed:@"lottery-trend-cellBg"];
    
    UILabel *titleLabel = [UILabel new];
    [self addSubview:titleLabel];
    _titleLabel = titleLabel;
    _titleLabel.frame = CGRectMake(0, 0, 20, 30);
    titleLabel.adjustsFontSizeToFitWidth = YES;
    titleLabel.textColor = [UIColor redColor];
    titleLabel.text = @"1";
    titleLabel.textAlignment = NSTextAlignmentCenter;
}


@end
