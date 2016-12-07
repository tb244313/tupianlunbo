//
//  LoopViewLayout.m
//  tupianwuxianlunbo
//
//  Created by apple on 16/11/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LoopViewLayout.h"

@implementation LoopViewLayout
-(void)prepareLayout
{

    [super prepareLayout];
    
    //设置item尺寸
    self.itemSize = self.collectionView.frame.size;
    //设置滚动方向
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    //设置分页
    self.collectionView.pagingEnabled = YES;
    

    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
    
    //设置隐藏水平滚动条
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
}
@end
