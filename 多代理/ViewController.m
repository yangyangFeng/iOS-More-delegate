//
//  ViewController.m
//  多代理
//
//  Created by 邴天宇 on 5/4/16.
//  Copyright © 2016年 邴天宇. All rights reserved.
//

#import "CustomTableViewCell.h"
#import "ViewController.h"
@interface ViewController () <UITableViewDataSource, UITableViewDelegate, DelegateShareDelegate>

@property (weak, nonatomic) IBOutlet UITextField* textField;
@property (weak, nonatomic) IBOutlet UITableView* tableView;
@property (nonatomic, strong) DelegateShare* shareDelegate;
@property (weak, nonatomic) IBOutlet UISwitch* switchBtn;

@end

@implementation ViewController
- (DelegateShare*)shareDelegate
{
    if (!_shareDelegate) {
        _shareDelegate = [DelegateShare shareInstance];
    }
    return _shareDelegate;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.shareDelegate.delegate = self;
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    CustomTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"customcell"];
    if (!cell) {
        cell = [[CustomTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"customcell"];
    }
    self.shareDelegate.delegate = cell;
    return cell;
}

- (void)response:(NSString*)str
{
    NSLog(@"class->%@",[self class]);
}

- (IBAction)cwitchChangeAction:(id)sender
{
    self.shareDelegate.isBlock = !_switchBtn.on;
}

- (IBAction)btnDidAction:(id)sender
{
    //触发 代理事件
    [self.shareDelegate changeString:_textField.text];
}

@end
