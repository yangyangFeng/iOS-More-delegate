//
//  DelegateShare.h
//  多代理
//
//  Created by 邴天宇 on 5/4/16.
//  Copyright © 2016年 邴天宇. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol DelegateShareDelegate <NSObject>

- (void)response:(NSString *)str;

@end
@interface DelegateShare : NSObject
+ (DelegateShare *)shareInstance;
// 多代理 使用
@property (nonatomic, assign) id  <DelegateShareDelegate> delegate;
//测试 使用 标示是否 是用block 方式
@property (nonatomic, assign) BOOL isBlock;
//添加 block 监听, delegate 作为 观察者,不需要时 可移除
- (void)observer:(void (^)(NSString *str))sumBlok withDelegate:(id)delegate;
//移除 block 监听
- (void)removeObserver:(id)delegate;


#pragma mark - 触发多代理
- (void)changeString:(NSString *)str;

@end
