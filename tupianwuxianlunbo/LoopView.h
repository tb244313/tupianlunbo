//
//  LoopView.h
//  tupianwuxianlunbo
//
//  Created by apple on 16/11/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoopView : UIView
/**
 初始化方法
 
 @param URLStrs    图片数组（数组中装的都是图片字符串）
 @param titles 标题数组
 
 @return 轮播器对象
 */
-(instancetype)initWihtURLStrs:(NSArray *)URLStrs titles:(NSArray *)titles;
@end
