//
//  DelegateShare.m
//  多代理
//
//  Created by 邴天宇 on 5/4/16.
//  Copyright © 2016年 邴天宇. All rights reserved.
//

#import "DelegateShare.h"
#import <objc/runtime.h>


typedef void (^dataBlock)(NSString * data);
@interface DelegateShare ()
@property (nonatomic, strong) NSMutableDictionary* delegateCache;
@property (nonatomic, strong) NSPointerArray *weakRefTargets;
@property (nonatomic, strong) NSMutableDictionary* blocks;
@property (nonatomic, copy) void (^block)(NSString * str);
@end
@implementation DelegateShare
+ (DelegateShare *)shareInstance
{
    static DelegateShare * share;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [DelegateShare new];
    });
    return share;
}
-(NSMutableDictionary *)delegateCache
{
    if (_delegateCache) {
        _delegateCache = [NSMutableDictionary dictionary];
    }
    return _delegateCache;
}
-(NSMutableDictionary *)blocks
{
    if (!_blocks) {
        _blocks = [NSMutableDictionary dictionary];
    }
    return _blocks;
}
-(NSPointerArray *)weakRefTargets
{
    if (!_weakRefTargets) {
        _weakRefTargets = [NSPointerArray weakObjectsPointerArray];
    }
    return _weakRefTargets;
}
#pragma mark - 多 block 传递
/**
 *  添加监听
 *
 */
- (void)observer:(void (^)(NSString *str))sumBlok withDelegate:(id)delegate
{
    NSObject* obj = (NSObject*)delegate;
    if (sumBlok && delegate) {
        [self.blocks setObject:sumBlok forKey:[NSString stringWithFormat:@"%lu", (unsigned long)obj.hash]];
    }
    else {
        NSLog(@"参数不能为空!");
    }
}
/**
 *  移除监听
 */
- (void)removeObserver:(id)delegate
{
    if (delegate) {
        NSObject* obj = (NSObject*)delegate;
        
        [self.blocks removeObjectForKey:[NSString stringWithFormat:@"%lu", (unsigned long)obj.hash]];
        NSLog(@"---->%@ 已移除", delegate);
    }
}

#pragma mark - 多代理
-(void)setDelegate:(id<DelegateShareDelegate>)delegate
{
    if ([delegate respondsToSelector:@selector(response:)]) {
        [self.weakRefTargets addPointer:(__bridge void *)delegate];
    }
}

- (void)changeString:(NSString *)str
{
    if (_isBlock) {
        for (dataBlock block in self.blocks.allValues) {
            if (block) {
                block(str);
            }
        }
    }
    else{
        for (id target in self.weakRefTargets) {
            if ([target respondsToSelector:@selector(response:)]) {
                [target response:str];
            }
        }
    }
  
}

@end
