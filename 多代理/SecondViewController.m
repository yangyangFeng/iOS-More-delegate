//
//  SecondViewController.m
//  多代理
//
//  Created by 邴天宇 on 6/4/16.
//  Copyright © 2016年 邴天宇. All rights reserved.
//

#import "SecondViewController.h"

#import "DelegateShare.h"
@interface SecondViewController ()<DelegateShareDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation SecondViewController
{
    DelegateShare * delegate;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    delegate = [DelegateShare shareInstance];
    delegate.delegate = self;
    // Do any additional setup after loading the view.
}
//代理触发
-(void)response:(NSString *)str
{
    
    _label.text = str;
}
- (IBAction)btnDidAction:(id)sender {
    //触发 代理事件
    [delegate changeString:_textField.text];
}
- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
