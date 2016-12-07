//
//  WeakTimerTargetObject.h
//  tupianwuxianlunbo
//
//  Created by apple on 16/11/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeakTimerTargetObject : NSObject
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo;

@end
