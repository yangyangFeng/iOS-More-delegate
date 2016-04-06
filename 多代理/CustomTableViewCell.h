//
//  CustomTableViewCell.h
//  多代理
//
//  Created by 邴天宇 on 5/4/16.
//  Copyright © 2016年 邴天宇. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DelegateShare.h"
@interface CustomTableViewCell : UITableViewCell <DelegateShareDelegate>
@end
