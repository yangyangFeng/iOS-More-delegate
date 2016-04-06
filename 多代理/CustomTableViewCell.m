//
//  CustomTableViewCell.m
//  多代理
//
//  Created by 邴天宇 on 5/4/16.
//  Copyright © 2016年 邴天宇. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

- (void)awakeFromNib {
    // Initialization code
   
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//         NSLog(@"%@",self);
        [[DelegateShare shareInstance] observer:^(NSString *str) {
            self.textLabel.text = [NSString stringWithFormat:@"block->%@",str];
        } withDelegate:self];
    }
    return self;
}
-(void)response:(NSString *)str
{
    self.textLabel.text = [NSString stringWithFormat:@"delegate->%@",str];;
}

-(void)dealloc
{
    [[DelegateShare shareInstance] removeObserver:self];
}
@end
