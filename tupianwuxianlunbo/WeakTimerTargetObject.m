//
//  WeakTimerTargetObject.m
//  tupianwuxianlunbo
//
//  Created by apple on 16/11/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "WeakTimerTargetObject.h"

@interface WeakTimerTargetObject ()
@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL selector;

@end
@implementation WeakTimerTargetObject
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo
{
    //创建当前类的对象
    WeakTimerTargetObject *object = [[WeakTimerTargetObject alloc] init];
    object.target = aTarget;
    object.selector = aSelector;
    
    return  [NSTimer scheduledTimerWithTimeInterval:ti target:aTarget selector:aSelector userInfo:userInfo repeats:yesOrNo];
}

-(void)fire:(id)obj
{

    [self.target performSelector:self.selector withObject:obj];
    
}
@end
